{
  pkgs,
  config,
  ...
}: let
  # yanked from neovim/default.nix
  profileDirectory = config.home.profileDirectory;
  rpath = "${profileDirectory}/bin/r";
in {
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
    ./fonts.nix
  ];

  home.sessionVariables = {
    RSTUDIO_WHICH_R = rpath;
  };

  home.packages = with pkgs; [
    alejandra # nix formatter

    tldr

    tree
    watchexec
    pandoc
    parallel # gnu parallel
    # this one is broken, last knwon rev with working version * 5a6c471 (HEAD -> main)  156   2024-07-22 09:54:15   (current)
    # openconnect # vpn
    pdfgrep

    # local llms
    ollama
    oterm

    texliveMedium

    # for cloudflare services, such as tunnels
    cloudflared

    # statistics
    # R
    (rWrapper.override {
      packages = with rPackages; [
        tidyverse
        readODS
        languageserver
        readxl
        xlsx
        DescTools
        nortest
      ];
    })
    gettext
    # rstudio (homebrew)
    # julia # might be relevant later on

    # because its nice to have a working version of python installed
    (python311.withPackages (ps: with ps; [numpy pandas polars matplotlib requests]))

    # sometimes I need ruby
    (ruby_3_2.withPackages (ps: with ps; [bundler ruby-lsp solargraph]))
    # solargraph

    # umlet # Free, open-source UML tool with a simple user interface

    # this is a cask on macos
    # neovide

    # brews because some build error here
    # haskellPackages.ghcup
  ];
}
