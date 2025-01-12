{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    oxygenfonts
    jetbrains-mono
    noto-fonts
  ];
}
