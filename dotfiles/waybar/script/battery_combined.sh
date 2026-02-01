#!/bin/bash

# BAT0
bat0=$(cat /sys/class/power_supply/BAT0/capacity)
status0=$(cat /sys/class/power_supply/BAT0/status)

# Ícone da BAT0
if [ "$status0" = "Charging" ]; then
    icon0=""
elif [ $bat0 -ge 80 ]; then
    icon0=""
elif [ $bat0 -ge 60 ]; then
    icon0=""
elif [ $bat0 -ge 40 ]; then
    icon0=""
elif [ $bat0 -ge 20 ]; then
    icon0=""
else
    icon0=""
fi

# Cor da BAT0
if [ "$bat0" -le 15 ]; then
    color="#ff5555"
elif [ "$bat0" -le 30 ]; then
    color="#ffaa00"
else
    color="#ffffff"
fi

# BAT2
bat2=$(cat /sys/class/power_supply/BAT2/capacity)

# Perfil de energia via power-profiles-daemon
profile=$(gdbus call --system --dest net.hadess.PowerProfiles \
           --object-path /net/hadess/PowerProfiles \
           --method net.hadess.PowerProfiles.GetActiveProfile | awk -F\' '{print $2}')

# Ícone do perfil
case $profile in
    "performance") profile_icon="" ;;
    "balanced") profile_icon="" ;;
    "power-saver") profile_icon="" ;;
    *) profile_icon="" ;;
esac

# Output final
echo "<span color=$color>$bat0% $icon0</span> | BAT2: $bat2% | $profile_icon $profile"
