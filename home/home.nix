{ config, pkgs, ... }:

let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'catppuccin-gtk'
    '';
  };


in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  imports = [
  ];

  home.username = "coryc";
  home.homeDirectory = "/home/coryc";

  home.packages = with pkgs; [

  ];

  fonts.fontconfig.enable = true;

  programs.starship = { enable = true;
       settings = {
         add_newline = true;
         character = {
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
        };
      };
	};


  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      hm-switch = "home-manager switch --flake /home/coryc/dotfiles/#coryc --impure";
      k = "kubectl";
	  kcn = "kubectl config set-context $(kubectl config current-context) --namespace";
	};
    initExtra =
	''
VISUAL="nvim"
EDITOR="$VISUAL"
TALOSCONFIG=/home/coryc/ChambersLab/talos/talosconfig
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
bindkey -v
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
source <(talosctl completion zsh)
eval "$(starship init zsh)"
	'';
    localVariables = {
      KUBECONFIG="$HOME/Documents/k8s/cerberos.yaml";
      dotfiles="$HOME/dotfiles";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = [
     # {
     #   name = "powerlevel10k";
     #   src = pkgs.zsh-powerlevel10k;
     #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
     # }
     # {
     #   name = "powerlevel10k-config";
     #   src = ../configs/zsh/powerlevel10k-config;
     #   file = ".p10k.zsh";
     # }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = ["git"] ;
    };
  };

  programs.fzf = {
  enable = true;
  enableZshIntegration = true;
  };
  # Cursor -- Primarily in a TWM
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  nix.gc = {
    automatic = true;  # Enable the automatic garbage collector
    frequency = "weekly";   # When to run the garbage collector
    options = "--delete-older-than 30d";    # Arguments to pass to nix-collect-garbage
  };

}
