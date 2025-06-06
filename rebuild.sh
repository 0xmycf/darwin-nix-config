#! /usr/bin/env bash

# darwin-rebuild switch --flake .?submodules=1#Golden-Delicous

# source: https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5
#
# I believe there are a few ways to do this:
#
#    1. My current way, using a minimal /etc/nixos/configuration.nix that just imports my config from my home directory (see it in the gist)
#    2. Symlinking to your own configuration.nix in your home directory (I think I tried and abandoned this and links made relative paths weird)
#    3. My new favourite way: as @clot27 says, you can provide nixos-rebuild with a path to the config, allowing it to be entirely inside your dotfies, with zero bootstrapping of files required.
#       `nixos-rebuild switch -I nixos-config=path/to/configuration.nix`
#    4. If you uses a flake as your primary config, you can specify a path to `configuration.nix` in it and then `nixos-rebuild switch —flake` path/to/directory
# As I hope was clear from the video, I am new to nixos, and there may be other, better, options, in which case I'd love to know them! (I'll update the gist if so)

# A rebuild script that commits on a successful build
set -e

source ./vscode.sh

# Edit your config
# $EDITOR configuration.nix

echo "deleting ~/.config/ghostty/config"

mv ~/.config/ghostty/config ~/.config/ghostty/config.bak

# cd to your config dir
pushd ~/.config/nix-darwin/

# # Early return if no changes were detected (thanks @singiamtel!)
# if git diff --quiet '*.nix'; then
#     echo "No changes detected, exiting."
#     popd
#     exit 0
# fi

if ! git diff --quiet 'home-manager/.config/nvim-snippets/'; then
    echo "There are still changes in the nvim-snippets config folder."
    echo "Go to home-manager/.config/nvim-snippets/ and commit the changes."
    echo "cd home-manager/.config/nvim-snippets/ && git add . && git commit && git push" && cd ../../..
    exit 1
fi

# Autoformat your nix files
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

# Shows your changes
git diff -U0 '*.nix'

echo "Darwin-Nix Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
darwin-rebuild switch --flake .?submodules=1#Golden-Delicous || (cat darwin-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(darwin-rebuild --list-generations | grep current)

# fixVscode
echo "Fixing vscode settings..."
CODE=fixVscode
if [[ "$CODE" -eq 1 ]]; then
    echo "Moved an existing settings.json to a backup file next to it."
fi
echo "Done fixing vscode settings..."


# Commit all changes with the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
echo "Darwin-Nix Rebuilt OK!"
