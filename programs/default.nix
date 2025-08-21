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
    alejandra # nix formatter
    fastfetch # show system summary
    restic # make backups
    gh # github cli
    imv # image viewer
    mpv # music/video player
    keepassxc # password manager
    vscodium # IDE
    gnome-calendar # calendar
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.nixVulkanIntel
  ];

  # cd replacement
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  
  # This doesn't work and I don't know why. As far as I can tell the file gets created in the nix store, but is never linked to
  xdg.desktopEntries."keepassxc" = {
    exec = "keepassxc";
    name = "keepassxc";
  };
}
