#!/bin/bash
# This script calculate the time difference (in seconds) between the eventEstablishedTime and eventReleasedTime

# Display usage and exit if no input file is provided
usage() {
  echo "Usage: $0 [LOG_FILE]" >&2
  exit 1
}

# If the user does not supply at least one argument, give them help
if [[ $# -lt 1 ]]; then
  usage
fi

# Get eventEstablishedTime and eventReleasedTime from the log file
EVENT_ESTABLISHED_TIME=$(sudo grep -B 1 '"type": "eventEstablished"' "$1" | grep 'CH2O' | awk '{print $2 " " $3}' | cut -d '.' -f 1 | sort | uniq | sed 's/./&-/4' | sed 's/./&-/7')

EVENT_RELEASED_TIME=$(sudo grep -B 1 '"type": "eventReleased"' "$1" | grep 'CH2O' | awk '{print $2 " " $3}' | cut -d '.' -f 1 | sort | uniq | sed 's/./&-/4' | sed 's/./&-/7')

# Explicitly set IFS to contain only a line feed
IFS='
'

# Convert the eventEstablishedTime to Epoch time, and store them in an array
for i in $EVENT_ESTABLISHED_TIME; do
  EVENT_ESTABLISHED_TIME_EPOCH=$(date -j -f '%Y-%m-%d %T' "$i" "+%s")
  args+=("$EVENT_ESTABLISHED_TIME_EPOCH")
done
# echo 'eventEstablishedTime array:'
# echo "${args[@]}"

# Convert eventReleasedTime to Epoch time, and store them in an array
for j in $EVENT_RELEASED_TIME; do
  EVENT_RELEASED_TIME_EPOCH=$(date -j -f '%Y-%m-%d %T' "$j" "+%s")
  args1+=("$EVENT_RELEASED_TIME_EPOCH")
done
# echo 'eventReleasedTime array1:'
# echo "${args1[@]}"

# Calculate the difference between the two arrays and store them in an array
for k in "${!args[@]}"; do
  CALL_DURATION=$((args1[k] - args[k]))
  array+=("$CALL_DURATION")
done
# echo "${array[@]}"

# Calculate the average call duration
for m in "${array[@]}"; do
  ((sum += m))
  ((total++))
done
echo "Average call time: $((sum / total)) seconds"