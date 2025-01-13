{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    file
    bottom
    du-dust
    tree
    eza
    ripgrep
    syncthing
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
      "mv" = "mv -i";
    };
    plugins = [
    ];
    functions = {
    };
  };
}
