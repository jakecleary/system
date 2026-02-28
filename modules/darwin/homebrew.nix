{ config, ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    # Makes sure nix-darwin.homebrew is aware of all declared taps (otherwise it tries to delete them!)
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [];
    casks = [
      "freedom"
      "ghostty"
      "google-chrome"
      "raycast"
      "sublime-merge"
      "visual-studio-code"
    ];
  };
}
