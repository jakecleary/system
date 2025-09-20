{ config, lib, pkgs, nixpkgs-unstable, nix-colors, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
  };
in
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
    nerd-fonts.fira-code
    nerd-fonts.hack
    bat
    claude-code
    discord
    eza
    fish
    gh
    git
    gnupg
    helix
    mas
    neofetch
    obsidian
    pinentry_mac
    spotify
    starship
    vscode
    zoxide
  ];

  # Manage dotfiles.
  # (The primary way to manage plain files is through 'home.file'.)
  home.file = {
    # Ghostty configuration
    ".config/ghostty/config".source = ./dotfiles/.config/ghostty/config;
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

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "6192E5CC28B8FA7EF5F3775F37265B1E496C92A2";
    };
  };

  home.file.".gnupg/gpg-agent.conf".text =
  ''
      enable-ssh-support
      default-cache-ttl 600
      default-cache-ttl-ssh 600
      max-cache-ttl 7200
      max-cache-ttl-ssh 7200
      use-standard-socket
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';

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
    shellAliases = {
      cat = "bat";
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gap = "git add --patch";
      gc = "git commit";
      gcf = "git commit --fixup";
      gcp = "git commit --patch";
      gd = "git diff";
      gdc = "git diff --cached";
      gl = "git log";
      glp = "git log --pretty=oneline";
      gp = "git push";
      gpa = "git push --all";
      gpl = "git pull";
      gra = "git rebase --abort";
      grc = "git rebase --continue";
      grh = "git reset --hard";
      grm = "git rebase -i master";
      grs = "git rebase --skip";
      gs = "git status";
      gswm = "git switch master";
      ls = "eza";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };


  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "[nix]"."editor.tabSize" = 2;
        "editor.fontFamily" = "Hack";
        "editor.fontSize" = 18;
        "editor.lineHeight" = 1.4;
      };
      extensions = [ 
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.gleam.gleam
        pkgs.vscode-extensions.tamasfe.even-better-toml
      ];
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