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
    # minimal account used for system configuration
    homeConfigurations."admin" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "admin";}
        {home.homeDirectory = "/var/home/admin";}
        ./programs
        ./programs/cli.nix
        ./programs/gui.nix
        ./fonts.nix

        {
          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
        }

        ./sway.nix

        {home.stateVersion = "24.05";}
        # The "Intel" packages are used for any mesa driver (like the one for my AMD GPU)
        {home.packages = [pkgs.nixgl.nixGLIntel pkgs.nixgl.nixVulkanIntel];}
      ];
    };

    # used for writing code and related tasks
    homeConfigurations."coding" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "code";}
        {home.homeDirectory = "/var/home/code";}
        ./programs
        ./programs/cli.nix
        ./programs/gui.nix
        ./fonts.nix

        ./sway.nix

        {
          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
        }

        {home.stateVersion = "24.05";}
      ];
    };

    # used for writing and worldbuilding
    homeConfigurations."writing" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "writing";}
        {home.homeDirectory = "/var/home/writing";}
        ./programs
        ./programs/gui.nix

        ./sway.nix

        {home.packages = [pkgs.unipicker];}

        {home.stateVersion = "24.05";}
      ];
    };

    # used for video games and other leisure activities
    homeConfigurations."gaming" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "gaming";}
        {home.homeDirectory = "/var/home/gaming";}
        ./programs

        ./sway.nix

        {home.stateVersion = "24.05";}
      ];
    };
  };
}
