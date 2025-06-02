{
  description = "Example Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # managing the homebrew installation through nix
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    janet-lsp = {
      url = "github:0xmycf/nix-janet-lsp-wrapper";
      follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    home-manager,
    nix-darwin,
    nix-homebrew,
    janet-lsp,
    ...
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Golden-Delicous
    darwinConfigurations."Golden-Delicous" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./configuration.nix
        ./mac-settings.nix
        ./kneipe/brew.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mycf = import ./home-manager/home.nix;
          home-manager.backupFileExtension = ".home-manager.bak";
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
          home-manager.extraSpecialArgs = {inherit janet-lsp;};
        }

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "mycf";
          };
        }
      ];
      specialArgs = {inherit inputs;};
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Golden-Delicous".pkgs;
  };
}
