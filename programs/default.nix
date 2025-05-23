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

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
