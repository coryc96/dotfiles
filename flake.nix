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
    
    fu.url = "github:numtide/flake-utils";

    eww = { 
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

     rust-overlay = {
       url = "github:oxalica/rust-overlay";
       inputs.nixpkgs.follows = "nixpkgs";
       inputs.flake-utils.follows = "fu";
     };
    # only needed if you use as a package set:
    #nixpkgs-wayland.inputs.nixpkgs.follows = "cmpkgs";
    #nixpkgs-wayland.inputs.master.follows = "master";
  };
  
  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-wayland, fu, eww, rust-overlay, ... }@attrs: 
  let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
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
	  #boot.loader.systemd-boot.enable = true;
	  boot.loader.efi.canTouchEfiVariables = true;
	  boot.loader.efi.efiSysMountPoint = "/boot/efi";
	  
	  
      
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
    
    homeConfigurations.coryc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home/home.nix
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
    };
  };
}
