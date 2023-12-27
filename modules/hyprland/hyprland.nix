{config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/waybar/waybar.nix
  ];

  home.packages = with pkgs; [eww-wayland];
  
  xdg.configFile."eww/eww.yuck".source = ../../configs/eww/eww.yuck;
  xdg.configFile."eww/eww.scss".source = ../../configs/eww/eww.scss;

  services.kdeconnect.enable = true;

  xdg.configFile."wofi/config".source = ../../configs/wofi/config;

  xdg.configFile."wofi/style.css".source = ../../configs/wofi/wofi.css;

  xdg.configFile."rofi/config.rasi".source = ../../configs/rofi/config.rasi;  

  xdg.configFile."hypr/hyprland.conf".source = ../../configs/hyprland/hyprland.conf;

  xdg.configFile."hypr/hyprpaper.conf".source = ../../configs/hyprland/hyprpaper.conf;

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    xwayland = {
      enable = true;
    };
  };
}
