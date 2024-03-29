{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ../../.config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nodejs_20
      nil
    ];

    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };
}
