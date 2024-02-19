{pkgs, ... }:
{

  imports = [
    ../modules/vim/vim.nix
    ../modules/alacritty/alacritty.nix
	../modules/plasma/plasma.nix
  ];

  home.packages = with pkgs; [

  # Shell/Terminal/System
  zsh-powerlevel10k
  podman
  fira-code-nerdfont
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
  jq
  libsForQt5.polonium
  xwaylandvideobridge
#  nwg-look
#  nwg-displays
  wlr-randr
  appimage-run
  xdg-desktop-portal-wlr
  xdg-desktop-portal-gtk
#  xdg-desktop-portal-hyprland

  # Development
  rustup
  helix
  cosmic-edit

  # Desktop Software
  gnome.gnome-tweaks
  partition-manager
  gparted
  keepassxc
  floorp
  firefox
  beeper
  gnome.cheese
  blender
  gimp
  obs-studio
  virtualbox
  libsForQt5.kdeconnect-kde
  thunderbird
  tdesktop
  p7zip
  shotwell
  #logseq
  syncthing
  catppuccin-gtk

  # Games
  dolphin-emu
  desmume
  yuzu
  godot_4
  airshipper
  (prismlauncher.override { 
    jdks = [ 
      jdk8
      jdk19 
    ];
})
  gamescope
  lutris
  wine-wayland

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
    "org/gnome/mutter" = {
      check-alive-timeout="60000";
    };
  };
}
