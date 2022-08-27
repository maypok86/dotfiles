#!/bin/sh

pushd ~/projects/dotfiles
home-manager switch -f ./home/home.nix
popd
