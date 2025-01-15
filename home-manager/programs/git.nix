{
  pkgs,
  config,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  programs.gh = {
    enable = true;
    extensions = []; # TODO add copiolt later
  };

  programs.git = {
    enable = true;
    userName = "0xmycf";
    userEmail = "mycf.mycf.mycf@gmail.com";
    aliases = {
      cane = "commit --amend --no-edit";
      s = "status";
      new = "init -b main";
      tree = "log --graph --pretty=oneline --abbrev-commit";
    };

    includes = [
      {
        path = "${homeDir}/.config/WingChun/.gitconfig";
        condition = "gitdir:~/Documents/WingChun/";
      }
    ];

    ignores = [
      ".DS_Store"
      "result"
      "result/"
      ".metals/"
      "Session.vim"
    ];
    # hooks = []; # TODO
  };

  xdg.configFile.WingChun = {
    source = ./../.config/private/wc-submodules/.gitconfig;
    target = "WingChun/.gitconfig";
  };
}
