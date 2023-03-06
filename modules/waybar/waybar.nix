{config, pkgs, ... }:

{ 
  imports = [];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  xdg.configFile."waybar/config".source = ../../configs/waybar/config;

  programs.waybar = {
    enable = true;
    #systemd.enable = true;
    style = ../../configs/waybar/style.css;
  };
}
