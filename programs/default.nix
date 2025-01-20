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
    fd
    fzf
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
      "mv" = "mv -i";
      "ls" = "eza -l";
    };
    plugins = [
    ];
    functions = {
    };
  };
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd";
  };
}
