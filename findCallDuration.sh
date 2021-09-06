#!/bin/bash
# This script calculate the time difference (in seconds) between the eventEstablishedTime and eventReleasedTime

# display usage and exit if no input file is provided
usage() {
  echo "Usage: $0 [LOG_FILE]" >&2
  exit 1
}

# if the user does not supply at least one argument, give them help
if [[ $# -lt 1 ]]; then
  usage
fi

# get eventEstablishedTime and eventReleasedTime from the log file
EVENT_ESTABLISHED_TIME=$(sudo grep -B 1 '"type": "eventEstablished"' "$1" | grep 'CH2O' | awk '{print $2 " " $3}' | cut -d '.' -f 1 | sort | uniq | sed 's/./&-/4' | sed 's/./&-/7')

EVENT_RELEASED_TIME=$(sudo grep -B 1 '"type": "eventReleased"' "$1" | grep 'CH2O' | awk '{print $2 " " $3}' | cut -d '.' -f 1 | sort | uniq | sed 's/./&-/4' | sed 's/./&-/7')

echo "Event Established at: $EVENT_ESTABLISHED_TIME"
echo "Event Released at: $EVENT_RELEASED_TIME"

# convert the eventEstablishedTime and eventReleasedTime to seconds, Epoch time
EVENT_ESTABLISHED_TIME_EPOCH=$(date -j -f '%Y-%m-%d %T' "$EVENT_ESTABLISHED_TIME" "+%s")
EVENT_RELEASED_TIME_EPOCH=$(date -j -f '%Y-%m-%d %T' "$EVENT_RELEASED_TIME" "+%s")

# calculate the difference between the eventEstablishedTime and eventReleasedTime
echo "Call time: $(($EVENT_RELEASED_TIME_EPOCH - $EVENT_ESTABLISHED_TIME_EPOCH)) seconds"