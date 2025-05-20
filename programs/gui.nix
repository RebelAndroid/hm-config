{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    imv
    mpv
    keepassxc
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;

  xdg.configFile."sway/config".source = ../dotfiles/sway-config;
  xdg.configFile."sway/sway-bar-script.sh".source = ../dotfiles/sway-bar-script.sh;
  xdg.configFile."sway/unova-map-background.png".source = ../dotfiles/unova-map-background.png;

  xdg.configFile."fish/config.fish".source = ../dotfiles/config.fish;

  programs.fish.shellAliases = {
    "imv" = "nixGLIntel imv";
    "mpv" = "nixGLIntel mpv";
    #"alacritty" = "nixGLIntel alacritty";
  };
}
