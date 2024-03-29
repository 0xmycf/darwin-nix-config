#
# homebrew is still used for casks (gui)
#
{...}: {
  homebrew = {
    global.autoUpdate = false;
    enable = true;

    # TODO discord
    casks = import ./casks.nix;
    # app store apps
    masApps = import ./mas.nix;
    taps = [];
    brews = [];
  };
}
