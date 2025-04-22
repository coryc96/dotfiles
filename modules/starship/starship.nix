{ config, pkgs, lib, ... }:

{
  xdg.configFile."starship/starship.toml".source = ../../configs/starship/starship.toml;
}
