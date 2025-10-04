# Runs ping stats and traceroute and saves the output to a timestamped text file
#!/bin/bash
OUT=~/Documents/pingTrace-$(date +%Y%m%d-%H%M%S).txt

echo "===== Network Test $(date) =====" > "$OUT"

# First ping (20 packets)
echo "Ping 20 packets (1.1.1.1):" >> "$OUT"
ping -c 20 1.1.1.1 | tail -n 1 >> "$OUT"
echo "" >> "$OUT"

# Second ping (50 packets)
echo "Ping 50 packets (1.1.1.1):" >> "$OUT"
ping -c 50 1.1.1.1 | tail -n 1 >> "$OUT"
echo "" >> "$OUT"

# Traceroute
echo "Traceroute (1.1.1.1):" >> "$OUT"
traceroute 1.1.1.1 >> "$OUT" 2>&1
echo "" >> "$OUT"

echo "Log saved to $OUT"
