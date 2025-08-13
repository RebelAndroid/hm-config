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

  xdg.configFile."sirula/config.toml".source = ../dotfiles/sirula/config.toml;
  xdg.configFile."sirula/style.css".source = ../dotfiles/sirula/style.css;

  xdg.configFile."fish/config.fish".source = ../dotfiles/config.fish;
}
