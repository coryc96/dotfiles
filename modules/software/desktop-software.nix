{ config, pkgs, ... }:
{

  home.packages = with pkgs; [

    # Shell/Terminal/System
    gcc
    tmux
    tilix
    ranger
    zsh-powerlevel10k
    git
    podman
    baobab
    distrobox
    bash-completion
    kubectl
    kubernetes-helm-wrapped
    #openjdk17-bootstrap
    jre8_headless
    pulseaudio
    wireplumber
    pavucontrol
    libsForQt5.polkit-kde-agent
    netcat
    nfs-utils
    cifs-utils
    syncthing
    # Desktop Software
    bluez
    blueman
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    helix
    gnome-text-editor
    gnome.gnome-tweaks
    gparted
    keepassxc
    firefox
    image-roll
    syncthing
    gnome.cheese
    remmina
    blender
    gimp
    obs-studio
    libsForQt5.kdeconnect-kde
    mullvad-vpn
    thunderbird
    rclone
    # Optional Software
    airshipper
    tdesktop # telegram
    vivaldi
    p7zip
    spotify
    # Games
    citra-nightly
    dolphin-emu
    desmume
    yuzu
    godot_4
    lutris
    retroarch
    prismlauncher
    xonotic
    zeroad

    # Wayland
    rofi-wayland
    swaynotificationcenter
    grim
    slurp
    pango
    swayidle
    swaylock-effects
    wl-clipboard
    alacritty
    #waybar
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

  nixpkgs.config.allowUnfree = true;

}
