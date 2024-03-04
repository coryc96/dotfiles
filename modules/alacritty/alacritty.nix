{ config, pkgs, lib, ... }:

{
  xdg.configFile."alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;
}

