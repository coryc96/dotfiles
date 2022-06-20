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

sh flatpak.sh

if [ ! -d "${HOME}/Projects/pop" ]
then
	mkdir -p "${HOME}/Projects"
	git clone https://github.com/pop-os/pop.git "${HOME}/Projects/pop"
fi
pushd "${HOME}/Projects/pop"
	./scripts/clone cosmic
	pushd cosmic
		nix-shell \
			--packages glib.dev \
			--run "make && make install"
	popd

	./scripts/clone cosmic-workspaces
	pushd cosmic-workspaces
		nix-shell \
			--packages glib.dev \
			--run "make && make install"
	popd

	./scripts/clone gtk-theme
	pushd gtk-theme
		rm -rf build
		nix-shell \
			--packages glib.dev meson ninja sassc \
			--run "meson build --prefix=${HOME}/.local && ninja -C build install"
	popd

	./scripts/clone icon-theme
	pushd icon-theme
		rm -rf build
		echo nix-shell \
			--packages glib.dev meson ninja \
			--run "meson build --prefix=${HOME}/.local && ninja -C build install"
	popd

	./scripts/clone launcher
	pushd launcher
		nix-shell \
			--packages gtk3 just openssl.dev pkgconfig \
			--run "just && just install"
	popd

	./scripts/clone shell
	pushd shell
		nix-shell \
			--packages glib.dev nodePackages.typescript \
			--run "make && make install"
	popd
popd

cat dconf | dconf load /

mkdir -p ~/Scripts/
cp scripts/switch_audio.sh ~/Scripts
cp scripts/launch_rdp.sh ~/Scripts

echo "Setup complete. Reboot if this is the first time."
