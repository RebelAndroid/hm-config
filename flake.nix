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
    jail-nix = {
      url = "sourcehut:~alexdavid/jail.nix";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    jail-nix,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    jail = jail-nix.lib.init pkgs;
    jailOverlay = final: prev:
      jail-nix.lib.mkOverlay {
        inherit final prev;
        packages = combinators:
          with combinators; {
            eza = [
              (add-runtime ''
                added_path=false
                for i in "$@"; do
                  case $i in
                  # options starting with "-", not relevant for permissions
                   -*)
                     ;;
                  # absolute path
                   /*)
                     RUNTIME_ARGS+=(--ro-bind "$i" "$i");
                     added_path=true
                     ;;
                  # relative path
                   *)
                     RUNTIME_ARGS+=(--ro-bind "$(pwd)/$i" "$(pwd)/$i");
                     added_path=true
                     ;;
                  esac
                done
                # if no files were given, ls lists files in the current directory so we add it
                if [ "$added_path" = false ]; then
                  RUNTIME_ARGS+=(--ro-bind "$(pwd)" "$(pwd)");
                fi
                echo "''${RUNTIME_ARGS[@]}"
              '')
            ];
          };
      };
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
        ];
      overlays = [jailOverlay nixgl.overlay];
    };
  in {
    # minimal account used for system configuration
    homeConfigurations."admin@desktop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "admin";}
        {home.homeDirectory = "/var/home/admin";}
        ./programs
        ./dotfiles

        ./fonts.nix

        {xdg.configFile."sway/hw-config".source = ./dotfiles/sway-config-desktop;}

        {
          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
        }
        # {home.file."hello-world" = {text = ''hello world'';};}

        {home.stateVersion = "24.05";}
        # The "Intel" packages are used for any mesa driver (like the one for my AMD GPU)
        {home.packages = [pkgs.nixgl.nixGLIntel pkgs.nixgl.nixVulkanIntel];}
      ];
    };

    homeConfigurations."christopher@fedora" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        {home.username = "christopher";}
        {home.homeDirectory = "/home/christopher";}
        ./programs
        ./dotfiles

        ./fonts.nix

        {
          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
        }

        {home.stateVersion = "24.05";}
        # The "Intel" packages are used for any mesa driver (like the one for my AMD GPU)
        {home.packages = [pkgs.nixgl.nixGLIntel pkgs.nixgl.nixVulkanIntel];}
      ];
    };
  };
}
