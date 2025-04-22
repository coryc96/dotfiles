{ pkgs, configs, ... }:

{
  environment.sessionVariables = rec {

    GDK_BACKEND="wayland,x11";
    SDL_VIDEODRIVER="wayland";
    CLUTTER_BACKEND="wayland";
    QT_QPA_PLATFORM="wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR="1";
	NIXOS_OZONE_WL="1";
	COSMIC_DISABLE_DIRECT_SCANOUT="1";

	LIBVA_DRIVER_NAME="radeonsi";
    MOZ_ENABLE_WAYLAND="1";
    #MOZ_DISABLE_RDD_SANDBOX="1";
    _JAVA_AWT_WM_NONREPARENTING="1";
  };
}
