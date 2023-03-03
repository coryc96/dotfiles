{
  description = "Personal Configuration Flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.corypc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
  };
}
