#!/bin/bash
# start_server.sh - Start Palworld dedicated server

set -e

echo "Starting Palworld Dedicated Server..."

# Check if server files exist, if not install them
if [ ! -f "${PALWORLD_DIR}/PalServer.sh" ]; then
    echo "Server files not found, installing..."
    /usr/local/bin/install_server.sh
fi

# Update server if UPDATE_ON_START is set to true
if [ "${UPDATE_ON_START}" = "true" ]; then
    echo "Updating server..."
    /usr/local/bin/install_server.sh
fi

# Set default values for environment variables
SERVER_NAME="${SERVER_NAME:-Palworld Docker Server}"
SERVER_DESCRIPTION="${SERVER_DESCRIPTION:-A Palworld server running in Docker}"
SERVER_PASSWORD="${SERVER_PASSWORD:-}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-admin123}"
MAX_PLAYERS="${MAX_PLAYERS:-32}"
PUBLIC_PORT="${PUBLIC_PORT:-8211}"
RCON_ENABLED="${RCON_ENABLED:-true}"
RCON_PORT="${RCON_PORT:-25575}"

# Create runtime config if it doesn't exist or if RECREATE_CONFIG is true
if [ ! -f "${PALWORLD_CONFIG_DIR}/PalWorldSettings.ini" ] || [ "${RECREATE_CONFIG}" = "true" ]; then
    echo "Creating server configuration..."
    cat > "${PALWORLD_CONFIG_DIR}/PalWorldSettings.ini" << EOF
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=None,DayTimeSpeedRate=1.000000,NightTimeSpeedRate=1.000000,ExpRate=1.000000,PalCaptureRate=1.000000,PalSpawnNumRate=1.000000,PalDamageRateAttack=1.000000,PalDamageRateDefense=1.000000,PlayerDamageRateAttack=1.000000,PlayerDamageRateDefense=1.000000,PlayerStomachDecreaceRate=1.000000,PlayerStaminaDecreaceRate=1.000000,PlayerAutoHPRegeneRate=1.000000,PlayerAutoHpRegeneRateInSleep=1.000000,PalStomachDecreaceRate=1.000000,PalStaminaDecreaceRate=1.000000,PalAutoHPRegeneRate=1.000000,PalAutoHpRegeneRateInSleep=1.000000,BuildObjectDamageRate=1.000000,BuildObjectDeteriorationDamageRate=1.000000,CollectionDropRate=1.000000,CollectionObjectHpRate=1.000000,CollectionObjectRespawnSpeedRate=1.000000,EnemyDropItemRate=1.000000,DeathPenalty=Item,bEnablePlayerToPlayerDamage=False,bEnableFriendlyFire=False,bEnableInvaderEnemy=True,bActiveUNKO=False,bEnableAimAssistPad=True,bEnableAimAssistKeyboard=False,DropItemMaxNum=3000,DropItemMaxNum_UNKO=100,BaseCampMaxNum=128,BaseCampWorkerMaxNum=15,DropItemAliveMaxHours=1.000000,bAutoResetGuildNoOnlinePlayers=False,AutoResetGuildTimeNoOnlinePlayers=72.000000,GuildPlayerMaxNum=20,PalEggDefaultHatchingTime=72.000000,WorkSpeedRate=1.000000,bIsMultiplay=False,bIsPvP=False,bCanPickupOtherGuildDeathPenaltyDrop=False,bEnableNonLoginPenalty=True,bEnableFastTravel=True,bIsStartLocationSelectByMap=True,bExistPlayerAfterLogout=False,bEnableDefenseOtherGuildPlayer=False,CoopPlayerMaxNum=4,ServerPlayerMaxNum=${MAX_PLAYERS},ServerName="${SERVER_NAME}",ServerDescription="${SERVER_DESCRIPTION}",AdminPassword="${ADMIN_PASSWORD}",ServerPassword="${SERVER_PASSWORD}",PublicPort=${PUBLIC_PORT},PublicIP="",RCONEnabled=${RCON_ENABLED},RCONPort=${RCON_PORT},Region="",bUseAuth=True,BanListURL="https://api.palworldgame.com/api/banlist.txt")
EOF
fi

echo "Server configuration:"
echo "  Server Name: ${SERVER_NAME}"
echo "  Max Players: ${MAX_PLAYERS}"
echo "  Public Port: ${PUBLIC_PORT}"
echo "  RCON Enabled: ${RCON_ENABLED}"
echo "  RCON Port: ${RCON_PORT}"

# Start the server
cd ${PALWORLD_DIR}
exec ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS