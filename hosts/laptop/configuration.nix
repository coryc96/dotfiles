# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, home-manager, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #/home/coryc/dotfiles/hosts/desktop/greetd.nix
    /home/coryc/dotfiles/hosts/desktop/polkit.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking.hostName = "corylaptop"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  services.mullvad-vpn.enable = true;
  
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

  services.greetd = {
    enable = true;
    restart = false;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "coryc";
      };
      default_session = initial_session;
    };
  };

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

#    # use the example session manager (no others are packaged yet so this is enabled by default,
#    # no need to redefine it in your config for now)
#    #media-session.enable = true;
#
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

    # WAYLAND
    WLR_NO_HARDWARE_CURSORS="1";
    WLR_RENDERER="vulkan";
    LIBSEAT_BACKEND="logind";
    SDL_VIDEODRIVER="wayland";
    XDG_SESSION_TYPE="wayland";
    GDK_BACKEND="wayland";
    QT_QPA_PLATFORM="wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
    MOZ_ENABLE_WAYLAND="1";

    PATH = [
      "\${XDG_BIN_HOME}"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; 
  
  
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

    # WAYLAND
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
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
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

    networking.firewall = { 
    enable = true;
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
