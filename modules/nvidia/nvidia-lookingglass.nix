{ pkgs, config, ... }:


{
  # Optionally replace "master" with a particular revision to pin this dependency.
  # This repo also provides the module in a "Nix flake" under `nixosModules.nvidia-vgpu` output
  imports = [ (builtins.fetchTarball "https://github.com/danielfullmer/nixos-nvidia-vgpu/archive/master.tar.gz") ];

  hardware.nvidia.vgpu.enable = true; # Enable NVIDIA KVM vGPU + GRID driver
  hardware.nvidia.vgpu.unlock.enable = true; # Unlock vGPU functionality on consumer cards using DualCoder/vgpu_unlock project.
}
