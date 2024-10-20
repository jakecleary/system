{ pkgs, config, lib, ... }: 
{
  # Allow unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # System wide nixpkgs packages
  ##############################

  environment.systemPackages = with pkgs;
  [ 
    gh
    git
    gleam
    hack-font
    kitty
    mkalias
    neofetch
    obsidian
    raycast
    spotify
    vim
    vscode
  ];

  # System wide homebrew packages
  ###############################

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "bitwarden"
      "google-chrome"
      "sublime-merge"
      "whatsapp"
    ];
  };

  # Dock prefs
  ############

  # Auto-hide the dock
  system.defaults.dock.autohide = true;

  # Clock settings
  ################

  system.defaults.menuExtraClock.IsAnalog = false;

  # Finder prefs
  ##############

  # Always show hidden files.
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  # Show file extensions in finder.
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  # Show status bar at bottom of finder windows with item/disk space stats.
  system.defaults.finder.ShowStatusBar = false;
  # Show "path bar" at the bottom of finder.
  system.defaults.finder.ShowPathbar = true;
  # Default to showing files in the "list view".
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  # Search across the entire mac by default.
  system.defaults.finder.FXDefaultSearchScope = "This Mac";
  # Show folder at the top of lists when sorting directories.
  system.defaults.finder._FXSortFoldersFirst = true;

  # System settings
  #################

  system.defaults.NSGlobalDomain = {
    # Switch between light and dark mode automatically based on time-of-day.
    AppleInterfaceStyleSwitchesAutomatically = true;
    # Allow tabbing through system menus.
    AppleKeyboardUIMode = 3;
    # Wait as little time as possible before repeating the same key.
    KeyRepeat = 2; # 120, 90, 60, 30, 12, 6, 2
    # Repeat the same key again as frequently as possible.
    InitialKeyRepeat = 15; # 120, 94, 68, 35, 25, 15
  };

  ## Custom preferences (not yet wrapped by nix-darwin)
  #####################################################

  system.defaults.CustomUserPreferences = {
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };
  };

  ## Universal access (accessibility stuff)
  #########################################

  # Reduce transparency
  system.defaults.universalaccess.reduceTransparency = true;

  # Tell OS to check for new settings after applying any changes
  ##############################################################

  # This hould allow us to avoid a logout/login cycle

  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Other
  #######

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}