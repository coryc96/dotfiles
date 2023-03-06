{ config, pkgs, lib, specialArgs, modulesPath, ... }:
  
let
  desktop-packages = import ../modules/software/desktop-software.nix;
  inherit (specialArgs) hostType isDesktop;
  
  inherit (lib) mkIf;
in
{
  imports = [
  ../modules/hyprland/hyprland.nix
  
  ];
  
  home = {
    username = "coryc";
    homeDirectory = "/home/coryc";
  };

  # GIT
  programs.git = {
    enable = true;
    userName = "Cory Chambers";
    userEmail = "corychambers96@gmail.com";
    # COME BACK TO THIS
  };

  # VIM
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-nix ];
    settings = { ignorecase = true; };
    extraConfig = ''
set number
    '';
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

      nix-home = "vim $dotfiles/home/desktop/home.nix";
      nix-config = "sudo vim $dotfiles/hosts/desktop/configuration.nix";
      nix-software = "vim $dotfiles/modules/desktop/software/software.nix";
      nix-sway = "vim $dotfiles/modules/desktop/sway/sway.nix";
      nix-hypr = "vim $dotfiles/modules/desktop/hyprland/hyprland.nix";
      hypr-conf = "vim $dotfiles/configs/hyprland/hyprland.conf";

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
        src = ~/dotfiles/configs/zsh/powerlevel10k-config;
        file = ".p10k.zsh";
      }  
    ];
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
  };

  ## THEMES ##
  
 # gtk = {
 #   enable = true;
 #   theme = {
 #     name = "Qogir-Dark";
 #     package = pkgs.qogir-theme;
 #   };
 # };
  
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
  programs.home-manager.path = "~/dotfiles/home/home.nix";

}
