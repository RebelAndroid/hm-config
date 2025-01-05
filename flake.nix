{
  description = "my home config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nix-flatpak = {
    #  url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
    #};
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
        ];
      overlays = [
      ];
    };
  in {
    homeConfigurations."christopher" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        ./programs
        # nix-index-database.hmModules.nix-index
        {home.username = "christopher";}
        {home.stateVersion = "24.05";}
        {home.homeDirectory = "/home/christopher";}
      ];
    };
  };
}
