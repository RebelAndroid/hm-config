{
  pkgs,
  config,
  ...
}: {
  # sway and sirula configs
  # sway and sirula are installed in my fork of Argentblua https://github.com/RebelAndroid/argentblua
  xdg.configFile."sway/config".source = ./sway-config;
  xdg.configFile."sirula/config.toml".source = ./sirula/config.toml;
  xdg.configFile."sirula/style.css".source = ./sirula/style.css;

  # sway bar command and background image
  xdg.configFile."sway/sway-bar-script.sh".source = ./sway-bar-script.sh;
  xdg.configFile."sway/unova-map-background.png".source = ./unova-map-background.png;

  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."fish/config.fish".source = ./config.fish;
}
