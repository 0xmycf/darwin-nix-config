{pkgs, ...}: {
  imports = [
    ./fonts
    # ./fonts/font-options.nix
  ];

  fonts.fontconfig.enable = true;

  # see ./fonts/default.nix
  # for more information
  # TLDR: these add monolisa and kp-fonts to home.packages
  fonts = {
    monolisa = {
      enable = true;
      # this is a local fileserver on my raspberry pi
      url = "http://192.168.0.227:3333/data/monolisa.zip";
    };
    # i can also use this inside a flake when doing a project
    kp-fonts.enable = false;
  };

  home.packages = with pkgs; [
    fira-code # NOTE: has no italics
    cascadia-code
    atkinson-hyperlegible

    jetbrains-mono

    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];
  # // fonts.program-specific;
}
