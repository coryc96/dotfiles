{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper = { url = "github:hyprwm/hyprpaper"; };

    nixpkgs-wayland  = { url = "github:nix-community/nixpkgs-wayland"; };
    waybar-git = { url = "github:alexays/waybar"; };

    nix-software-center.url = "github:vlinkz/nix-software-center";

  };

  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-wayland, waybar-git, hyprpaper, nix-software-center, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      
      # Host Configuration
      nixosConfigurations.nixpc = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./modules/wayland/wayland.nix
          #./modules/greetd/greetd.nix

      ({ pkgs, config, ... }: {

        boot.extraModprobeConfig = ''
            options hid_apple fnmode=1
            '';
            boot.supportedFilesystems = [ "ntfs" ];
            fileSystems."/mnt/data" =
              { device = "/dev/disk/by-id/wwn-0x5002538f31518925-part3";
                fsType = "ntfs3";
                options = ["rw" "uid=1000" "nofail"];
              };
          # HYPRLAND
         # programs.hyprland.enable = true;
         # nix.settings = {
         #   substituters = ["https://hyprland.cachix.org"];
         #   trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
         # };

        })
      ];
      };

      homeConfigurations.coryc = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home/home.nix
          ./home/software.nix
         # ./modules/hyprland/hyprland.nix
         # hyprland.homeManagerModules.default
          ({ pkgs, config, ...}: {
            config = {
            # use it as an overlay
              nixpkgs.overlays = [ nixpkgs-wayland.overlay];

              home.packages = with pkgs; [
                hyprpaper.packages.${system}.hyprpaper
                nixpkgs-wayland.packages.${system}.swww
                nix-software-center.packages.${system}.nix-software-center
              ];
            };
          })];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
