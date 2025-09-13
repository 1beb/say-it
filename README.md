# Whisper.cpp Voice Dictation System

## System Requirements

### Platform

Tested on: 

- Ubuntu 24.04
- Wayland

### Installation Commands

```bash
# Build dependencies (already installed)
sudo apt install build-essential cmake git

# Audio and typing tools (already installed)
sudo apt install alsa-utils sox ffmpeg ydotool

# Note: ydotool works even with the "backend unavailable" warning
```

Install whisper.cpp following the repository instructions at: https://github.com/ggml-org/whisper.cpp

## Setting Up Keyboard Shortcut (Ubuntu GNOME)

1. Open **Settings** → **Keyboard** → **View and Customize Shortcuts**
2. Scroll down to **Custom Shortcuts**
3. Click the **'+'** button to add a new shortcut
4. Enter:
   - **Name:** Whisper Dictation Toggle
   - **Command:** `/path/to/say-it/toggle_dictation.sh`
   - **Shortcut:** Click "Set Shortcut" and press your desired keys (e.g., Super+Alt+D)

## Quick Reference

### Keyboard Shortcut

I use **Super+D**, because I don't use the desktop. Choose your own adventure here. 

### How It Works

1. Press your shortcut key to start recording
2. Speak clearly into your microphone
3. Press the same shortcut key again to stop recording
4. Whisper.cpp transcribes your speech
5. Text is automatically typed at your cursor position using ydotool

### Project Files
- `/path/to/say-it/start_dictation.sh` - Starts audio recording
- `/path/to/say-it/stop_dictation.sh` - Stops recording and types transcribed text
- `/path/to/say-it/toggle_dictation.sh` - Toggle script (used by keyboard shortcut)

### Model

Using: **base.en** (142 MB) - English-only model with good speed/accuracy balance

### Troubleshooting

#### Check Debug Log
```bash
tail -f /tmp/dictation_debug.log
```

#### Test Recording
```bash
# Run the toggle script manually to test
/say-it/toggle_dictation.sh
```

### Alternative Models

To use a different model, edit the MODEL variable in the scripts:
- `tiny.en` (75 MB) - Faster but less accurate
- `small.en` (466 MB) - More accurate but slower
- `large-v3-turbo-q5_0` (547 MB) - Best accuracy, requires more processing time
