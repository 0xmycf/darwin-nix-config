{
  pkgs,
  lib,
  ...
}: let
  kp-font = pkgs.fetchzip {
    url = "https://mirrors.ctan.org/fonts/kpfonts-otf.zip";
    hash = "sha256-NneP21aeCqvKJDStt7Q9zaBCHVQtrjUlsasTBRp3p38=";
  };
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira-code
    atkinson-hyperlegible
    cascadia-code
    kp-font
  ];
}
