{
  pkgs,
  config,
  inputs,
  ...
}: let
  # yanked from neovim/default.nix
  profileDirectory = config.home.profileDirectory;
  rpath = "${profileDirectory}/bin/r";
  janet = pkgs.janet;
  homeDir = config.home.homeDirectory;
  rustToolchain = pkgs.rust-bin.stable."1.97.1".default.override {
    extensions = ["rust-src" "rust-analyzer" "llvm-tools"];
  };
  ollamaRenamed = pkgs.buildEnv {
    name = "ollama-no-conflict";
    paths = [pkgs.ollama];
    pathsToLink = ["/bin"];

    # lets hope this doesn't break more stuff...
    postBuild = ''
      if [ -f $out/bin/generator ]; then
        mv $out/bin/generator $out/bin/ollama-generator
      fi
    '';
  };
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
    JANET_HEADERPATH = "${janet}/include";
    JANET_LIBPATH = "${janet}/lib";
    JANET_BINPATH = "${janet}/bin";
    RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
    LEDGER_FILE = "${homeDir}/documents/finances/f2026.journal";
  };

  home.packages = with pkgs; [
    alejandra # nix formatter

    tldr

    llama-cpp

    tree
    watchexec
    pandoc
    parallel # gnu parallel
    gnused # cause sed sucks on macos
    # this one is broken, last knwon rev with working version * 5a6c471 (HEAD -> main)  156   2024-07-22 09:54:15   (current)
    openconnect # vpn
    pdfgrep
    ffmpeg

    # Low Level stuff
    ## rust
    rustToolchain # cargo, rustc, rustfmt, clippy, rust-analyzer, rust-src, and llvm-tools
    ## zig
    zig

    ## L∃∀N
    # elan

    ## lisp that for scripts (?)
    janet
    jpm # janet project manager
    inputs.janet-lsp.packages.${pkgs.system}.default

    ## version control
    jujutsu

    # midnight commander
    # a cli file system manager
    # mc

    # finances
    hledger

    # local llms
    # ollama # TODO make this work again
    ollamaRenamed

    texliveMedium

    # for cloudflare services, such as tunnels
    cloudflared

    # because its nice to have a working version of python installed
    (python313.withPackages (
      ps:
        with ps; [
          numpy
          pandas
          polars
          matplotlib
          seaborn
          requests
        ]
    ))

    # sometimes I need ruby
    (ruby_3_4.withPackages (
      ps:
        with ps; [
          bundler
          ruby-lsp
          solargraph
        ]
    ))
    # solargraph

    # umlet # Free, open-source UML tool with a simple user interface

    # this is a cask on macos
    # neovide

    # brews because some build error here
    # haskellPackages.ghcup
  ];
}
