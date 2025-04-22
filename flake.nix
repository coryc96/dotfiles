{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixpkgs-wayland = {
    #  url = "github:nix-community/nixpkgs-wayland";
    #};

    nix-software-center.url = "github:vlinkz/nix-software-center";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	 walker = {
      url = "github:abenz1267/walker";
      # Optional: Follow nixpkgs if walker needs it (usually good practice)
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
	sherlock.url = "github:Skxxtz/sherlock";
	zed = {
	  url = "github:zed-industries/zed";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	nix-ld = {
		url = "github:Mic92/nix-ld";
		inputs.nixpkgs.follows = "nixpkgs";
		};
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      #nixpkgs-wayland,
      zen-browser,
	  walker,
      ghostty,
	  sherlock,
	  zed,
	  nix-ld,
      nix-software-center,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        #overlays = [ nixpkgs-wayland.overlay ];
      };
    in
    {

      # Host Configuration

      nixosConfigurations.nixframe = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          #./nixos/cosmic.nix
          nixos-cosmic.nixosModules.default
		  nix-ld.nixosModules.nix-ld
          ./modules/wayland/wayland.nix
          #./modules/greetd/greetd.nix
          {
            nix.settings = {
              substituters = [
				"https://cache.nixos.org/" # Standard cache
     			"https://cosmic.cachix.org/"
				"https://zed-industries.cachix.org"
				"https://walker-git.cachix.org"
	  ];
              trusted-public-keys = [ 
			    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Standard cache key
      			"cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      			"zed-industries.cachix.org-1:QW3RoXK0Lm4ycmU5/3bmYRd3MLf4RbTGPqRulGlX5W0="
			    "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
	  		  ];
            };
          }

          (
            { pkgs, config, ... }:
            {

              networking.hostName = "nixframe";

              boot.kernelParams = [
                "amdgpu.sg_display=0"
                "rtc_cmos.use_acpi_alarm=1"
              ];
			  boot.initrd.kernelModules = [ "amdgpu" ];
              services.xserver.videoDrivers = [ "amdgpu" ];
              hardware.graphics.enable = true;
              services.power-profiles-daemon.enable = true;

              # For fingerprint support
              services.fprintd.enable = true;

			  services.pcscd.enable = true;

              # Firmware Updater
              services.fwupd.enable = true;
              boot.extraModprobeConfig = ''
                options hid_apple fnmode=1
              '';

              ##COSMIC
              services.desktopManager.cosmic.enable = true;
              services.displayManager.cosmic-greeter.enable = true;

			  programs.nix-ld.dev.enable = true;

              programs.steam = {
                enable = true;
                gamescopeSession.enable = true;
              };
              programs.gamemode.enable = true;

              nixpkgs.config.allowUnfree = true;

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
            }
          )
        ];
      };
      homeConfigurations.coryc = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowUnfreePredicate = (_: true);
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home/home.nix
          ./home/software.nix
		  walker.homeManagerModules.default

          #plasma-manager.homeManagerModules.plasma-manager
          (
            { pkgs, config, ... }:
            {
              config = {
                # use it as an overlay
                #nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

                home.packages = [
                  zen-browser.packages."${pkgs.system}".default
                  ghostty.packages."${pkgs.system}".default
				  zed.packages."${pkgs.system}".default
				  sherlock.packages."${pkgs.system}".default
                ];

              };
            }
          )
        ];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
