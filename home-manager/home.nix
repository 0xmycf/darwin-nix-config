{pkgs, ...}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "mycf";
    homeDirectory = "/Users/mycf";
    stateVersion = "23.11";
  };

  imports = [
    ./options.nix
    ./programs # programs imports all programs
  ];

  home.packages = with pkgs; [
    alejandra # nix formatter

    tldr

    tree
    watchexec
    pandoc
    openconnect

    # this is a cask on macos
    # neovide

    # brews because some build error here
    # haskellPackages.ghcup
  ];
}
