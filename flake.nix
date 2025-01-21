{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #plasma-manager.url = "github:pjones/plasma-manager";
    #plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    #plasma-manager.inputs.home-manager.follows = "home-manager";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    nix-software-center.url = "github:vlinkz/nix-software-center";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";
    zen-browser.url = "github:fufexan/zen-browser-flake";
    onelauncher.url = "github:JuneStepp/OneLauncher";
    audiorelay.url = "github:JamesReynolds/audiorelay-flake";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      #plasma-manager,
      nixos-cosmic,
      nixpkgs-wayland,
      zen-browser,
      ghostty,
      onelauncher,
      #  audiorelay,
      nix-software-center,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [ nixpkgs-wayland.overlay ];
      };
    in
    {

      # Host Configuration

      nixosConfigurations.nixframe = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          #./nixos/cosmic.nix
          nixos-cosmic.nixosModules.default
          ./modules/wayland/wayland.nix
          #./modules/greetd/greetd.nix
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
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
              services.xserver.videoDrivers = [ "amdgpu" ];

              services.power-profiles-daemon.enable = true;

              # For fingerprint support
              services.fprintd.enable = true;

              # Firmware Updater
              services.fwupd.enable = true;
              boot.extraModprobeConfig = ''
                options hid_apple fnmode=1
              '';

              ##COSMIC
              services.desktopManager.cosmic.enable = true;
              services.displayManager.cosmic-greeter.enable = true;

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
          #plasma-manager.homeManagerModules.plasma-manager
          (
            { pkgs, config, ... }:
            {
              config = {
                # use it as an overlay
                nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

                home.packages = with pkgs; [
                  zen-browser.packages."${system}".default
                  onelauncher.packages."${system}".default
                  ghostty.packages."${system}".default
                  #nixpkgs-wayland.packages.${system}.swww
                  #nix-software-center.packages.${system}.nix-software-center
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


