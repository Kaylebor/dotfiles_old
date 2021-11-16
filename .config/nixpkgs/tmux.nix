{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = dracula;
        extraConfig = "
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-fahrenheit false
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags true
          set -g @dracula-military-time true
          set -g @dracula-cpu-usage true
          set -g @dracula-ram-usage true
          set -g @dracula-gpu-usage true
          set -g @dracula-day-month true
          set -g @dracula-show-left-icon session
        ";
      }
    ];

    clock24 = true;
    historyLimit = 10000;

    tmuxp.enable = true;
  };
}
