{ pkgs, nixpkgs-unstable, nixpkgsConfig, ... }:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = nixpkgsConfig;
  };
in
{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prefer_editor_prompt = "disabled";
      prompt = "enabled";
      version = 1;
    };
  };

  programs.mise = {
    enable = true;
    package = unstable.mise;
  };

  programs.claude-code = {
    enable = true;
    package = unstable.claude-code;
    settings = {
      permissions = {
        allow = [
          "Bash(git status)"
          "Bash(git diff*)"
          "Bash(git log*)"
          "Bash(jj status)"
          "Bash(jj log*)"
          "Bash(jj diff*)"
          "Bash(jj show*)"
          "Bash(jj evolog*)"
          "Bash(jj obslog*)"
          "Read(*)"
          "LS(*)"
          "Grep(*)"
          "Glob(*)"
          "WebSearch(*)"
          "WebFetch(*)"
        ];
        ask = [
          "Bash(git push*)"
          "Bash(git commit*)"
          "Bash(jj new*)"
          "Bash(jj commit*)"
          "Bash(jj describe*)"
          "Bash(jj rebase*)"
          "Bash(jj git push*)"
          "Bash(rm*)"
          "Bash(sudo*)"
        ];
        deny = [
          "Bash(rm -rf /)"
          "Bash(sudo rm*)"
        ];
      };
      tools = {
        bash = {
          confirmBeforeRun = false;
        };
        read = {
          confirmBeforeRun = false;
        };
        ls = {
          confirmBeforeRun = false;
        };
        grep = {
          confirmBeforeRun = false;
        };
        glob = {
          confirmBeforeRun = false;
        };
        webSearch = {
          confirmBeforeRun = false;
        };
        webFetch = {
          confirmBeforeRun = false;
        };
      };
    };
  };
}
