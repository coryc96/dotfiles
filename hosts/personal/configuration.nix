# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, home-manager, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ../../modules/greetd/greetd.nix
    #../../modules/polkit/polkit.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  #networking.hostName = "corypc"; # Define your hostname.


  # Enable networking
  networking.networkmanager.enable = true;
  
  services.openssh.enable=true;
  
  # Enable polkit
  security.polkit.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

#  environment.loginShellInit= "[[ "$(tty)" == /dev/tty1 ]] && sway";
  # SwayLock PAM Auth
  security.pam.services.swaylock = {
        text = "auth include login";
  };
   
  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.displayManager.gdm.wayland = true;
  

  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Enable the Gnome Desktop
  
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  
  # Enable the KDE Desktop
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.defaultSession = "plasmawayland";
  #services.xserver.displayManager.sddm.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.coryc = {
    isNormalUser = true;
    description = "Cory Chambers";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Environment Variables
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    PATH = [
      "\${XDG_BIN_HOME}"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.i2c.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gnome.gnome-software
    gnome.gnome-disk-utility
    ddcutil # Used for monitor input control
    xorg.xrandr
    libsForQt5.qt5.qtwayland
    vulkan-validation-layers
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    systemd
  ];

  programs.dconf.enable = true;
  
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      font-awesome
      source-han-sans
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # List services that you want to enable:
  
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

    networking.firewall = { 
    enable = false;
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
  system.stateVersion = "22.05"; # Did you read the comment?
  
  ## Auto-Upgrade
  system.autoUpgrade.enable = true;
  
  ## Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Garbage Collector
  
  nix.gc = {
    automatic = true;  # Enable the automatic garbage collector
    dates = "04:00";   # When to run the garbage collector
    options = "-d";    # Arguments to pass to nix-collect-garbage
  };

}
