{ pkgs, nixpkgs-unstable, nixpkgsConfig, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = nixpkgsConfig;
  };
in
{
  home.packages = [
    (pkgs.callPackage ../../pkgs/mudita-center.nix { })
    pkgs.discord
  ];

  programs.obsidian = {
    enable = true;
    package = unstable.obsidian;
  };
}
