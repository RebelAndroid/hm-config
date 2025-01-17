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
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
