#!/bin/bash

# Configuration
WHISPER_DIR="/home/b/whisper.cpp"
WHISPER_BIN="$WHISPER_DIR/build/bin/whisper-cli"
MODEL="$WHISPER_DIR/models/ggml-base.en.bin"
TEMP_AUDIO="/tmp/dictation_recording.wav"
TEMP_TEXT="/tmp/dictation_text.txt"
PID_FILE="/tmp/dictation.pid"

# Check if recording is in progress
if [ ! -f "$PID_FILE" ]; then
    echo "No dictation in progress"
    notify-send "No Dictation" "Start dictation first" 2>/dev/null
    exit 1
fi

# Stop recording
RECORD_PID=$(cat "$PID_FILE")
if kill -0 $RECORD_PID 2>/dev/null; then
    kill $RECORD_PID
    sleep 0.5  # Give it time to finish writing
else
    echo "Recording process not found"
    rm -f "$PID_FILE"
    exit 1
fi

# Clean up PID file
rm -f "$PID_FILE"

# Check if audio file was created
if [ ! -f "$TEMP_AUDIO" ]; then
    echo "No audio file found"
    notify-send "Dictation Error" "No audio recorded" 2>/dev/null
    exit 1
fi

# Visual feedback that processing
notify-send "Processing..." "Transcribing audio with Whisper" 2>/dev/null || echo "Transcribing..."

# Transcribe with Whisper
# Using flags for better dictation:
# -nt: no timestamps
# -np: no special tokens
# -t 8: use 8 threads for faster processing
"$WHISPER_BIN" -m "$MODEL" -f "$TEMP_AUDIO" -nt -np -t 8 --no-prints 2>/dev/null | tail -n +2 > "$TEMP_TEXT"

# Check if transcription succeeded
if [ ! -s "$TEMP_TEXT" ]; then
    echo "Transcription failed or no speech detected"
    notify-send "Dictation Error" "No text transcribed" 2>/dev/null
    exit 1
fi

# Get the transcribed text (remove extra whitespace)
TEXT=$(cat "$TEMP_TEXT" | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Type the text at cursor position
if [ -n "$TEXT" ]; then
    # Log for debugging
    echo "$(date): Transcribed text: $TEXT" >> /tmp/dictation_debug.log
    
    # Small delay to ensure window focus is ready
    sleep 0.2
    
    # Type the text using ydotool (works with both Wayland and X11)
    ydotool type "$TEXT" 2>>/tmp/dictation_debug.log
    
    # Success feedback with actual text
    notify-send "Dictation Complete" "$TEXT" 2>/dev/null || echo "Text typed: $TEXT"
    
    # Optional: Play a beep sound to indicate completion
    play -n synth 0.1 sine 600 2>/dev/null &
else
    echo "No text to insert"
    notify-send "Dictation" "No speech detected" 2>/dev/null
fi

# Clean up temporary files
rm -f "$TEMP_AUDIO" "$TEMP_TEXT"