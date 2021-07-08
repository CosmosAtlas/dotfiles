#!/usr/bin/env bash
# A script to switch between screenlayout set by arandr
# The files are expected to follow the following structure
#

# ~/.screenlayout/
# ├── current.sh
# ├── side_by_side.sh
# └── vert+hori.sh

# Configs follow the naming scheme of [configX].sh
# This script will automatically read the [configX] as name and output

# Prerequisites:
# - arandr to generate the screen layouts
# - rofi/dmenu with rofi preferred

# Make sure all command are available
if ! command -v rofi &> /dev/null
then
    echo "rofi cannot be found falling back to dmenu"
        if ! command -v dmenu &> /dev/null
        then
            echo "dmenu cannot be found, exiting..."
            exit 1
        fi
    exit 1
fi

# Get confiles file in ~/.screenlayout
CONFIGS=($(ls ~/.screenlayout | grep .sh))

echo "Available config files:"
printf '%s\n' ${CONFIGS[*]}

for i in "${!CONFIGS[@]}"; do
    CONFIGS[$i]=${CONFIGS[$i]%.sh}
done

# Select action from dmenu
ACTION=$(printf '%s\n' "${CONFIGS[@]}" | rofi -i -dmenu)

# Make sure the config name is valid
CONFIG_FILE="$HOME/.screenlayout/${ACTION}.sh"
echo $CONFIG_FILE

if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" ${HOME}/.screenlayout/current.sh
    source ~/.screenlayout/current.sh
    echo "Switched screenlayout to ${ACTION}"
    nitrogen --restore
    notify-send "[XRANDR] Switched to ${ACTION} layout"
    betterlockscreen -u ~/Pictures/9pmevg9wa4b41.jpg
    notify-send "[LOCKER] updated lockscreen image"
    exit 0
fi

# Quit if invalid option chosen (e.g., no option or wrong name)
echo "No config or incorrect config given"
exit 1
