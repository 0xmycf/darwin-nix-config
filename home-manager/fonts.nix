{pkgs, ...}: {
  imports = [
    ./fonts
  ];

  fonts.fontconfig.enable = true;

  # see ./fonts/default.nix
  # for more information
  # TLDR: these add monolisa and kp-fonts to home.packages
  fonts = {
    monolisa.enable = true;
    kp-fonts.enable = true;
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
