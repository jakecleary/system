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
  # colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-soft;

  # Packages
  home.packages = with pkgs;
  [
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })
    gh
    git
    gleam
    gnupg
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
    signing = {
      signByDefault = true;
      key = "6192E5CC28B8FA7EF5F3775F37265B1E496C92A2";
    };
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
    settings = with config.colorScheme.palette; {
      # configure kitty to log in to fish on boot
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
      background = "#${base00}";
      foreground = "#${base05}";
      selection_background = "#${base05}";
      selection_foreground = "#${base00}";
      url_color = "#${base04}";
      cursor = "#${base05}";
      cursor_text_color = "#${base00}";
      active_border_color = "#${base03}";
      inactive_border_color = "#${base01}";
      active_tab_background = "#${base00}";
      active_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base04}";
      tab_bar_background = "#${base01}";
      macos_titlebar_color = "#${base00}";
      # normal
      color0 = "#${base00}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base05}";
      # bright
      color8 = "#${base03}";
      color9 = "#${base09}";
      color10 = "#${base01}";
      color11 = "#${base02}";
      color12 = "#${base04}";
      color13 = "#${base06}";
      color14 = "#${base0F}";
      color15 = "#${base07}";
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_soft";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
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