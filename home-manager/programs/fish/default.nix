{
  pkgs,
  config,
  lib,
  ...
}: let
  homeDir = config.home.homeDirectory;
  teatimerGithub = pkgs.fetchFromGitHub {
    owner = "0xmycf";
    repo = "SimpleTeaTimer";
    rev = "1613eddef4ebd4cf011ac819bc7c671d3fff88e5";
    sha256 = "sha256-UhQwNhsHkYTqapZ292sEPo95LvlqCUcrxLVH2V8C0rQ=";
  };

  teatimer = pkgs.haskellPackages.callCabal2nix "teatimer" teatimerGithub {};
  teatimerNoHaddock = pkgs.haskell.lib.dontHaddock teatimer;
in {
  # home.file = {
  #   ".config/fish/conf.d/omf.fish".source = ./functions/omf.fish;
  # };

  home.packages = [
    # pkgs.oh-my-fish
    teatimerNoHaddock
  ];

  programs.fish = {
    enable = true;

    # TODO setup my-scripts with nix
    interactiveShellInit = ''
      fish_add_path "${homeDir}/my-scripts/bin"


      fish_vi_key_bindings
      bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block
    '';

    functions = {
      fish_prompt = {
        # TDOO do i even need omf then?
        body = builtins.readFile ./functions/fish_prompt.fish;
      };
      zet = {
        # TODO setup obsidian
        body = (import ./functions/zet.fish.nix) {inherit homeDir;};
      };
      now = {
        body = builtins.readFile ./functions/now.fish;
      };
      mtt = {
        body = "mv $argv[1] ${homeDir}/.Trash/"; # macos probably TODO setup linux
      };
    };

    plugins = [
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      # {
      #   name = "default";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "oh-my-fish";
      #     repo = "theme-default";
      #     rev = "38a404d533f49c402f4a9212319ce70395d740d8";
      #     sha256 = "sha256-FVZhJo6BTz5Gt7RSOnXXU0Btxejg/p89AhZOvB9Xk1k=";
      #   };
      # }
    ];

    shellAbbrs = {
      # TODO install this via home-manager
      # tea = "${teatimer}/bin/teatimer";
      sshpi = "ssh pi@192.168.2.155";

      cc = "cd && clear";
      vim = "nvim";
      v = "nvim";
      ls = "ls -GF";
      wordle = "open https://wordle.at";

      dev = "nix develop --command fish";
      flake-new = "nix flake init --template github:the-nix-way/dev-templates#";
      my-flake = "nix flake init -t github:0xmycf/my-nix-flake-templates#";
      nixshell = "nix-shell --run fish -p ";

      devim = "nvim -u ${homeDir}/.config/nvim/dev.lua";

      # d   -- ~/Documents/
      # h   -- .
      dvim = "nvim (find ${homeDir}/Documents -type f -print | fzf)";
      dvide = "neovide (find ${homeDir}/Documents -type f -print | fzf)";
      hvim = "nvim (fzf)";
      hvide = "neovide (fzf)";

      # exa = "exa -l --icons --no-user --no-permissions";
      #- copium = "codium";
    };
  };
}
