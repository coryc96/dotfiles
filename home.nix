{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "coryc";
  home.homeDirectory = "/home/coryc";
  
  # Packages that should be installed to the user profile.
  home.packages = [
    # Shell/Terminal/System
    pkgs.tmux
    pkgs.tilix
    pkgs.zsh-powerlevel10k
    pkgs.git
    pkgs.podman
    pkgs.distrobox
    pkgs.bash-completion
    pkgs.kubectl
    pkgs.kubernetes-helm-wrapped
    pkgs.openjdk17-bootstrap
    # Desktop Software
    pkgs.gnome-text-editor
    pkgs.gnome.gnome-tweaks
    pkgs.gparted
    pkgs.keepassxc
    pkgs.firefox
    pkgs.syncthing
    pkgs.gnome.cheese
    pkgs.remmina
    pkgs.gimp
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.libsForQt5.kdeconnect-kde
    pkgs.mullvad-vpn
    # Optional Software
    pkgs.airshipper
    pkgs.tdesktop # telegram
    pkgs.vivaldi
    pkgs.discord
    pkgs.vscode
    pkgs.p7zip
    # Games
    pkgs.lutris
    pkgs.retroarch
    pkgs.prismlauncher
    pkgs.xonotic
    pkgs.steam
  ];

  # GIT
  programs.git = {
    enable = true;
    userName = "Cory Chambers";
    userEmail = "corychambers96@gmail.com";
  };

  # VIM
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-nix ];
    settings = { ignorecase = true; };
    }; 


  # ZSH
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {

      k = "kubectl";
      cerberos = "export KUBECONFIG=/home/coryc/Documents/k8s/cerberos.yaml";
      rancher = "export KUBECONFIG=/home/coryc/Documents/k8s/rancher.yaml";
      infrastructure = "export KUBECONFIG=/home/coryc/Documents/k8s/infrastructure.yaml";

      nix-home = "vim ~/Documents/NixOS/home.nix";
      nix-config = "sudo vim ~/Documents/NixOS/configuration.nix";

    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = "/home/coryc/.p10k-config";
        file = ".p10k.zsh";
      }  
    ];
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
};
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
