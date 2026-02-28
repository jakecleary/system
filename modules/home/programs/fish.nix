{ ... }:
{
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
}
