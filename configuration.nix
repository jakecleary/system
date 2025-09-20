{ pkgs, inputs, config, lib, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };
in
{
  # Allow unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # System wide nixpkgs packages
  ##############################

  environment.systemPackages = with pkgs;
  [
    zsh
    vim
  ];

  # System wide homebrew packages
  ###############################

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    # Makes sure nix-darwin.homebrew is aware of all declared taps (otherwise it tries to delete them!)
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "gleam"
    ];
    casks = [
      "bitwarden"
      "google-chrome"
      "onedrive"
      "pocket-casts"
      "raycast"
      "rekordbox"
      "sublime-merge"
      "whatsapp"
      "zoom"
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
  # Enlarge the mouse cursor
  system.defaults.universalaccess.mouseDriverCursorSize = 2.0;

  # Tell OS to check for new settings after applying any changes
  ##############################################################

  # This hould allow us to avoid a logout/login cycle

  system.activationScripts.postActivation.text = ''
    sudo -u jake /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # Other
  #######

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Setup user with fish shell
  users.users.jake = {
    uid = 501;
    name = "jake";
    home = "/Users/jake";
    shell = pkgs.fish;
  };
  users.knownUsers = ["jake"];
  system.primaryUser = "jake";

  # Shells
  ########
  
  # Add shells installed by nix to /etc/shells file
  environment.shells = [
    pkgs.bashInteractive
    pkgs.fish
    pkgs.zsh
  ];

  # Make Fish the default shell
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;
}