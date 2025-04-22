{ config, pkgs, ... }:

{

  xdg.configFile."walker/config.toml".source = ../../configs/walker/config.toml;



  # WALKER
  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
