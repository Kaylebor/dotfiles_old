{ pkgs, ... }: {
  programs.git.enable = true;
  programs.git.delta.enable = true;

  programs.git.aliases.s = "status";
  programs.git.aliases.s-c = "status --column";
  programs.git.aliases.ss = "status -s";
  programs.git.aliases.a = "add";
  programs.git.aliases.c = "commit";
  programs.git.aliases.c-a = "commit -a";
  programs.git.aliases.c-m = "commit -m";
  programs.git.aliases.c-am = "commit -am";
  programs.git.aliases.c--am = "commit --amend";
  programs.git.aliases.c-i = "commit --interactive";
  programs.git.aliases.c-p = "commit -p";
  programs.git.aliases.co = "checkout";
  programs.git.aliases.p = "pull";
  programs.git.aliases.f = "fetch";
  programs.git.aliases.ps = "push";
  programs.git.aliases.m = "merge";
  programs.git.aliases.m-s = "merge --squash";
  programs.git.aliases.r = "rebase";
  programs.git.aliases.r-i = "rebase -i";
  programs.git.aliases.list-local = "for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads";
  programs.git.aliases.list-gone = "!git list-local | awk '$2 == \"[gone]\" {print $1}'";
  programs.git.aliases.del-gone = "!git list-gone | xargs -r git branch -D";
  programs.git.aliases.bl-date = "for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/heads";
  programs.git.aliases.blr-date = "for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/remotes";
  programs.git.aliases.bl-author = "!git for-each-ref --sort='-committerdate:iso8601' --format='%(committerdate:relative)|%(refname:short)|%(committername)' refs/heads/ | column -s '|' -t";
  programs.git.aliases.blr-author = "!git for-each-ref --sort='-committerdate:iso8601' --format='%(committerdate:relative)|%(refname:short)|%(committername)' refs/remotes/ | column -s '|' -t";

  programs.git.extraConfig.core.editor = "code -w";
  programs.git.extraConfig.core.eol = "lf";
  programs.git.extraConfig.core.autocrlf = "input";
  programs.git.extraConfig.core.excludesfile = "~/.config/git/.gitignore.global";

  programs.git.extraConfig.commit.template = "~/.config/git/.gitmessage";
  programs.git.extraConfig.branch.autosetupmerge = "always";
  programs.git.extraConfig.pull.ff = "only";
}
