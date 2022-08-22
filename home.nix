{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "coryc";
  home.homeDirectory = "/home/coryc";
  
  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.thunderbird
    pkgs.gparted
    pkgs.gnome-text-editor
    pkgs.podman
    pkgs.distrobox
    pkgs.gnome.gnome-tweaks
    pkgs.tilix
    pkgs.vscodium
    pkgs.remmina
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.git
    pkgs.mullvad-vpn
    pkgs.firefox
    pkgs.lutris
    pkgs.retroarch
  ];
  
  ## THEMES ##
  
  gtk = {
    enable = true;
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
  };
  
  ## DCONF SETTINGS ##  
  
  dconf.settings = {
  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
    # Keybinds to change
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    ];
  };
  
 # Tilix launch host terminal
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Shift><Super>h";
    command = "tilix -a session-add-right -p Host";
    name = "Host Terminal";
  };
  
  # Tilix launch ubuntu terminal (distrobox)
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "<Shift><Super>u";
    command = "tilix -a session-add-right -p Ubuntu";
    name = "Ubuntu Terminal";
  };
};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
