{ config, pkgs, ... }:
{

  home.packages = with pkgs; [

    # Shell/Terminal/System
    tmux
    tilix
    ranger
    zsh-powerlevel10k
    git
    podman
    distrobox
    bash-completion
    kubectl
    kubernetes-helm-wrapped
    openjdk17-bootstrap
    pulseaudio
    wireplumber
    pavucontrol
    libsForQt5.index
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland

    # Desktop Software
    xfce.thunar
    gnome-text-editor
    gnome.gnome-tweaks
    gparted
    keepassxc
    firefox
    syncthing
    gnome.cheese
    remmina
    gimp
    obs-studio
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    libsForQt5.kdeconnect-kde
    mullvad-vpn
    thunderbird
    # Optional Software
    airshipper
    tdesktop # telegram
    vivaldi
    p7zip
    spotify
    # Games
    lutris
    retroarch
    prismlauncher
    xonotic
    zeroad
    steam

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
    waybar
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
