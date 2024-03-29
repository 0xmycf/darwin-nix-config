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

  home.packages = with pkgs; [
    tldr
    tree
    watchexec
    alejandra # nix formatter
  ];
}
