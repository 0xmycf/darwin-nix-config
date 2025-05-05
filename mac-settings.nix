# some things cannot be set:
{...}: {
  users.users.mycf = {
    name = "mycf";
    home = "/Users/mycf";
  };

  system.defaults.dock = {
    magnification = true;
    largesize = 105;
    tilesize = 55;

    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.0;

    show-recents = false;

    orientation = "bottom";

    persistent-apps = [
      {
        app = "/System/Applications/Mail.app";
      }
      {
        app = "/Applications/Safari.app";
      }
      {
        app = "/Applications/Firefox.app";
      }
      {
        app = "/System/Applications/Music.app";
      }
      {
        app = "/System/Applications/Calendar.app";
      }
      {
        app = "/Applications/DXOPhotoLab6.app";
      }
      {
        app = "/Applications/Affinity Designer.app";
      }
      {
        app = "/Applications/Affinity Photo.app";
      }
      {
        app = "/Applications/Obsidian.app";
      }
      {
        app = "/Applications/kitty.app";
      }
    ];
  };

  # 0.875
  system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;

  system.defaults.NSGlobalDomain = {
    # nvim goes brrrr
    ApplePressAndHoldEnabled = false;
    KeyRepeat = 1;
    InitialKeyRepeat = 15;

    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;

    # i dont like dark mode
    AppleInterfaceStyleSwitchesAutomatically = false;

    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticCapitalizationEnabled = false;

    # sound
    "com.apple.sound.beep.feedback" = 0;
    "com.apple.sound.beep.volume" = 0.0;
  };

  system.defaults.trackpad = {
    TrackpadThreeFingerDrag = true;
    TrackpadRightClick = true;
  };

  system.defaults.finder = {
    # default search scope is current folder
    FXDefaultSearchScope = "SCcf";
    # preferred view is list view
    FXPreferredViewStyle = "Nlsv";
    # show breadcrumbs
    ShowPathbar = true;
    ShowStatusBar = false;
  };

  # ask for password immediately
  system.defaults.screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0;
  };

  system.defaults.screencapture = {
    # TODO I probably want to remove the tilde
    location = "~/Documents/screenshots";
    type = "png";
    disable-shadow = true;
  };

  system.defaults.loginwindow = {
    GuestEnabled = false;
  };

  system.defaults.WindowManager = {
    EnableStandardClickToShowDesktop = false;
    GloballyEnabled = false; # disable StageMangaer
    StandardHideDesktopIcons = true; # I wanna see my desktop
  };
}
