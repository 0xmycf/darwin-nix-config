
# 
# homebrew is still used for casks (gui)
#
{ ... }: {

  homebrew = {
    enable = true;

    casks = import ./casks.nix;
    taps = [ ];
    brews = [ ];

  };
}
