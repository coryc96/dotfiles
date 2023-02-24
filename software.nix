{ config, pkgs, ... }:
{

  home.packages = with pkgs; [

    # Shell/Terminal/System
    tmux
    tilix
    zsh-powerlevel10k
    git
    podman
    distrobox
    bash-completion
    kubectl
    kubernetes-helm-wrapped
    openjdk17-bootstrap
    pulseaudio
   # Desktop Software
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
    # Optional Software
    airshipper
    tdesktop # telegram
    vivaldi
    caprine-bin
    vscode
    p7zip
    spotify
    # Games
    lutris
    retroarch
    prismlauncher
    xonotic
    zeroad
    steam
    # SWAY
    swaynotificationcenter
    pango
    swayidle
    wl-clipboard
    alacritty
    waybar
    fuzzel
    wdisplays
    playerctl
  ];
  

  nixpkgs.config.allowUnfree = true;

}
