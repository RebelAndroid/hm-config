{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    tmsu
    unipicker
    file
    alejandra
    bottom
    du-dust
    fzf
    fastfetch
    tree
    restic
    eza
    alacritty
    imv
    mpv
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;
}
