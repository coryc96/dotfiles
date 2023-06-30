{ pkgs, configs, ... }:

{
  environment.sessionVariables = rec {
    LIBVA_DRIVER_NAME="nvidia";
    WLR_NO_HARDWARE_CURSORS="1";
    WLR_RENDERER="vulkan";
    LIBSEAT_BACKEND="logind";
    SDL_VIDEODRIVER="wayland";
    XDG_SESSION_TYPE="wayland";
    GDK_BACKEND="wayland";
    QT_QPA_PLATFORM="wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
    MOZ_ENABLE_WAYLAND="1";
    NIXOS_OZONE_WL = "1";
  };
}
