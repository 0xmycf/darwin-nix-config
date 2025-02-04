{
  pkgs,
  config,
  lib,
  ...
}: let
  homeDir = config.home.homeDirectory;
  # username = config.home.username;
in {
  home.file = {
    ".config/fish/conf.d/omf.fish".source = ./functions/omf.fish;
  };

  home.packages = [
    pkgs.oh-my-fish
  ];

  programs.fish = {
    enable = true;

    # FIXME: This is needed to address bug where the $PATH is re-ordered by
    # the `path_helper` tool, prioritising Apple tools over the ones we
    # installed with nix.
    #
    # This gist explains the issue in more detail: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
    # There is also an issue open for nix-darwin: https://github.com/LnL7/nix-darwin/issues/122
    loginShellInit = let
      # We should probably use `config.environment.profiles`, as described in
      # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
      # but this takes into account the new XDG paths used when the nix
      # configuration has `use-xdg-base-directories` enabled. See:
      # https://github.com/LnL7/nix-darwin/issues/947 for more information.
      profiles = [
        "/etc/profiles/per-user/$USER" # Home manager packages
        "$HOME/.nix-profile"
        "(set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)/nix/profile"
        "/run/current-system/sw"
        "/nix/var/nix/profiles/default"
      ];

      makeBinSearchPath =
        lib.concatMapStringsSep " " (path: "${path}/bin");
    in ''
      # Fix path that was re-ordered by Apple's path_helper
      fish_add_path --move --prepend --path ${makeBinSearchPath profiles}
      set fish_user_paths $fish_user_paths
    '';

    # TODO setup my-scripts with nix
    # TODO change my hard-coded username
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
        # this depends on the oh-my-fish (their lib specifically) being installed
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
        body = ''
          set -l now (date +%s)

          for x in $argv;
            mv $x ${homeDir}/.Trash/$now-$x;
          end;
        '';
      };
      vault-bib = {
        body = ''
          set -l path '${homeDir}/Library/Mobile Documents/icloud~md~obsidian/Documents/Tvault/attachments/vault.bib'
          nvim + $path
        '';
      };
      color-swap = {
        body = ''
          if test -z $argv
            echo "Usage: color-swap <theme>"
            return 1
          end

          # TODO we should probably link instead
          # we should also link from the nix config folder instead

          mv ${homeDir}/.config/kitty/current-theme.conf ${homeDir}/.config/kitty/current-theme.conf.bak || echo "No previous theme found"

          if test $argv[1] = "SpaceGray";
            ln -s ${homeDir}/.config/nix-darwin/home-manager/.config/kitty/Space\ Gray.conf ${homeDir}/.config/kitty/current-theme.conf
          else if test $argv[1] = "Catppuccin";
            ln -s ${homeDir}/.config/nix-darwin/home-manager/.config/kitty/Catppuccin-Latte.conf ${homeDir}/.config/kitty/current-theme.conf
          else
            echo "Theme not found"
            return 1
          end
        '';
      };
      nshell = {
        # this depends on the oh-my-fish (their lib secifically) being installed
        body = builtins.readFile ./functions/nixshell.fish;
      };
    };

    plugins = [];

    shellAbbrs = {
      # TODO install this via home-manager
      # tea = "${teatimer}/bin/teatimer";
      sshpi = "kitty +kitten ssh pi@192.168.2.45";

      fg = "fg %"; # this doesnt seem to work as I expect it

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

      hbat = "bat (fzf)";

      # exa = "exa -l --icons --no-user --no-permissions";
      #- copium = "codium";
    };
  };
}
