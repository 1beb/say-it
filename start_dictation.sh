#!/bin/bash

# Configuration
WHISPER_DIR="/home/b/whisper.cpp"
MODEL="$WHISPER_DIR/models/ggml-base.en.bin"
TEMP_AUDIO="/tmp/dictation_recording.wav"
TEMP_TEXT="/tmp/dictation_text.txt"
PID_FILE="/tmp/dictation.pid"

# Check if already recording
if [ -f "$PID_FILE" ]; then
    echo "Dictation already in progress"
    exit 1
fi

# Clean up any previous files
rm -f "$TEMP_AUDIO" "$TEMP_TEXT"

# Start recording in background (16kHz mono, required by Whisper)
arecord -f S16_LE -r 16000 -c 1 "$TEMP_AUDIO" &
RECORD_PID=$!

# Save PID for stop script
echo $RECORD_PID > "$PID_FILE"

# Visual/audio feedback that recording started
notify-send "Dictation Started" "Press shortcut to stop and transcribe" 2>/dev/null || echo "Recording started..."

# Optional: Play a beep sound to indicate start (if sox is installed)
play -n synth 0.1 sine 800 2>/dev/null &

echo "Recording... Press the stop shortcut to finish."