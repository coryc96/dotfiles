{
  description = "Personal Configuration Flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.corypc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        
        /home/coryc/dotfiles/hosts/desktop/configuration.nix
        /home/coryc/dotfiles/modules/nvidia/nvidia.nix
        /home/coryc/dotfiles/modules/wayland/wayland.nix
      
        ({ pkgs, config, ... }: {
          
          networking.hostName = "corypc";
        
          # Bootloader.
	  boot.loader.systemd-boot.enable = true;
	  boot.loader.efi.canTouchEfiVariables = true;
	  boot.loader.efi.efiSysMountPoint = "/boot/efi";
	  
	  
      
        })
      ];
    };
    nixosConfigurations.corylaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        
        /home/coryc/dotfiles/hosts/laptop/configuration.nix
        /home/coryc/dotfiles/modules/wayland/wayland.nix
      
        ({ pkgs, config, ... }: {
          
          networking.hostName = "corylaptop";
        
          # Bootloader.
	  boot.loader.systemd-boot.enable = true;
	  boot.loader.grub.version = true;
	  boot.loader.grub.device = "nodev";
	  
	  
      
        })
      ];
    };
  };
}
