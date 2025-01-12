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
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nix-flatpak = {
    #  url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
    #};
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
        ];
      overlays = [
        nixgl.overlay
      ];
    };
  in {
    homeConfigurations."christopher" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "christopher";}
        {home.homeDirectory = "/home/christopher";}

        ./programs
        ./fonts.nix
        
        # As we are commanded
        {home.stateVersion = "24.05";}
        
        # The "Intel" packages are used for any mesa driver (like the one for my AMD GPU)
        {home.packages = [pkgs.nixgl.nixGLIntel pkgs.nixgl.nixVulkanIntel];}
      ];
    };
  };
}
