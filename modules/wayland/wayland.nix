{ pkgs, configs, ... }:

{
  environment.sessionVariables = rec {

    GDK_BACKEND="wayland";
    SDL_VIDEODRIVER="wayland";
    CLUTTER_BACKEND="wayland";
    MOZ_ENABLE_WAYLAND="1";
    MOZ_DISABLE_RDD_SANDBOX="1";
    _JAVA_AWT_WM_NONREPARENTING="1";
    QT_AUTO_SCREEN_SCALE_FACTOR="1";
    QT_QPA_PLATFORM="wayland";
    WLR_NO_HARDWARE_CURSORS="1";
    __NV_PRIME_RENDER_OFFLOAD="1";
    PROTON_ENABLE_NGX_UPDATER="1";
    NVD_BACKEND="direct";
    __GL_GSYNC_ALLOWED="1";
    __GL_VRR_ALLOWED="1";
    WLR_DRM_NO_ATOMIC="1";
    WLR_USE_LIBINPUT="1";
    __GL_MaxFramesAllowed="1";
    WLR_RENDERER_ALLOW_SOFTWARE="1";

  };
}
