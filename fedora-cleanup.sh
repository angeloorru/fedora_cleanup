#!/bin/bash

###################################
# Fedora system cleanup script by AO @ github.com/angeloorru
###################################


echo "Cleaning DNF package cache..."
sudo dnf clean all

# Comment this if using GNOME DE as this is only for KDE DE
echo "Cleaning /tmp and KDE cache..."
sudo rm -rf /tmp/*
rm -rf ~/.cache/*

echo "Clearing KDE thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

# OPTIONAL- Uncomment lines below to run
#echo "Removing old kernels, keeping the latest 2..."
#sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)

echo "Removing orphaned packages..."
sudo dnf autoremove -y

echo "Removing old versions of Flatpak apps..."
flatpak uninstall --unused

echo "Running Flatpak repair to clean up caches and orphaned files..."
flatpak repair

# OPTIONAL - Uncomment lines below if flatpack cache needs to be cleared
#echo "Clearing Flatpak download cache..."
#sudo rm -rf /var/tmp/flatpak-cache-*

echo "Cleaning up journal logs, keeping the last week..."
sudo journalctl --vacuum-time=1w

echo "Removing broken symlinks..."
find ~ -xtype l -delete

# OPTIONAL: Uncomment to clean systemctl services - You need to specify the service's name
# i.e: sudo systemctl clean nginx.service mysql.service etc...
#echo "Cleaning systemd residual files..."
#sudo systemctl clean <service-name>

echo "Cleanup completed!"
echo "Well done!"
