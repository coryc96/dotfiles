{ config, pkgs, ... }:
{

  imports = [
    ./software.nix
    ./configs/sway.nix
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

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;  
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
      cerberos = "export KUBECONFIG=$HOME/Documents/k8s/cerberos.yaml";
      rancher = "export KUBECONFIG=$HOME/Documents/k8s/rancher.yaml";
      infrastructure = "export KUBECONFIG=$HOME/Documents/k8s/infrastructure.yaml";

      nix-home = "vim $dotfiles/home.nix";
      nix-config = "sudo vim $dotfiles/nix/configuration.nix";
      nix-software = "vim $dotfiles/software.nix";
      nix-sway = "vim $dotfiles/configs/sway.nix";

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

# SWAY
#  wayland.windowManager.sway = {
#    enable = true;
#    extraOptions = [
#      "--unsupported-gpu"
#    ];
#    wrapperFeatures = {
#      gtk = true;
#    };
#    extraSessionCommands = ''
#      export WLR_NO_HARDWARE_CURSORS=1
#      export WLR_RENDERER=vulkan
#      '';
#    xwayland = true;
#   # extraSessionCommands = ''
#   #   export WLR_NO_HARDWARE_CURSORS=1
#   #   export SDL_VIDEODRIVER=wayland
#   #   # needs qt5.qtwayland in systemPackages
#   #   export QT_QPA_PLATFORM=wayland
#   #   export QT_AUTO_SCREEN_SCALE_FACTOR=1
#   #   export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
#   #   # Fix for some Java AWT applications (e.g. Android Studio),
#   #   # use this if they aren't displayed properly:
#   #   export _JAVA_AWT_WM_NONREPARENTING=1
#   #   export GDK_BACKEND=wayland
#   #   export XDG_CURRENT_DESKTOP=sway
#   #   export GBM_BACKEND=nvidia-drm
#   #   export __GLX_VENDOR_LIBRARY_NAME=nvidia
#   #   export MOZ_ENABLE_WAYLAND=1
#   #   '';
#    config = rec {
#      output = {
#      
#        DP-3 = {
#          mode = "3440x1440@144Hz";
#          position = "0 0";
#        };
#      
#      };
#      modifier = "Mod4";
#      menu = "fuzzel --show run";
#      # Use kitty as default terminal
#      bars = [{
#        command = "waybar";
#      }];
#      terminal = "alacritty";
#      fonts =
#      {
#        names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
#        style = "Bold Semi-Condensed";
#        size = 11.0;
#      }; 
#      startup = [
#        # Launch Firefox on start
#        {command = "alacritty";}
#      ];
#    };
#    extraConfig = ''
#      # Notification Center
#      exec swaync
#      bindsym Mod4+Shift+n exec 'swaync-client -t -sw'
#      
#      # Media
#      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
#      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
#      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
#      bindsym Mod4+Shift+XF86AudioMute exec "bash $HOME/Scripts/switch_sink.sh"
#      
#      bindsym XF86AudioPlay exec 'playerctl play-pause'
#      bindsym XF86AudioPrev exec 'playerctl previous'
#      bindsym XF86AudioNext exec 'playerctl next'
#    '';
#  };

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
