{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    file # detects file types
    bottom # resource monitor
    du-dust # shows disk usage
    tree # displays directory trees
    eza # ls replacement
    ripgrep # grep replacement
    fd # find replacement
    fzf # fuzzy finder
    tmsu # tagging system
  ];

  # cd replacement
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
