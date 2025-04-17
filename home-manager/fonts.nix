{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./fonts
    ./fonts/font-options.nix
  ];

  fonts.fontconfig.enable = true;

  # see ./fonts/default.nix
  # for more information
  # TLDR: these add monolisa and kp-fonts to home.packages
  fonts = {
    monolisa = {
      enable = true;
      # this is a local fileserver on my raspberry pi
      url = "http://192.168.0.227:8094/data/monolisa.zip";
      hash = "sha256-RzHjXCaFGUdRGjEkyVJDyY7OsWG8sqKsCGcZyBPmmPU=";
    };
    # i can also use this inside a flake when doing a project
    kp-fonts.enable = true;
  };

  home.packages = with pkgs;
    lib.lists.unique [
      fira-code # NOTE: has no italics
      cascadia-code
      jetbrains-mono

      atkinson-hyperlegible
    ]
    ++ config.fonts.program-specific;
}
