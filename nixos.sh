#!/usr/bin/env bash

set -ex

NIXPKGS=(
nixos.firefox
nixos.gnome-text-editor
nixos.gnome.gnome-tweaks
nixos.git
nixos.python3
nixos.rustup
nixos.podman
nixos.distrobox
nixos.remmina
)

mkdir -p ~/.config/nixpkgs/
cp nix/config.nix ~/.config/nixpkgs/config.nix

nix-env --install --attr "${NIXPKGS[@]}"

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

sh scripts/flatpak.sh

cat dconf | dconf load /

mkdir -p ~/Scripts/
cp scripts/switch_audio.sh ~/Scripts
cp scripts/launch_rdp.sh ~/Scripts

echo "Setup complete. Reboot if this is the first time."
