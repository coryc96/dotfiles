#!/bin/bash
set -ex

flatpkgs=(
com.spotify.Client 
org.ferdium.Ferdium
com.mattjakeman.ExtensionManager
org.gnome.Extensions
com.github.tchx84.Flatseal
)

flatpak install -y --noninteractive flathub "${flatpkgs[@]}"
