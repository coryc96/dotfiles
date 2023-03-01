{config, lib, pkgs, inputs, ... }:

{
  imports = [~/dotfiles/modules/desktop/software/waybar.nix];

  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
  };

  services.kdeconnect.enable = true;

  xdg.configFile."wofi/config".source = ~/dotfiles/modules/desktop/configs/wofi/config;

  xdg.configFile."wofi/style.css".source = ~/dotfiles/modules/desktop/configs/wofi/wofi.css;

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

  xdg.configFile."hypr/hyprland.conf".source = /home/coryc/dotfiles/modules/desktop/configs/hyprland/hyprland.conf;

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
