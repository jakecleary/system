{ bio, pkgs, nixpkgs-unstable, nixpkgsConfig, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = nixpkgsConfig;
  };
in
{
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
      init = { defaultBranch = "main"; };
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
}
