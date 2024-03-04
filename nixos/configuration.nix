# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Hardware
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
    ];
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  boot.supportedFilesystems = [ "ntfs" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Enable SSH

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # SwayLock PAM Auth
  security.pam.services.swaylock = {
        text = "auth include login";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Enable the KDE Desktop Environment
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma6.enable = true;


  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #environment.etc."wireplumber/main.lua.d/90-suspend-timeout.lua" = {
  #  text = ''
  #    session.suspend-timeout-seconds = 0
  #  '';
  #};
  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #hardware.pulseaudio = {
  #  enable = true;
  #  support32Bit = true;

  #  extraConfig = "unload-module module-suspend-on-idle";

  #};
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };  

  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #  #wireplumber.enable = true;
  #  
  #  # use the example session manager (no others are packaged yet so this is enabled by default,
  #  # no need to redefine it in your config for now)
  #  #media-session.enable = true;
  #};


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.coryc = {
    isNormalUser = true;
    description = "Cory Chambers";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Environment XDG Variables
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    PATH = [
      "\${XDG_BIN_HOME}"
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  }; 

 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure flatpak
  services.flatpak.enable = true;
 
  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

  # Steam
  #programs.steam = {
  #enable = false;
  #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    gnome.gnome-disk-utility
    rustc
    just
	cosmic-bg
	cosmic-osd
	cosmic-term
	cosmic-edit
	cosmic-randr
	cosmic-files
	cosmic-session
	cosmic-launcher
	cosmic-protocols
	cosmic-applibrary
	cosmic-notifications
	cosmic-workspaces-epoch
    cosmic-icons
    cosmic-settings
    cosmic-comp
    cosmic-panel
    cosmic-greeter
    cosmic-applets
	xdg-desktop-portal-cosmic
    xorg.xrandr
    vulkan-validation-layers
    vulkan-tools
    xdg-utils # for opening default programs when clicking links
    ffmpeg-full
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  networking.firewall = { 
      enable = false;
      allowedTCPPorts = [ 7777 ];
      allowedUDPPorts = [ 7777 ];
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ## Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_latest;
  ## Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Garbage Collector
  
  nix.gc = {
    automatic = true;  # Enable the automatic garbage collector
    dates = "04:00";   # When to run the garbage collector
    options = "-d";    # Arguments to pass to nix-collect-garbage
  };


}
