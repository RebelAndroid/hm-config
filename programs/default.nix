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
    tailscale
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
