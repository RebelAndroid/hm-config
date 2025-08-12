{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    fastfetch
    restic
    gh
  ];
}
