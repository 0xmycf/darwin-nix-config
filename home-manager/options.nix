{lib, ...}: {
  options = {
    nvimPathOpt = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "Path to the nvim executable";
    };
  };

  # config = { };
}
