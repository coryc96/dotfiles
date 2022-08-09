# add HM channels

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# install HM
nix-shell '<home-manager>' -A install
