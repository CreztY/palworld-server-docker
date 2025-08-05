#!/bin/bash
# install_server.sh - Install Palworld dedicated server

set -e

echo "Installing Palworld Dedicated Server..."

# Install/Update Palworld server using SteamCMD
${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${PALWORLD_DIR} +login anonymous +app_update 2394010 validate +quit

echo "Palworld server installation completed!"

# Set executable permissions
chmod +x ${PALWORLD_DIR}/PalServer.sh

# Create symbolic link for easier config management
if [ ! -L "${PALWORLD_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini" ]; then
    mkdir -p ${PALWORLD_DIR}/Pal/Saved/Config/LinuxServer/
    ln -sf ${PALWORLD_CONFIG_DIR}/PalWorldSettings.ini ${PALWORLD_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
fi

# Link save data directory
if [ ! -L "${PALWORLD_DIR}/Pal/Saved/SaveGames" ]; then
    mkdir -p ${PALWORLD_DATA_DIR}/SaveGames
    ln -sf ${PALWORLD_DATA_DIR}/SaveGames ${PALWORLD_DIR}/Pal/Saved/SaveGames
fi

echo "Server setup completed!"