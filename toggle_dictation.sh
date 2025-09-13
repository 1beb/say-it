#!/bin/bash

# Toggle script - starts or stops dictation based on current state
PID_FILE="/tmp/dictation.pid"
WHISPER_DIR="/home/b/whisper.cpp"

if [ -f "$PID_FILE" ]; then
    # Currently recording, so stop it
    "$WHISPER_DIR/stop_dictation.sh"
else
    # Not recording, so start it
    "$WHISPER_DIR/start_dictation.sh"
fi