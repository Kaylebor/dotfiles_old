{ pkgs, ... }: {
  programs.git.enable = true;
  programs.git.delta.enable = true;

  programs.git.aliases.c = "checkout";
  programs.git.aliases.p = "pull";
  programs.git.aliases.f = "fetch";
  programs.git.aliases.list-local = "for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads";
  programs.git.aliases.list-gone = "!git list-local | awk '$2 == \"[gone]\" {print $1}'";
  programs.git.aliases.del-gone = "!git list-gone | xargs -r git branch -D";

  programs.git.extraConfig.core.editor = "code -w";
  programs.git.extraConfig.core.eol = "lf";
  programs.git.extraConfig.core.autocrlf = "input";
  programs.git.extraConfig.core.excludesfile = "~/.config/git/.gitignore.global";

  programs.git.extraConfig.commit.template = "~/.config/git/.gitmessage";
  programs.git.extraConfig.branch.autosetupmerge = "always";
  programs.git.extraConfig.pull.ff = "only";
}
