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

  monolisa = pkgs.stdenvNoCC.mkDerivation {
    pname = "MonoLisa";
    version = "1";

    src = pkgs.fetchzip {
      # this is a local fileserver on my raspberry pi
      url = "http://192.168.0.227:3333/data/monolisa.zip";
      hash = "sha256-RzHjXCaFGUdRGjEkyVJDyY7OsWG8sqKsCGcZyBPmmPU=";
    };

    installPhase = ''
      mkdir -p $out/share/fonts
      cp -R $src $out/share/fonts/opentype/
    '';

    meta = with lib; {
      description = "MonoLisa - font follows function";
      homepage = "https://monolisa.dev";
      license = licenses.unfree;
    };
  };
in {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira-code # NOTE: has no italics
    cascadia-code
    atkinson-hyperlegible
    kp-font # my standard tex font

    julia-mono # used by kitty/fish
    jetbrains-mono

    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})

    monolisa
  ];
}
