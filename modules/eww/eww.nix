{config, pkgs, lib, ... }:

{ 

  home.packages = with pkgs; [eww-wayland];

  xdg.configFile."eww/eww.yuck".source = ../../configs/eww/eww.yuck;
  xdg.configFile."eww/eww.scss".source = ../../configs/eww/eww.scss;

}
