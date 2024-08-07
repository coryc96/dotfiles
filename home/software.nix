{pkgs, ... }:
{

  imports = [
    ../modules/vim/vim.nix
    ../modules/alacritty/alacritty.nix
    ../modules/kitty/kitty.nix
#	../modules/plasma/plasma.nix
  ];

  home.packages = with pkgs; [

  # Shell/Terminal/System
  zsh-powerlevel10k
  kitty
  podman
  docker
  fira-code-nerdfont
  baobab
  distrobox
  kubectl
  k9s
  kubernetes-helm-wrapped
  kubelogin-oidc
  talosctl
  argocd
  gh
  stern
  # jre8_headless
  openjdk17-bootstrap
  alacritty
  pulseaudio
  pavucontrol
  mpv
  networkmanagerapplet
  remmina
  sonobus
  moonlight-qt
  powertop
  jq
  catppuccin-kde
  libsForQt5.polonium
  #xwaylandvideobridge
#  nwg-look
#  nwg-displays
  wlr-randr
  xdg-desktop-portal-wlr
  xdg-desktop-portal-gtk
#  xdg-desktop-portal-hyprland

  # Development
  rustup
  cosmic-edit
  zed-editor

  # Desktop Software
  gnome-tweaks
  partition-manager
  gparted
  keepassxc
  floorp
  vivaldi
  firefox
  cheese
  jan
  #blender
  gimp
  youtube-tui
  invidtui
  spotify
  #rustdesk
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
  heroic
  chiaki
  dolphin-emu
  desmume
  protonup-qt
  godot_4
  airshipper
  (prismlauncher.override { 
    jdks = [ 
      jdk8
	  openjdk8-bootstrap
	  jdk21_headless
    ];
})
  gamescope
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
  vesktop
  ];
  
  programs.obs-studio = {
	enable = true;
	plugins = with pkgs.obs-studio-plugins; [obs-teleport];
  };

  xdg.desktopEntries = 
    {
   	  moonlight-lt = {
		name = "Moonlight-LT";
		exec = "moonlight stream corywins Laptop --resolution 2256x1504 --fps 60 --no-vsync --bitrate 30000";
	  };
   	  moonlight-uw = {
		name = "Moonlight-UW";
		exec = "moonlight stream corywins Ultrawide --resolution 3440x1440 --fps 144 --no-vsync --bitrate 100000";
	  };

   #   ferdium = {
   #     name = "Ferdium";
   #     exec = "ferdium --enable-features=UseOzonePlatform --ozone-platform=wayland";
   #   };
     # discord = {
     #   name = "Discord";
     #   exec = "discord --no-sandbox";      
     # };
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
