{ config, pkgs, ... }:
{

  home.sessionVariables.NIXOS_OZONE_WL = "1";

# SWAY
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    wrapperFeatures = {
      gtk = true;
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export WLR_RENDERER=vulkan
      export xwayland=true
      export SDL_VIDEODRIVER=wayland
      export XDG_SESSION_TYPE=wayland
      export GBM_BACKEND=nvidia-drm
      export GDK_BACKEND=wayland
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export MOZ_ENABLE_WAYLAND=1
      '';
    config = rec {
      output = {
        DP-3 = {
          mode = "3440x1440@144Hz";
          position = "0 0";
        };
      };
      modifier = "Mod4";
      menu = "fuzzel --show run";
      # Use kitty as default terminal
      bars = [{
        command = "waybar";
      }];
      modes.resize = { 

         "Down" = "resize grow height 20 px";
         "Escape" = " mode default";
         "Left" = " resize shrink width 20 px";
         "Return" = "mode default";
         "Right" = "resize grow width 20 px";
         "Up" = "resize shrink height 20 px";
         "h" = "resize shrink width 20 px";
         "j" = "resize grow height 20 px";
         "k" = "resize shrink height 20 px";
         "l" = "resize grow width 20 px";

        };
      terminal = "alacritty";
      fonts =
      {
        names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      }; 
      startup = [
        # Launch Firefox on start
        {command = "alacritty";}
        {command = "kdeconnect-app";}
      ];
    };
    extraConfig = ''
      # Notification Center
      exec swaync
      bindsym Mod4+Shift+n exec 'swaync-client -t -sw'
      
      # Media
      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
      bindsym Mod4+Shift+XF86AudioMute exec "bash $HOME/Scripts/switch_sink.sh"
      
      bindsym XF86AudioPlay exec 'playerctl play-pause'
      bindsym XF86AudioPrev exec 'playerctl previous'
      bindsym XF86AudioNext exec 'playerctl next'
    '';
  };

  # WAYBAR
  programs.waybar = {
    enable = true;
#    settings = [
#      {
#        mainBar = {
#          layer = "top";
#          position = "top";
#          height = "30";
#          modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
#          modules-center = [ "sway/window" ];
#          modules-right = [ "mpd" "tray" ];
#        };
#      }
#    ];
#    style = '/home/coryc/dotfiles/waybar/style.css'';
#      * {
#        border: none;
#        border-radius: 10;
#        font-family: Source Code Pro;
#      }
#      window#waybar {
#        background: #16191C;
#        color: #AAB2BF;
#      }
#      #workspaces button {
#        padding: 0 5px;
#      }  
#    '';
    systemd.enable = true;
  };
}
