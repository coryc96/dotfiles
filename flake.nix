{
  description = "Personal Configuration Flake";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgs-wayland  = { url = "github:nix-community/nixpkgs-wayland"; };
    waybar-git = { url = "github:alexays/waybar"; };
    
  };
  
  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-wayland, waybar-git, ... }@attrs: 
  let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        
        mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
          inherit pkgs;

          modules = [
            ./home/home.nix
            hyprland.homeManagerModules.default
            {

              nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

              home = {
                username = "coryc";
                homeDirectory = "/home/coryc";
              };
            }
          ]; 
      } // args);
      in {
    nixosConfigurations.corypc = nixpkgs.lib.nixosSystem {
      
      specialArgs = attrs;
      modules = [ 
        
        ./hosts/personal/configuration.nix
        ./modules/nvidia/nvidia.nix
        ./modules/wayland/wayland.nix
      
        ({ pkgs, config, ... }: {
          
          networking.hostName = "corypc";
        
          # Bootloader.
	  boot.loader.systemd-boot.enable = true;
	  boot.loader.efi.canTouchEfiVariables = true;
	  boot.loader.efi.efiSysMountPoint = "/boot/efi";
          boot.loader.grub.devices = "nodev";

          
  	  boot.extraModprobeConfig = ''
            options hid_apple fnmode=1
          '';
          
	  
	  
      
        })
      ];
    };
    nixosConfigurations.corylaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        
        ./hosts/personal/configuration.nix
        ./modules/wayland/wayland.nix
      
        ({ pkgs, config, ... }: {
          
          networking.hostName = "corylaptop";
        
          # Bootloader.
	  #boot.loader.systemd-boot.enable = true;
	  boot.loader.grub.enable = true;
	  boot.loader.grub.device = "/dev/sda";
	  boot.loader.grub.useOSProber = true;
	  
	  
      
        })
      ];
    };
###                     ###
    ### HOME-MANAGER ###
###                     ###
    
    homeConfigurations.desktop = mkHomeConfiguration {
      modules = [
      ./home/home.nix
      ./modules/software/desktop-software.nix
      hyprland.homeManagerModules.default

      ({pkgs, config, ...}: {
      config = {
          # use it as an overlay
      nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

      home.packages = with pkgs; [
        nixpkgs-wayland.packages.${system}.swww
      ];
      };
      })];
        
      extraSpecialArgs = {
        hostType = "desktop";
        isDesktop = true;
      };
    };

    homeConfigurations.laptop = mkHomeConfiguration {
      modules = [
      ./home/home.nix
      ./modules/software/desktop-software.nix
      hyprland.homeManagerModules.default
      ];
      
      nixpkgs.overlays = [ nixpkgs-wayland.overlay ];
      
      home.packages = with pkgs; [
        nixpkgs-wayland.packages.${system}.swww
        waybar-git.packages.${system}.waybar
      ];
      
      extraSpecialArgs = {
        hostType = "laptop";
      };
    };
  };
}
