{ config, lib, pkgs, ... }:
{
  # The latest version as of time of me setting this up
  home.stateVersion = "24.05";

  home.username = "jake";
  home.homeDirectory = "/Users/jake";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages
  home.packages = with pkgs;
  [
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })
    gh
    git
    gleam
    helix
    neofetch
    obsidian
    raycast
    spotify
    starship
    vscode
  ];

  # Manage dotfiles.
  # (The primary way to manage plain files is through 'home.file'.)
  # TODO: Use this to configure kitty etc.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "Jake Cleary";
    userEmail = "shout@jakecleary.net";
    extraConfig = {
      github.user = "jakecleary";
      init = { defaultBranch = "master"; };
    };
    aliases = {
      uncommit = "reset HEAD^";
    };
    diff-so-fancy.enable = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prefer_editor_prompt = "disabled";
      prompt = "enabled";
      version = 1;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      # fonts
      font_family = "Hack";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 18.0;
      adjust_line_height = "150%";
      adjust_column_width = 0;
      disable_ligatures = "never";

      # theme - gruvbox dark
      background = "#282828";
      foreground = "#ebdbb2";
      cursor = "#928374";
      selection_foreground = "#928374";
      selection_background = "#3c3836";
      color0 = "#282828";
      color8 = "#928374";
      color1 = "#cc241d";
      color9 = "#fb4934";
      color2 = "#98971a";
      color10 = "#b8bb26";
      color3 = "#d79921";
      color11 = "#fabd2d";
      color4 = "#458588";
      color12 = "#83a598";
      color5 = "#b16286";
      color13 = "#d3869b";
      color6 = "#689d6a";
      color14 = "#8ec07c";
      color7 = "#a89984";
      color15 = "#928374";
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jake/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Custom PATH
  #############

  home.sessionPath = [
    "/Applications/Sublime Merge.app/Contents/SharedSupport/bin" # allow using Sublime Merge's 'smerge' command
  ];
}