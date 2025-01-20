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
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
