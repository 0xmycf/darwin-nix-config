{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, ... }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Golden-Delicous
    darwinConfigurations."Golden-Delicous" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = 
      [ ./configuration.nix
        ./mac-settings.nix
        ./kneipe/brew.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jdoe = import ./home-manager/home.nix;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
      specialArgs = { inherit inputs; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Golden-Delicous".pkgs;
  };
}
