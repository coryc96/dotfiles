#!/usr/bin/env bash

set -ex

flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

sh scripts/flatpak.sh

cat dconf | dconf load /
echo "Setup complete. Reboot if this is the first time."
