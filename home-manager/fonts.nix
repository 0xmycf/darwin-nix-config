{
  pkgs,
  lib,
  ...
}: let
  kp-font-data = pkgs.fetchzip {
    url = "https://mirrors.ctan.org/fonts/kpfonts-otf.zip";
    hash = "sha256-NneP21aeCqvKJDStt7Q9zaBCHVQtrjUlsasTBRp3p38=";
  };
  kp-font = pkgs.stdenvNoCC.mkDerivation {
    pname = "KpFont";
    version = "1";

    src = kp-font-data;

    installPhase = ''
      mkdir -p $out/share/fonts
      cp -R $src/fonts $out/share/fonts/opentype/
    '';

    meta = with lib; {
      description = "kpfonts – A complete set of fonts for text and mathematics";
      homepage = "https://ctan.org/pkg/kpfonts-otf";
      license = licenses.ofl;
    };
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
