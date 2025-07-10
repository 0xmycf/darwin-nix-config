{
  imports = [
    ./neovim
    ./fish
    ./vscode
    ./other-nice-tools.nix
    ./git.nix
    ./kitty.nix
    ./haskell.nix
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
  programs.ripgrep.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
      italic-text = "always";
    };
  };

  programs.watson = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  xdg.configFile.linearmouse = {
    source = ../.config/linearmouse;
    recursive = true;
  };

  xdg.configFile.ghostty = {
    source = ../.config/ghostty;
    recursive = true;
  };

  xdg.configFile.rubocop = {
    text = ''
      Style/StringLiterals:
        Enabled: false
        EnforcedStyle: single_quotes
        SupportedStyles:
          - single_quotes
          - double_quotes

      AllCops:
        TargetRubyVersion: 3.4

      Style/StringLiterals:
        Enabled: false

      Layout/EmptyLinesAroundModuleBody:
        EnforcedStyle: empty_lines

      Layout/EmptyLinesAroundClassBody:
        EnforcedStyle: empty_lines

      Layout/EmptyLinesAroundMethodBody:
        Enabled: false

      Layout/EmptyLinesAroundBlockBody:
        Enabled: false
    '';
    target = "rubocop/config.yml";
  };
}
