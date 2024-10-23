#!/bin/bash

###################################
# Fedora system cleanup script by AO @ github.com/angeloorru
###################################


echo "Cleaning DNF package cache..."
sudo dnf clean all

echo "Removing orphaned packages..."
sudo dnf autoremove -y

echo "Cleaning /tmp and KDE cache..."
sudo rm -rf /tmp/*
rm -rf ~/.cache/*

echo "Clearing KDE thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

# OPTIONAL- Uncomment lines below to run
#echo "Removing old kernels, keeping the latest 2..."
#sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)

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

echo
echo
echo

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊${NC}"
echo -e "${CYAN}┌───────────────────────────────┐${NC}"
echo -e "${CYAN}│ ${GREEN} Cleanup completed! ✅        ${CYAN}│${NC}"
echo -e "${CYAN}│ ${GREEN} Well done! 👍                ${CYAN}│${NC}"
echo -e "${CYAN}└───────────────────────────────┘${NC}"