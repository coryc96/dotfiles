{ pkgs, config, ... }:

{
  services.greetd = {
    enable = true;
    restart = false;
    settings = rec {
      initial_session = {
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd cosmic-session";
        #command = "cosmic-session";
        user = "coryc";
      };
      default_session = initial_session;
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
