{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    oxygenfonts
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];
}
