for x in $argv
    set packages $packages "nixpkgs#"$x
end

# for editing the prompt
set -x IN_NIX_SHELL 1

# just to show whats in there
set_color red
printf "packages are: [ $packages ]\n"
set_color normal

nix shell $packages
