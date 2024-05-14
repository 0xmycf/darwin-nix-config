{
  config,
  pkgs,
  ...
}: let
  ts = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = ts.dependencies;
  };
  homeDir = config.home.homeDirectory;
  treesitterDir = "${homeDir}/.local/share/nvim/nix/nvim-treesitter/";
  nvim = pkgs.neovim-unwrapped;
  profileDirectory = config.home.profileDirectory;
  # I must use this insead of '${nvim}/bin/nvim' otherwise the extraPrograms
  # for nvim are not found (I don't know why)
  nvimPath = "${profileDirectory}/bin/nvim";
in {
  # I do this to avaoid the possibility of using the nvim installed by
  # homebrew a second time (via casks for neovide)
  programs.fish.shellAliases = {
    nvim = nvimPath;
  };

  xdg.configFile.neovide = {
    text = ''neovim-bin = "${nvimPath}"'';
    target = "neovide/config.toml";
  };

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/.config/nix-darwin/home-manager/.config/nvim";
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = nvimPath;
  };

  # this is technically not needed anymore, but its a good example
  # for my future self on how to set options with home-manager
  nvimPathOpt = nvimPath;

  programs.neovim = {
    enable = true;
    # setting this through home.sessionVariables,
    # because otherwise nvim from brew is used (nvim is dependency on neovide)
    defaultEditor = false;
    package = nvim;

    extraPackages = with pkgs; [
      nodejs_20
      nil
      lua-language-server
      pyright

      # its always good to have these installed outside of a flake
      # since those are common filetypes across projects and configs

      # this adds:
      # - vscode-css-language-server
      # - vscode-markdown-language-server
      # - vscode-eslint-language-server
      # - vscode-json-language-server
      # - vscode-html-language-server
      nodePackages_latest.vscode-langservers-extracted

      # bash
      shellcheck
      nodePackages_latest.bash-language-server

      yaml-language-server
    ];

    withNodeJs = true;
    withPython3 = true;

    plugins = [
      ts
    ];
  };

  # https://github.com/Kidsan/nixos-config/blob/main/home/programs/neovim/default.nix 125dd9f
  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file.${treesitterDir} = {
    recursive = true;
    source = ts;
  };

  home.file."${treesitterDir}/parser" = {
    recursive = true;
    source = "${parsers}/parser";
  };

  xdg.configFile."nvim-snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/.config/nix-darwin/home-manager/.config/nvim-snippets";
  };
}
