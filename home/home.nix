{ config, pkgs, ... }:
{
  imports = [
    ../modules/desktop/sway/home.nix
    ../modules/desktop/hyprland/home.nix
    ../modules/desktop/software/home.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "coryc";
  home.homeDirectory = "/home/coryc/";
  
    # GIT
  programs.git = {
    enable = true;
    userName = "Cory Chambers";
    userEmail = "corychambers96@gmail.com";
    # COME BACK TO THIS
  };

#  programs.gh = {
#    enable = true;
#    enableGitCredentialHelper = true;  
#  };

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
      cerberos = "export KUBECONFIG=$HOME/Documents/k8s/cerberos.yaml";
      rancher = "export KUBECONFIG=$HOME/Documents/k8s/rancher.yaml";
      infrastructure = "export KUBECONFIG=$HOME/Documents/k8s/infrastructure.yaml";

      nix-home = "vim $dotfiles/home/home.nix";
      nix-config = "sudo vim $dotfiles/hosts/desktop/configuration.nix";
      nix-software = "vim $dotfiles/modules/desktop/software/home.nix";
      nix-sway = "vim $dotfiles/modules/sway/home.nix";

    };
    localVariables = {
      KUBECONFIG="$HOME/Documents/k8s/cerberos.yaml";
      dotfiles="$HOME/dotfiles";
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
        src = "/home/coryc/dotfiles/configs/zsh/powerlevel10k-config/";
        file = ".p10k.zsh";
      }  
    ];
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
  };

  ## THEMES ##
  
#  gtk = {
#    enable = true;
#    theme = {
#      name = "Qogir-Dark";
#      package = pkgs.qogir-theme;
#    };
#  };
  
# Cursor
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}