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
    imv
    mpv
    ripgrep
    kitty
    krita
  ];

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/alacritty.toml;
  
  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
    };
    plugins = [

    ];
    functions = {

    };
  };
}
