{pkgs, ... }:
{

  imports = [
    ../modules/vim/vim.nix
    ../modules/alacritty/alacritty.nix
    ../modules/kitty/kitty.nix
    ../modules/starship/starship.nix
    ../modules/walker/walker.nix
#	../modules/plasma/plasma.nix
  ];

  home.packages = with pkgs; [

  # Shell/Terminal/System
  zsh-powerlevel10k
  podman
  docker
  rclone
  nerd-fonts.fira-code
  baobab
  distrobox
  kubectl
  k9s
  kubernetes-helm-wrapped
  helm-ls
  kubelogin-oidc
  omnictl
  talosctl
  argocd
  gh
  stern
  inetutils
  opensc
  # jre8_headless
  openjdk17-bootstrap
  pulseaudio
  pavucontrol
  remmina
  sonobus
  moonlight-qt
  powertop
  jq
  xdg-desktop-portal-wlr

  # Development
  rustup
  nixd
  nil
  cosmic-edit

  # Desktop Software
  gnome-tweaks
  gnome-keyring
  gparted
  vivaldi
  firefox
  vesktop
  thunderbird
  beeper
  jan
  deluge
  gimp
  spotify
  syncthing
  #zed-editor

  # Games
  #lutris-unwrapped
  #xboxdrv
  airshipper
  (prismlauncher.override {
    jdks = [
      jdk8
	  openjdk8-bootstrap
	  jdk21_headless
	  temurin-jre-bin
    ];
})
  gamescope
  wine-wayland

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
		exec = "flatpak run com.moonlight_stream.Moonlight stream cloudpc Laptop --display-mode fullscreen --resolution 2256x1504 --fps 60 --no-vsync --bitrate 30000";
	  };
   	  moonlight-uw = {
		name = "Moonlight-UW";
		exec = "flatpak run com.moonlight_stream.Moonlight stream cloudpc Ultrawide --display-mode fullscreen --resolution 3440x1440 --fps 144 --no-vsync --bitrate 100000";
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
