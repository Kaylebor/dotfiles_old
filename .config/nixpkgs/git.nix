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
      };
      pull.rebase = "false";
    };
    userEmail = "veigabuenoender@gmail.com";
    userName = "Ender Veiga";
  };
}
