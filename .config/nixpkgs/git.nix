{ pkgs, ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;

    aliases = {
      aliases = "config --get-regexp alias";

      s = "status";
      s-c = "status --column";
      ss = "status -s";
      a = "add";
      a-i = "add -i";
      c = "commit";
      c-a = "commit -a";
      c-m = "commit -m";
      c-am = "commit -am";
      c--am = "commit --amend";
      c-i = "commit --interactive";
      c-p = "commit -p";
      b = "branch";
      bd = "branch -d";
      bv = "branch -v";
      bvv = "branch -vv";
      ba = "branch -a";
      co = "checkout";
      cob = "checkout -b";
      p = "pull";
      f = "fetch";
      ps = "push";
      psf = "push --force-with-lease";
      psu = "push -u";
      psuo = "push -u origin HEAD";
      m = "merge";
      m-s = "merge --squash";
      r = "rebase";
      r-i = "rebase -i";
      l = "log";

      rg = "!git branch -a | sed '/->/d' | sed 's/\\*//' | xargs git grep -n -I";
      hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
      last = "log -1 head";
      list-local = "for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads";
      list-gone = "!git list-local | awk '$2 == \"[gone]\" {print $1}'";
      del-gone = "!git list-gone | xargs -r git branch -D";
      bl-date = "for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/heads";
      blr-date = "for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/remotes";
      bl-author = "!git for-each-ref --sort='-committerdate:iso8601' --format='%(committerdate:relative)|%(refname:short)|%(committername)' refs/heads/ | column -s '|' -t";
      blr-author = "!git for-each-ref --sort='-committerdate:iso8601' --format='%(committerdate:relative)|%(refname:short)|%(committername)' refs/remotes/ | column -s '|' -t";
    };

    extraConfig = {
      core = {
        editor = "code -w";
        eol = "lf";
        autocrlf = "input";
        excludesfile = "~/.config/git/.gitignore.global";
      };

      log.date = "relative";
      format.pretty = "%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(12,trunc)%ad %C(auto,green)%<(9,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D";

      branch.autosetupmerge = "always";
      pull.ff = "only";
      push.default = "simple";

      difftool.prompt = "false";
    };
  };
}
