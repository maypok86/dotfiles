#!/bin/sh

pushd ~/projects/dotfiles
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
