{ config, lib, nixpkgs, nixpkgs-unstable, nix-colors, nixpkgsConfig, ... }:
let
  stable = import nixpkgs {
    system = "aarch64-darwin";
    config = nixpkgsConfig;
  };
  unstable = import nixpkgs-unstable {
    system = stable.stdenv.hostPlatform.system;
    config = nixpkgsConfig;
  };
  bio = import ./bio.nix;
in
{
  # The latest version as of time of me setting this up
  home.stateVersion = "24.05";

  home.username = bio.system.username;
  home.homeDirectory = bio.system.homeDirectory;

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
  home.packages = [
    
    # Fonts
    stable.nerd-fonts.fira-code
    stable.nerd-fonts.hack

    # Tools/Utils
    stable.bat
    stable.dog
    stable.dust
    stable.eza
    stable.hyperfine
    stable.mas
    stable.neofetch
    stable.pinentry_mac
    stable.ripgrep
    stable.sd
    stable.tldr
    stable.tokei
    stable.xh
    unstable.msedit

    # Desktop Apps
    stable.claude-code
    stable.discord
    stable.obsidian
    stable.spotify
  ];

  # Manage dotfiles.
  home.file = {
    ".config/ghostty/config".source = ./dotfiles/.config/ghostty/config;
    ".config/mise/config.toml".source = ./dotfiles/.config/mise/config.toml;
  };

  # Configure git
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      key = bio.persona.signingKey;
    };
    settings = {
      user = {
        name = bio.persona.name;
        email = bio.persona.email;
      };
      github.user = bio.persona.github;
      init = { defaultBranch = "master"; };
      rebase = {
        autoStash = true;
        updateRefs = true;
      };
      merge = {
        conflictStyle = "diff3";
      };
      rerere = {
        enabled = true;
      };
      alias = {
        uncommit = "reset HEAD^";
        stack-rebase = "rebase --update-refs";
        stack-fixup = "commit --fixup=HEAD";
        stack-autosquash = "rebase --autosquash --update-refs";
        parent = "show-branch --merge-base";
      };
    };
    ignores = [
      ".DS_Store"
      "**/.claude/settings.local.json"
    ];
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.jujutsu = {
    enable = true;
    package = unstable.jujutsu;
    settings = {
      user = {
        name = bio.persona.name;
        email = bio.persona.email;
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = bio.persona.signingKey;
      };
    };
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = bio.persona.signingKey;
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
      pinentry-program ${stable.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
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

  programs.mise = {
    enable = true;
    package = unstable.mise;
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

  programs.broot = {
    enable = true;
  };

  programs.mcfly = {
    enable = true;
  };

  programs.bottom = {
    enable = true;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/${bio.system.username}/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "${unstable.msedit}/bin/edit";
  };

  # Custom PATH
  #############

  home.sessionPath = [
    "/Applications/Sublime Merge.app/Contents/SharedSupport/bin" # allow using Sublime Merge's 'smerge' command
  ];
}