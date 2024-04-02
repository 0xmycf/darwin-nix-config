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
  nvimPath = "${profileDirectory}/bin/nvim";
in {
  # I should probably do it like this:
  # config.nvimAlias = "${profileDirectory}/bin/nvim";
  # but this doesn't work and I don't know how to get it working
  #
  # I do this to avaoid the possibility of nvim being installed by
  # brew a second time (via casks for neovide)
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

  # bash, does not work in fish
  home.sessionVariables = {
    EDITOR = nvimPath;
  };

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
}
