{pkgs, ...}: {
  imports = [
    ./fonts
  ];

  fonts.fontconfig.enable = true;

  fonts = {
    monolisa.enable = true;
    kp-fonts.enable = false;
  };

  home.packages = with pkgs; [
    fira-code # NOTE: has no italics
    cascadia-code
    atkinson-hyperlegible

    julia-mono # used by kitty/fish
    jetbrains-mono

    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];
}
