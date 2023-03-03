{ pkgs, config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia.modesetting.enable = true;
  
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  
  environment.sessionVariables = rec {
    GBM_BACKEND="nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME="nvidia";
  };
}
