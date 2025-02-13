{
  pkgs,
  config,
  ...
}: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 39.96;
    longitude = -83.00;
  };
}