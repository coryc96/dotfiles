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
  nwg-panel
  nwg-displays
  wlr-randr
  appimage-run
  xdg-desktop-portal-wlr
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland

  # Development
  rustup

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
  logseq
  syncthing
  catppuccin-gtk

  # Games
  dolphin-emu
  desmume
  yuzu
  godot_4
  #airshipper
  prismlauncher

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
  #ferdium
  discord
  ];
  
  xdg.desktopEntries = 
    {
   #   ferdium = {
   #     name = "Ferdium";
   #     exec = "ferdium --enable-features=UseOzonePlatform --ozone-platform=wayland";
   #   };
      discord = {
        name = "Discord";
        exec = "discord --no-sandbox";      
      };
      #beeper = {
      #  name = "Beeper";
      #  exec = "appimage-run /home/coryc/Downloads/beeper-3.71.16.AppImage";
      #};
    };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
