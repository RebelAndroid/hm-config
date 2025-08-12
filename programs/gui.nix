{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    imv
    mpv
    keepassxc
    vscodium
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.nixVulkanIntel
    gnome-calendar
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;

  xdg.configFile."fish/config.fish".source = ../dotfiles/config.fish;
}
