{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.fonts.monolisa;
in {
  options = with lib; {
    fonts.monolisa = {
      enable = mkEnableOption "MonoLisa";
      url = mkOption {
        type = types.str;
        example = "http://192.168.0.227:8090/data/monolisa.zip";
      };
      hash = mkOption {
        type = types.str;
        example = lib.fakeHash;
      };
    };
  };

  config =
    lib.mkIf cfg.enable
    (let
      monolisa = pkgs.stdenvNoCC.mkDerivation {
        pname = "MonoLisa";
        version = "1";

        src = pkgs.fetchzip {
          url = cfg.url;
          hash = cfg.hash;
        };

        installPhase = ''
          mkdir -p $out/share/fonts
          cp -R $src $out/share/fonts/truetype/
        '';

        meta = with lib; {
          description = "MonoLisa - font follows function";
          homepage = "https://monolisa.dev";
          license = licenses.unfree;
        };
      };
    in {
      home.packages = [monolisa];
    });
}
