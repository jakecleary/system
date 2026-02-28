{ bio, pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = bio.persona.signingKey;
    };
  };

  home.file.".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      default-cache-ttl 600
      default-cache-ttl-ssh 600
      max-cache-ttl 7200
      max-cache-ttl-ssh 7200
      use-standard-socket
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';
}
