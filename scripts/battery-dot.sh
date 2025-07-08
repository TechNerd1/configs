#!/bin/bash

# Get battery percentage
BATTERY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)

# Default if no battery found
if [ -z "$BATTERY" ]; then
    echo '{"text": "●", "class": "no-battery", "tooltip": "Desktop - No battery"}'
    exit
fi

# Determine color based on battery percentage
if [ $BATTERY -gt 80 ]; then
    color="#9ece6a"  # Green
    class="excellent"
elif [ $BATTERY -gt 60 ]; then
    color="#e0af68"  # Yellow
    class="good"
elif [ $BATTERY -gt 30 ]; then
    color="#ff9e64"  # Orange
    class="warning"
else
    color="#f7768e"  # Red
    class="critical"
fi

# Output JSON for waybar with inline styling
echo "{\"text\": \"<span color='$color'>●</span>\", \"tooltip\": \"Battery: ${BATTERY}%\", \"class\": \"$class\"}"
