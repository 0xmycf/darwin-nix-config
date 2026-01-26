{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.fonts.kp-fonts;
in {
  options = {
    fonts.kp-fonts = {
      enable = lib.mkEnableOption "kp-fonts";
    };
  };

  config =
    lib.mkIf cfg.enable
    (let
      kp-font = pkgs.stdenvNoCC.mkDerivation {
        pname = "KpFont";
        version = "1";

        src = pkgs.fetchzip {
          url = "https://mirrors.ctan.org/fonts/kpfonts-otf.zip";
          hash = "sha256-m2xL8GT5kDn0ocSmJBS2AA9Uao/3SQxpQSba6by3twY=";
        };

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
      home.packages = [kp-font];
    });
}
