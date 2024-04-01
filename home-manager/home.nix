{pkgs, ...}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "mycf";
    homeDirectory = "/Users/mycf/";
    stateVersion = "23.11";
  };

  imports = [
    ./programs
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/fish
    ./programs/neovim
  ];

  programs.fish.shellAliases = {
    barfoo = "echo 'Hello, world!'";
  };

  home.packages = with pkgs; [
    alejandra # nix formatter

    tldr

    tree
    watchexec
    pandoc

    # this is a cask on macos
    # neovide

    # brews because some build error here
    # haskellPackages.ghcup
  ];
}
