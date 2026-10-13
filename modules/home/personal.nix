{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../../pkgs/mudita-center.nix { })
    pkgs.discord
    pkgs.obsidian
    pkgs.spotify
  ];
}
