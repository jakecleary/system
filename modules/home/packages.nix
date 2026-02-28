{ pkgs, nixpkgs-unstable, nixpkgsConfig, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = nixpkgsConfig;
  };
in
{
  home.packages = [

    # Fonts
    pkgs.nerd-fonts.fira-code
    pkgs.maple-mono.NF

    # Tools/Utils
    pkgs.bat
    pkgs.dog
    pkgs.dust
    pkgs.eza
    pkgs.hyperfine
    pkgs.mas
    pkgs.neofetch
    pkgs.pinentry_mac
    pkgs.ripgrep
    pkgs.sd
    pkgs.tldr
    pkgs.tokei
    pkgs.xh
    unstable.msedit
  ];

  home.sessionVariables = {
    EDITOR = "${unstable.msedit}/bin/edit";
  };
}
