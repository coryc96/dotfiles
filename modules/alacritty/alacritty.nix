{ config, pkgs, lib, ... }:

{
  xdg.configFile."alacritty/alacritty.yml".source = ../../configs/alacritty/alacritty.yml;
}

