#
# homebrew is still used for casks (gui)
#
{...}: {
  homebrew = {
    global.autoUpdate = false;
    enable = true;

    # TODO discord
    casks = import ./casks.nix;
    taps = [];
    brews = [];
  };
}
