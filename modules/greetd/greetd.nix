{ pkgs, config, ... }:

{
  services.greetd = {
    enable = true;
    restart = false;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "coryc";
      };
      default_session = initial_session;
    };
  };
}
