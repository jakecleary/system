{ nix-colors, bio, ... }:
{
  imports = [
    nix-colors.homeManagerModules.default
    ./modules/home/packages.nix
    ./modules/home/programs/developer.nix
    ./modules/home/programs/fish.nix
    ./modules/home/programs/gpg.nix
    ./modules/home/programs/shell.nix
    ./modules/home/programs/vcs.nix
  ];

  home.stateVersion = "24.05";
  home.username = bio.system.username;
  home.homeDirectory = bio.system.homeDirectory;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # colour scheme IDs taken from:
  # https://github.com/tinted-theming/base16-schemes
  # Simply take the filename (without the .yaml suffix)
  # colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-soft;

  # Manage dotfiles.
  home.file = {
    ".config/ghostty/config".source = ./dotfiles/.config/ghostty/config;
    ".config/mise/config.toml".source = ./dotfiles/.config/mise/config.toml;
    "CLAUDE.md".source = ./dotfiles/CLAUDE.md;
  };

  # Custom PATH
  #############

  home.sessionPath = [
    "/Applications/Sublime Merge.app/Contents/SharedSupport/bin" # allow using Sublime Merge's 'smerge' command
  ];
}
