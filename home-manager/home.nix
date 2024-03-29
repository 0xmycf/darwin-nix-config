{ pkgs, ...}: {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "mycf";
    homeDirectory = "/Users/mycf/";
    stateVersion = "23.11";
  };


  xdg.configFile.nvim = {  
    source = ./.config/nvim;  
    recursive = true;  
  };
  programs.neovim = (import ./programs/neovim.nix) { inherit pkgs; };

  programs.git = import ./programs/git.nix;
  programs.fish = (import ./programs/fish.nix) { inherit pkgs; };
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
  programs.gh = {
    enable = true;
    extensions = []; # TODO add copiolt later
  };
  programs.ripgrep.enable = true;

  # not in nix???
  # programs.tldr.enable = true;
  # programs.tree.enable = true;
  # programs.watchexec.enable = true;

}

