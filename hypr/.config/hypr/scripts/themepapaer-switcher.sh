#!/usr/bin/env bash

IMG=""

# if [ -z "$1" ]; then
#    IMG="$IMAGE" 
# else 
#     IMG="$1"
# fi

if [ -z "$1" ]; then
    IMAGE=$(grep "^IMAGE=" ~/.zshrc | cut -d'=' -f2- | tr -d '"')
    IMG="$IMAGE"
else 
    IMG="$1"
fi

# PYWAL_DISCORD_THEME="/usr/share/pywal-discord/pywal-discord-abou.css"
TRANSITION_POSITIONS=('center' 'top' 'left' 'right' 'bottom' 'top-left' 'top-right' 'bottom-left' 'bottom-right')

RANDOM_POS_INDEX=$((RANDOM % ${#TRANSITION_POSITIONS[@]}))

RANDOM_TRANSITION_POS=${TRANSITION_POSITIONS[$RANDOM_POS_INDEX]}

if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi
 
swww img "$IMG" \
    --transition-type outer \
    --transition-pos $RANDOM_TRANSITION_POS \
    --transition-fps 60 \
    --transition-step 90 \
    --transition-duration 7

matugen image "$IMG"

wal -i "$IMG"

# pywal-discord -t "$PYWAL_DISCORD_THEME" 

pkill -x waybar 
waybar > /dev/null 2>&1 &

pkill -x swaync
swaync > /dev/null 2>&1 &

pkill -x rofi

if  grep -q "^IMAGE=" ~/.zshrc ; then
    sed -i "s|^IMAGE=.*|IMAGE=\"$IMG\"|" ~/.zshrc
else
    echo "IMAGE=\"$IMG\"" >> ~/.zshrc
fi

sed -i "s|^background-image:.*|background-image: url(\"$IMG\", height);|" ~/.config/rofi/styles/style_1.rasi
sed -i "s|^background-image:.*|background-image: url(\"$IMG\", height);|" ~/.config/rofi/styles/style.rasi

sed -i "s|\s*path\s*=\s*/home/.*|    path = $IMG|" ~/.config/hypr/hyprlock.conf

sed -i "s|\s*preload\s*=.*|preload = $IMG|" ~/.config/hypr/hyprpaper.conf
sed -i "s|\s*wallpaper\s*=.*|wallpaper = , $IMG|" ~/.config/hypr/hyprpaper.conf

source ~/.zshrc
