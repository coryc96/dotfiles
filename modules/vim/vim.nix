{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    gcc
    fd
    ripgrep
    gnumake
  ];

  xdg.configFile."nvim/init.lua".source = ../../configs/nvim/init.lua;

  #NeoVim
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };
}
