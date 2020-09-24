#!/usr/bin/env bash
# A script to switch between clash config files
# The files are expected to follow the following structure
#
# ~/.config/clash/
# ├── config.yaml
# ├── Country.mmdb
# ├── config1.config.yaml
# ├── config2.config.yaml
# └── config3.config.yaml

# Configs follow the naming scheme of [configX].config.yaml
# This script will automatically read the [configX] as name and output
# NOTE: You have to make sure these config files matches your system settings.
# For example, if you use different ports in different config files, your proxy
# settings may also need to be updated. Please modify this script as needed.

# Prerequisites:
# - clash (duh...)
# - pm2 (a node utility to manage processes, bascially a slim systemd)
# - rofi/dmenu with rofi preferred

# Make sure all command are available
if ! command -v clash &> /dev/null
then
    echo "clash cannot be found, exiting..."
    exit 1
fi

if ! command -v pm2 &> /dev/null
then
    echo "pm2 cannot be found, exiting..."
    exit 1
fi

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

# Get confiles file in ~/.config/clash/
CONFIGS=($(ls ~/.config/clash | grep .config.yaml))

echo "Available config files:"
printf '%s\n' ${CONFIGS[*]}

for i in "${!CONFIGS[@]}"; do
    CONFIGS[$i]=${CONFIGS[$i]%.config.yaml}
done

# Select action from dmenu
ACTION=$(printf '%s\n' "${CONFIGS[@]}" | rofi -i -dmenu)

# Make sure the config name is valid
CONFIG_FILE="$HOME/.config/clash/${ACTION}.config.yaml"
echo $CONFIG_FILE

if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" ${HOME}/.config/clash/config.yaml
    pm2 restart clash
    echo "Switched config file to: ${ACTION}"
    notify-send "[CLASH] Switched to ${ACTION}"
    exit 0
fi

# Quit if invalid option chosen (e.g., no option or wrong name)
echo "No config or incorrect config given"
exit 1
