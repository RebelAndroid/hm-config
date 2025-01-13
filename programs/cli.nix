{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    tmsu
    unipicker
    alejandra
    fzf
    fastfetch
    restic
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
