{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.gh = {
    enable = true;
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
      {
        path = "${homeDir}/.config/work/.gitconfig";
        condition = "gitdir:~/Documents/work/";
      }
    ];

    ignores = [
      ".DS_Store"
      "result"
      "result/"
      ".metals/"
      "Session.vim"

      # version control system
      ".git/"
      ".jj/"
    ];
    # hooks = []; # TODO
  };

  xdg.configFile.WingChun = {
    source = ./../.config/private/wc-submodules/.gitconfig;
    target = "WingChun/.gitconfig";
  };

  xdg.configFile.work = {
    source = ./../.config/private/arbeit-submodules/.gitconfig;
    target = "work/.gitconfig";
  };
}
