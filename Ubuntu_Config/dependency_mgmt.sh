#!/bin/sh
# XMonad install
sudo apt-get install xmonad

# For Gnome-XMonad Compatibility
sudo add-apt-repository ppa:gekkio/xmonad
sudo apt-get update
sudo apt-get install gnome-session-xmonad

# Gnome-Do, as it seems to be out of modern gnome
sudo apt-get install gnome-do
