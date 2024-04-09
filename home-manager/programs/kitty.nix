{
  config,
  pkgs,
  ...
}: {
  xdg.configFile.kitty = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-darwin/home-manager/.config/kitty";
    recursive = true;
  };

  # fonts.program-specific = [pkgs.julia-mono];
}
