#!/bin/bash
set -eu

data=$(cat)

model=$(echo "$data" | python3 -c "import sys,json; print(json.load(sys.stdin).get('model',{}).get('display_name',''))" 2>/dev/null || echo "")
used=$(echo "$data" | python3 -c "import sys,json; print(int(json.load(sys.stdin).get('context_window',{}).get('used_percentage',0)))" 2>/dev/null || echo "0")
cost=$(echo "$data" | python3 -c "import sys,json; print(f\"{json.load(sys.stdin).get('cost',{}).get('total_cost_usd',0):.2f}\")" 2>/dev/null || echo "0.00")
duration_ms=$(echo "$data" | python3 -c "import sys,json; print(json.load(sys.stdin).get('cost',{}).get('total_duration_ms',0))" 2>/dev/null || echo "0")

minutes=$(( duration_ms / 60000 ))
seconds=$(( (duration_ms % 60000) / 1000 ))
duration="${minutes}m${seconds}s"

bar_width=20
filled=$(( used * bar_width / 100 ))
empty=$(( bar_width - filled ))

if [ "$used" -lt 50 ]; then
    color="\033[38;2;136;192;208m" # nord8 cyan
elif [ "$used" -lt 80 ]; then
    color="\033[38;2;235;203;139m" # nord13 yellow
else
    color="\033[38;2;191;97;106m"  # nord11 red
fi
reset="\033[0m"
dim="\033[2m"

bar="${color}"
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done
bar+="${reset}"

printf "%b  %b %s  %b%s%b  \$%s" \
    "${dim}${model}${reset}" \
    "$bar" "${used}%" \
    "${dim}" "$duration" "${reset}" \
    "$cost"
