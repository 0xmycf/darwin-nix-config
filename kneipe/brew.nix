
# 
# homebrew is still used for casks (gui)
#
{ ... }: {

  homebrew = {
    global.autoUpdate = false;
    enable = true;

    # TODO discord
    casks = import ./casks.nix;
    taps = [ ];
    brews = [
      "tldr" # apparently not in home.programs.<name> ?
      "tree" # apparently not in home.programs.<name> ?
      "watchexec" # apparently not in home.programs.<name> ?
    ];

  };
}
