{
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

  xdg.configFile.linearmouse = {
    source = ../.config/linearmouse;
    recursive = true;
  };
}
