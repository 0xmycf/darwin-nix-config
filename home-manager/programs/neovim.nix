{ pkgs, ... }: {
  enable = false; 
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
}
