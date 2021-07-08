{ pkgs, ... }: {
  require = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
    ./local.nix
  ];
  
  home.packages = with pkgs; [
    exa
    hexyl
    fd
    ripgrep
    ripgrep-all
    bat
    fzf
    direnv
    gitAndTools.delta
    abduco
    dvtm
    httpie
  ];

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.home-manager.enable = true;
  programs.home-manager.path = "…";

  programs.bat.themes.dracula = "$HOME/.bat-themes/Dracula.tmTheme";
}
