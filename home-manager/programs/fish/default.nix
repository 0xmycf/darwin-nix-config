{
  config,
  pkgs,
  lib,
  ...
}: {
  home.file = {
    ".config/fish/conf.d/omf.fish".source = ./omf.fish;
  };

  home.packages = [
    pkgs.oh-my-fish
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      fish_vi_key_bindings
      bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block
    '';

    functions = {
      fish_prompt = {
        body = builtins.readFile ./fish_prompt.fish;
      };
      zet = {
        body = builtins.readFile ./zet.fish;
      };
      now = {
        body = builtins.readFile ./now.fish;
      };
    };

    plugins = [
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "default";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-default";
          rev = "38a404d533f49c402f4a9212319ce70395d740d8";
          sha256 = "sha256-FVZhJo6BTz5Gt7RSOnXXU0Btxejg/p89AhZOvB9Xk1k=";
        };
      }
    ];

    shellAbbrs = {
      tea = "~/.local/bin/teatimer-ex";
      sshpi = "ssh pi@192.168.2.155";

      cc = "cd && clear";
      vim = "nvim";
      ls = "ls -GF";
      exa = "exa -l --icons --no-user --no-permissions";
      wordle = "open https://wordle.at";
      copium = "codium";
      dev = "nix develop --command fish";
      flake-new = "nix flake init --template github:vimjoyer/simple-template";

      devim = "nvim -u /Users/mycf/.config/nvim/dev.lua";

      # d   -- ~/Documents/
      # h   -- .
      dvim = "nvim (find /Users/mycf/Documents -type f -print | fzf)";
      dvide = "neovide (find /Users/mycf/Documents -type f -print | fzf)";
      hvim = "nvim (fzf)";
      hvide = "neovide (fzf)";
    };
  };
}