{ pkgs, ... }: {
  programs.git = {
    enable = true;
    delta ={
      enable = true;
    };
    aliases = {
      list-local = "!git for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads";
      list-gone = "!git list-local | awk '$2 == \"[gone]\" {print $1}'";
      del-gone = "!git list-gone | xargs -r git branch -D";
    };
    extraConfig = {
      core = {
        editor = "code -w";
        eol = "lf";
        autocrlf = "input";
        excludesfile = "~/.config/git/.gitignore.global";
      };
      commit.template = "~/.config/git/.gitmessage";
      branch.autosetupmerge = "always";
      pull.ff = "only";
    };
    userEmail = "veigabuenoender@gmail.com";
    userName = "Ender Veiga Bueno";
  };
}
