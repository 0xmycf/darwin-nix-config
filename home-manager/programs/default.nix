{
  imports = [
    ./neovim
    ./fish
    ./vscode
    ./my-haskell-tools.nix
    ./git.nix
    ./kitty.nix
  ];

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
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

  xdg.configFile.rubocop = {
    text = ''
      Style/StringLiterals:
        Enabled: false
        EnforcedStyle: single_quotes
        SupportedStyles:
          - single_quotes
          - double_quotes
    '';
    target = "rubocop/config.yml";
  };
}
