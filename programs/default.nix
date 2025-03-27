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
    unison
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
      "mv" = "mv -i";
      "ls" = "eza -l --time-style=long-iso --icons=always";
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
