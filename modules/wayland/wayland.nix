{ pkgs, configs, ... }:

{
  environment.sessionVariables = rec {
    QT_QPA_PLATFORMTHEME="wayland;xcb";
    GBM_BACKEND="nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME="nvidia";
    ENABLE_VKBASALT="1";
    LIBVA_DRIVER_NAME="nvidia";
    WLR_RENDERER="vulkan";
    GDK_BACKEND="wayland";
    MOZ_ENABLE_WAYLAND="1";
    DXVK_ENABLE_NVAPI="1";
    PROTON_ENABLE_NGX_UPDATER="1";
    PROTON_ENABLE_NVAPI="1";
    PROTON_FORCE_LARGE_ADDRESS_AWARE="1";
    PROTON_HIDE_NVIDIA_GPU="0";
    VKD3D_CONFIG="dxr";
  };
}
