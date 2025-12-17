{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    landrun
    strace
    file # detects file types
    bottom # resource monitor
    dust # shows disk usage
    tree # displays directory trees
    eza # ls replacement
    ripgrep # grep replacement
    fd # find replacement
    fzf # fuzzy finder
    tmsu # tagging system
    alejandra # nix formatter
    fastfetch # show system summary
    restic # make backups
    rclone # file sync
    gh # github cli
    imv # image viewer
    mpv # music/video player
    keepassxc # password manager
    vscodium # IDE
    gnome-calendar # calendar
    xournalpp # note taking
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.nixVulkanIntel
  ];

  # cd replacement
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };  
}
