{ config, pkgs, ... }:
{

  home.packages = with pkgs; [

    # Shell/Terminal/System
    tmux
    ranger
    zsh-powerlevel10k
    git
    podman
    distrobox
    bash-completion
    kubectl
    kubernetes-helm-wrapped
    pulseaudio
    wireplumber
    pavucontrol
    binutils
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland

    # Desktop Software
    xfce.thunar
    gnome-text-editor
    gparted
    keepassxc
    firefox
    gnome.cheese
    libsForQt5.kdeconnect-kde
    thunderbird
    tdesktop # telegram
    p7zip
    spotify
    
    # Games
    retroarch

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
