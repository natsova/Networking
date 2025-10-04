#!/bin/bash
# Logs ping results, connection type, and detects drops for the device running the script

TARGET="1.1.1.1"
LOG="$HOME/Documents/connectionmonitor-$(date +%Y%m%d-%H%M%S).txt"
INTERVAL=5

echo "===== Internet Monitoring Started: $(date) =====" >> "$LOG"

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # Determine active interface type (Ethernet or Wi-Fi)
    IFACE_TYPE=$(nmcli -t -f TYPE,STATE device status | grep ':connected' | awk -F: '{print $1}' | head -n 1)
    if [ -z "$IFACE_TYPE" ]; then
        IFACE_TYPE="Unknown"
    fi

    # Ping once
    PING_OUTPUT=$(ping -c 1 $TARGET 2>&1)

    if echo "$PING_OUTPUT" | grep -q "1 packets transmitted, 0 received"; then
        echo "$TIMESTAMP - $IFACE_TYPE - DROP: No response from $TARGET" >> "$LOG"
    else
        RTT=$(echo "$PING_OUTPUT" | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')
        echo "$TIMESTAMP - $IFACE_TYPE - OK: $RTT ms" >> "$LOG"
    fi

    sleep $INTERVAL
done
