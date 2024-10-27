{ config, lib, pkgs, nix-colors, ... }:
{
  # The latest version as of time of me setting this up
  home.stateVersion = "24.05";

  home.username = "jake";
  home.homeDirectory = "/Users/jake";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Colour scheme
  ###############

  imports = [
    nix-colors.homeManagerModules.default
  ];

  # colour scheme IDs taken from:
  # https://github.com/tinted-theming/base16-schemes
  # Simply take the filename (without the .yaml suffix)
  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

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
      shell = "${pkgs.fish}/bin/fish --login --interactive";

      # fonts
      font_family = "Hack";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 18.0;
      adjust_line_height = "150%";
      adjust_column_width = 0;
      disable_ligatures = "never";

      # theme
      #######
      background = "#${config.colorScheme.palette.base00}";
      foreground = "#${config.colorScheme.palette.base05}";
      selection_background = "#${config.colorScheme.palette.base05}";
      selection_foreground = "#${config.colorScheme.palette.base00}";
      url_color = "#${config.colorScheme.palette.base04}";
      cursor = "#${config.colorScheme.palette.base05}";
      cursor_text_color = "#${config.colorScheme.palette.base00}";
      active_border_color = "#${config.colorScheme.palette.base03}";
      inactive_border_color = "#${config.colorScheme.palette.base01}";
      active_tab_background = "#${config.colorScheme.palette.base00}";
      active_tab_foreground = "#${config.colorScheme.palette.base05}";
      inactive_tab_background = "#${config.colorScheme.palette.base01}";
      inactive_tab_foreground = "#${config.colorScheme.palette.base04}";
      tab_bar_background = "#${config.colorScheme.palette.base01}";
      macos_titlebar_color = "#${config.colorScheme.palette.base00}";
      # normal
      color0 = "#${config.colorScheme.palette.base00}";
      color1 = "#${config.colorScheme.palette.base08}";
      color2 = "#${config.colorScheme.palette.base0B}";
      color3 = "#${config.colorScheme.palette.base0A}";
      color4 = "#${config.colorScheme.palette.base0D}";
      color5 = "#${config.colorScheme.palette.base0E}";
      color6 = "#${config.colorScheme.palette.base0C}";
      color7 = "#${config.colorScheme.palette.base05}";
      # bright
      color8 = "#${config.colorScheme.palette.base03}";
      color9 = "#${config.colorScheme.palette.base09}";
      color10 = "#${config.colorScheme.palette.base01}";
      color11 = "#${config.colorScheme.palette.base02}";
      color12 = "#${config.colorScheme.palette.base04}";
      color13 = "#${config.colorScheme.palette.base06}";
      color14 = "#${config.colorScheme.palette.base0F}";
      color15 = "#${config.colorScheme.palette.base07}";
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