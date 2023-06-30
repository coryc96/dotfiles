{pkgs, ... }:
{

  imports = [
    ../modules/vim/vim.nix
  ];

  home.packages = with pkgs; [

  # Shell/Terminal/System
  zsh-powerlevel10k
  podman
  baobab
  distrobox
  kubectl
  kubernetes-helm-wrapped
  # jre8_headless
  openjdk17-bootstrap
  alacritty
  pulseaudio
  pavucontrol
  networkmanagerapplet
  gnome.nautilus
  remmina

  # Desktop Software
  gnome.gnome-tweaks
  gparted
  keepassxc
  firefox
  gnome.cheese
  blender
  gimp
  obs-studio
  libsForQt5.kdeconnect-kde
  thunderbird
  tdesktop
  p7zip
  shotwell
  # Games
  dolphin-emu
  desmume
  yuzu
  godot_4
  lutris
  airshipper

  # Wayland 
  rofi-wayland
  swaynotificationcenter
  grim
  slurp
  pango
  swayidle
  swaylock-effects
  wl-clipboard
  wofi
  wdisplays
  playerctl

  # Custom Desktop Entries
  ferdium
  discord
  ];
  
  xdg.desktopEntries = 
    {
      ferdium = {
        name = "Ferdium";
        exec = "ferdium --enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
      discord = {
        name = "Discord";
        exec = "discord --no-sandbox";      
      };
    };
}
