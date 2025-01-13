{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    imv
    mpv
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;

  programs.fish.shellAliases = {
    "imv" = "nixGLIntel imv";
    "mpv" = "nixGLIntel imv";
  };
}
