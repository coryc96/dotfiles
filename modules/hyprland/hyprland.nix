{config, lib, pkgs, inputs, ... }:

{
  imports = [~/dotfiles/modules/waybar/waybar.nix];

  services.kdeconnect.enable = true;

  xdg.configFile."wofi/config".source = ~/dotfiles/configs/wofi/config;

  xdg.configFile."wofi/style.css".source = ~/dotfiles/configs/wofi/wofi.css;

  xdg.configFile."rofi/config.rasi".source = ~/dotfiles/configs/rofi/config.rasi;  
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-gtk";
      package = pkgs.catppuccin-gtk;
    };
  };

  programs.swaylock = {
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };

  xdg.configFile."hypr/hyprland.conf".source = ~/dotfiles/configs/hyprland/hyprland.conf;

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };
}
