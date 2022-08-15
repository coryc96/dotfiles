{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "coryc";
  home.homeDirectory = "/home/coryc";
  
  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.thunderbird
    pkgs.firefox
    pkgs.gparted
    pkgs.gnome-text-editor
    pkgs.podman
    pkgs.distrobox
    pkgs.gnome.gnome-tweaks
    pkgs.tilix
    pkgs.vscodium
    pkgs.remmina
  ];
  
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
