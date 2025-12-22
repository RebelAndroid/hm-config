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
    jail-nix.url = "sourcehut:~alexdavid/jail.nix";
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
            #fastfetch = [network gpu (try-readonly "/etc/os-release")
            #(try-readonly "/usr/share/icons/default/index.theme")
            #(try-readonly "/sys/class/power_supply")
            #(try-readonly "/sys/devices/virtual/dmi/id")
            #(try-readonly "/usr/share/rpm")
            #(try-readonly "/var/home/admin/.nix-profile")
            #(try-readwrite "/var/home/admin/.cache/fastfetch")
            #(try-fwd-env "SWAYSOCK")
            #];
            tree = [
              (add-runtime ''
                added_path=false
                for i in "$@"; do
                  case $i in
                   -*)
                     ;;
                   *)
                     RUNTIME_ARGS+=(--ro-bind "$(pwd)/$i" "$(pwd)/$i");
                     added_path=true
                     ;;
                  esac
                done
                if [ "$added_path" = false ]; then
                  RUNTIME_ARGS+=(--ro-bind "$(pwd)" "$(pwd)");
                fi
                #echo "''${RUNTIME_ARGS[@]}"
              '')
            ];
            eza = [
              (add-runtime ''
                added_path=false
                for i in "$@"; do
                  case $i in
                   -*)
                     ;;
                   *)
                     RUNTIME_ARGS+=(--ro-bind "$(pwd)/$i" "$(pwd)/$i");
                     added_path=true
                     ;;
                  esac
                done
                if [ "$added_path" = false ]; then
                  RUNTIME_ARGS+=(--ro-bind "$(pwd)" "$(pwd)");
                fi
                #echo "''${RUNTIME_ARGS[@]}"
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
