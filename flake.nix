{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper = { url = "github:hyprwm/hyprpaper"; };

    nixpkgs-wayland  = { url = "github:nix-community/nixpkgs-wayland"; };
    waybar-git = { url = "github:alexays/waybar"; };

    nix-software-center.url = "github:vlinkz/nix-software-center";

  };

  outputs = { self, nixpkgs, home-manager,
  plasma-manager,
  #hyprland, 
  nixpkgs-wayland, 
  #waybar-git, 
  #hyprpaper, 
  nix-software-center, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      
      # Host Configuration
      nixosConfigurations.nixpc = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./modules/wayland/wayland.nix
          ./modules/greetd/greetd.nix

      ({ pkgs, config, ... }: {

        boot.initrd.kernelModules = ["amdgpu"];

        services.xserver.videoDrivers = ["amdgpu"];
        networking.hostName = "nixpc";
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
#          programs.hyprland.enable = true;
#          nix.settings = {
#            substituters = ["https://hyprland.cachix.org"];
#            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7rypt+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
#          };

	system.autoUpgrade = {
	    enable = true;
	    flake = self.outPath;
	    flags = [
		"--update-input"
	        "nixpkgs"
		"-L" # print build logs
	];
	    dates = "02:00";
	    randomizedDelaySec = "45min";
	};
        })
      ];
      };

      nixosConfigurations.nixframe = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./modules/wayland/wayland.nix
          ./modules/greetd/greetd.nix

      ({ pkgs, config, ... }: {

      # Enable swap on luks
      boot.initrd.luks.devices."luks-ad445f29-2dce-436e-bb3c-b2c6e590ef3a".device = "/dev/disk/by-uuid/ad445f29-2dce-436e-bb3c-b2c6e590ef3a";
      boot.initrd.luks.devices."luks-ad445f29-2dce-436e-bb3c-b2c6e590ef3a".keyFile = "/crypto_keyfile.bin";

	  boot.initrd.secrets = {
	  	"/crypto_keyfile.bin" = null;
	  };
      
      #boot.initrd.kernelModules = ["amdgpu"];
	  boot.kernelParams = ["amdgpu.sg_display=0"];

      services.power-profiles-daemon.enable = true;
	 
	  # For fingerprint support
      services.fprintd.enable = true;

      # Firmware Updater
      services.fwupd.enable = true;
        boot.extraModprobeConfig = ''
            options hid_apple fnmode=1
            '';

          # HYPRLAND
          #programs.hyprland.enable = true;
		  #programs.hyprland.package = hyprland.packages.${pkgs.system}.hyprland;
          #nix.settings = {
          #  substituters = ["https://hyprland.cachix.org"];
          #  trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          #};

	system.autoUpgrade = {
	    enable = true;
	    flake = self.outPath;
	    flags = [
		"--update-input"
	        "nixpkgs"
		"-L" # print build logs
	];
	    dates = "02:00";
	    randomizedDelaySec = "45min";
	};
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
		  plasma-manager.homeManagerModules.plasma-manager
          #./modules/hyprland/hyprland.nix
          #hyprland.homeManagerModules.default
          ({ pkgs, config, ...}: {
            config = {
            # use it as an overlay
              nixpkgs.overlays = [ nixpkgs-wayland.overlay];

			  #wayland.windowManager.hyprland.enable = true;	

              home.packages = with pkgs; [
                #hyprpaper.packages.${system}.hyprpaper
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
