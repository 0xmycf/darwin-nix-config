{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Golden-Delicous
    darwinConfigurations."Golden-Delicous" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = 
          [ ./configuration.nix
            ./mac-settings.nix
            ./kneipe/brew.nix
          ];
      specialArgs = { inherit inputs; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Golden-Delicous".pkgs;
  };
}
