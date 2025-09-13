#!/bin/bash

# Toggle script - starts or stops dictation based on current state
PID_FILE="/tmp/dictation.pid"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$PID_FILE" ]; then
    # Currently recording, so stop it
    "$SCRIPT_DIR/stop_dictation.sh"
else
    # Not recording, so start it
    "$SCRIPT_DIR/start_dictation.sh"
fi