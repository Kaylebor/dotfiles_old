{ pkgs, ... }: {
  programs.git = {
    enable = true;
    delta ={
      enable = true;
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
    userName = "Ender Veiga";
  };
}
