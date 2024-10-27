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
    themes = {
      mine = with config.colorScheme.palette; {
        "attributes" = "#${base09}";
        "comment" = { fg = "#${base03}"; modifiers = ["italic"]; };
        "constant" = "#${base09}";
        "constant.character.escape" = "#${base0C}";
        "constant.numeric" = "#${base09}";
        "constructor" = "#${base0D}";
        "debug" = "#${base03}";
        "diagnostic" = { modifiers = ["underlined"]; };
        "diff.delta" = "#${base09}";
        "diff.minus" = "#${base08}";
        "diff.plus" = "#${base0B}";
        "error" = "#${base08}";
        "function" = "#${base0D}";
        "hint" = "#${base03}";
        "info" = "#${base0D}";
        "keyword" = "#${base0E}";
        "label" = "#${base0E}";
        "namespace" = "#${base0E}";
        "operator" = "#${base05}";
        "special" = "#${base0D}";
        "string"  = "#${base0B}";
        "type" = "#${base0A}";
        "variable" = "#${base08}";
        "variable.other.member" = "#${base0B}";
        "warning" = "#${base09}";

        "markup.bold" = { fg = "#${base0A}"; modifiers = ["bold"]; };
        "markup.heading" = "#${base0D}";
        "markup.italic" = { fg = "#${base0E}"; modifiers = ["italic"]; };
        "markup.link.text" = "#${base08}";
        "markup.link.url" = { fg = "#${base09}"; modifiers = ["underlined"]; };
        "markup.list" = "#${base08}";
        "markup.quote" = "#${base0C}";
        "markup.raw" = "#${base0B}";
        "markup.strikethrough" = { modifiers = ["crossed_out"]; };

        "diagnostic.hint" = { underline = { style = "curl"; }; };
        "diagnostic.info" = { underline = { style = "curl"; }; };
        "diagnostic.warning" = { underline = { style = "curl"; }; };
        "diagnostic.error" = { underline = { style = "curl"; }; };

        "ui.background" = { bg = "#${base00}"; };
        "ui.bufferline.active" = { fg = "#${base00}"; bg = "#${base03}"; modifiers = ["bold"]; };
        "ui.bufferline" = { fg = "#${base04}"; bg = "#${base00}"; };
        "ui.cursor" = { fg = "#${base0A}"; modifiers = ["reversed"]; };
        "ui.cursor.insert" = { fg = "#${base0A}"; modifiers = ["reversed"]; };
        "ui.cursorline.primary" = { fg = "#${base05}"; bg = "#${base01}"; };
        "ui.cursor.match" = { fg = "#${base0A}"; modifiers = ["reversed"]; };
        "ui.cursor.select" = { fg = "#${base0A}"; modifiers = ["reversed"]; };
        "ui.gutter" = { bg = "#${base00}"; };
        "ui.help" = { fg = "#${base06}"; bg = "#${base01}"; };
        "ui.linenr" = { fg = "#${base03}"; bg = "#${base00}"; };
        "ui.linenr.selected" = { fg = "#${base04}"; bg = "#${base01}"; modifiers = ["bold"]; };
        "ui.menu" = { fg = "#${base05}"; bg = "#${base01}"; };
        "ui.menu.scroll" = { fg = "#${base03}"; bg = "#${base01}"; };
        "ui.menu.selected" = { fg = "#${base01}"; bg = "#${base04}"; };
        "ui.popup" = { bg = "#${base01}"; };
        "ui.selection" = { bg = "#${base02}"; };
        "ui.selection.primary" = { bg = "#${base02}"; };
        "ui.statusline" = { fg = "#${base04}"; bg = "#${base01}"; };
        "ui.statusline.inactive" = { bg = "#${base01}"; fg = "#${base03}"; };
        "ui.statusline.insert" = { fg = "#${base00}"; bg = "#${base0B}"; };
        "ui.statusline.normal" = { fg = "#${base00}"; bg = "#${base03}"; };
        "ui.statusline.select" = { fg = "#${base00}"; bg = "#${base0F}"; };
        "ui.text" = "#${base05}";
        "ui.text.focus" = "#${base05}";
        "ui.virtual.indent-guide" = { fg = "#${base03}"; };
        "ui.virtual.inlay-hint" = { fg = "#${base03}"; };
        "ui.virtual.ruler" = { bg = "#${base01}"; };
        "ui.virtual.jump-label" = { fg = "#${base0A}"; modifiers = ["bold"]; };
        "ui.window" = { bg = "#${base01}"; };
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