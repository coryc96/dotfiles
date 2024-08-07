{ config, pkgs, lib, ... }:

{
  xdg.configFile."kitty/kitty.conf".source = ../../configs/kitty/kitty.conf;
}

