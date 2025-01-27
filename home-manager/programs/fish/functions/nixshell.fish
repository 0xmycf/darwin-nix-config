set -l packages ""
for x in $argv
    set packages "nixpkgs#"$x
end
nix shell $packages --command fish
