{
  pkgs,
  config,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  home.file = {
    ".config/fish/conf.d/omf.fish".source = ./functions/omf.fish;
  };

  home.packages = [
    pkgs.oh-my-fish
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
        # this depends on the oh-my-fish (their lib secifically) being installed
        body = builtins.readFile ./functions/fish_prompt.fish;
      };
      zet = {
        body = (import ./functions/zet.fish.nix) {inherit homeDir;};
      };
      lit = {
        body = (import ./functions/lit.fish.nix) {inherit homeDir;};
      };
      now = {
        body = builtins.readFile ./functions/now.fish;
      };
      mtt = {
        body = "mv $argv[1] ${homeDir}/.Trash/"; # macos probably TODO setup linux
      };
    };

    plugins = [];

    shellAbbrs = {
      # TODO install this via home-manager
      # tea = "${teatimer}/bin/teatimer";
      sshpi = "kitty +kitten ssh pi@192.168.2.45";

      cc = "cd && clear";
      vim = "nvim";
      v = "nvim";
      ls = "ls -GF";
      app = "open -jga";
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
