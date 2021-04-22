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
      pull.rebase = "false";
      commit.template = "~/.config/git/.gitmessage";
    };
    userEmail = "veigabuenoender@gmail.com";
    userName = "Ender Veiga";
  };
}
