#
# homebrew is still used for casks (gui)
#
{...}: {
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation.cleanup = "uninstall";

    casks = import ./casks.nix;
    # app store apps
    masApps = import ./mas.nix;
    taps = [];
    brews = [];
  };
}
