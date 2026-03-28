{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableFishIntegration = true;
    settings = {
        theme = "dark:Catppuccin Mocha,light:Catppuccin Latte";
        font-family = "Maple Mono NF";
        font-size = 18;
        window-decoration = true;
        macos-non-native-fullscreen = true;
    };
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      experimental = true;
      lockfile = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.mcfly = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bottom = {
    enable = true;
  };
}
