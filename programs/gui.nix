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
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;

  xdg.configFile."sway/config".source = ../dotfiles/sway-config;
  xdg.configFile."sway/sway-bar-script.sh".source = ../dotfiles/sway-bar-script.sh;
  xdg.configFile."sway/unova-map-background.png".source = ../dotfiles/unova-map-background.png;

  xdg.configFile."rofi/config.rasi".source = ../dotfiles/config.rasi;
  xdg.configFile."rofi/theme.rasi".source = ../dotfiles/theme.rasi;

  xdg.configFile."fish/config.fish".source = ../dotfiles/config.fish;
}
