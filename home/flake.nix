{
  description = "Home Manager configuration of Cory Chambers";

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

  outputs = { nixpkgs, home-manager, hyprland, nixpkgs-wayland, fu, eww, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.coryc@corypc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home.nix
          ../modules/software/desktop-software.nix
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
    homeConfigurations.coryc@corylaptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home.nix
          ../modules/software/laptop-software.nix
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
