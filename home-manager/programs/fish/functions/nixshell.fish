set -l packages ""
for x in $argv
    set packages $packages "nixpkgs#"$x
end

# for editing the prompt
set -x IN_NIX_SHELL 1

nix shell $packages
