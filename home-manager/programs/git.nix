{pkgs, ...}: {
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
      ec = "config --global -e";
      tree = "log --graph --pretty=oneline --abbrev-commit";
    };

    includes = [
      {
        path = "/Users/mycf/Documents/WingChun/.gitconfig";
        condition = "gitdir:~/Documents/WingChun/";
      }
    ];

    ignores = [
      ".DS_Store"
      "result"
      "result/"
    ];
    # hooks = []; # TODO
  };
}
