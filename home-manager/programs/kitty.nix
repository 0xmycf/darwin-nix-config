{config, ...}: {
  xdg.configFile.kitty = {
    source = config.lib.file.mkOutOfStoreSymlink ../.config/kitty;
    recursive = true;
  };
}
