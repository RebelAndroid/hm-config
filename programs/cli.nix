{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    tmsu
    unipicker
    alejandra
    fastfetch
    restic
    gh
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
