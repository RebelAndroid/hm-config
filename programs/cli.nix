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
    rclone
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
