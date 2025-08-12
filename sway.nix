{
  pkgs,
  config,
  ...
}: {
  # sway and rofi configs
  # sway and rofi are installed in my fork of Argentblua https://github.com/RebelAndroid/argentblua
  xdg.configFile."sway/config".source = dotfiles/sway-config;
  xdg.configFile."sway/sway-bar-script.sh".source = dotfiles/sway-bar-script.sh;
  xdg.configFile."sway/unova-map-background.png".source = dotfiles/unova-map-background.png;

  xdg.configFile."rofi/config.rasi".source = dotfiles/config.rasi;
  xdg.configFile."rofi/theme.rasi".source = dotfiles/theme.rasi;
}
