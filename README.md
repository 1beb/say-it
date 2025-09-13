# Whisper.cpp Voice Dictation System

## System Requirements

### Platform
- Ubuntu 24.04 (or similar Linux distribution)
- Wayland or X11 session (Wayland tested)

### Dependencies Installed
- **whisper.cpp** - Built from source with CMake
- **ydotool** - For typing text in Wayland/X11
- **arecord** (alsa-utils) - For audio recording
- **sox** - For audio feedback beeps
- **ffmpeg** - For audio format conversion if needed
- **Build tools**: gcc, g++, cmake, build-essential

### Installation Commands
```bash
# Build dependencies (already installed)
sudo apt install build-essential cmake git

# Audio and typing tools (already installed)
sudo apt install alsa-utils sox ffmpeg ydotool

# Note: ydotool works even with the "backend unavailable" warning
```

## Setting Up Keyboard Shortcut (Ubuntu GNOME)

1. Open **Settings** → **Keyboard** → **View and Customize Shortcuts**
2. Scroll down to **Custom Shortcuts**
3. Click the **'+'** button to add a new shortcut
4. Enter:
   - **Name:** Whisper Dictation Toggle
   - **Command:** `/home/b/projects/say-it/toggle_dictation.sh`
   - **Shortcut:** Click "Set Shortcut" and press your desired keys (e.g., Super+Alt+D)

## Quick Reference

### Keyboard Shortcut
**Super+Alt+D** (or your chosen keys) - Toggle dictation on/off

### How It Works
1. Press your shortcut key to start recording
2. Speak clearly into your microphone
3. Press the same shortcut key again to stop recording
4. Whisper.cpp transcribes your speech
5. Text is automatically typed at your cursor position using ydotool

### Project Files
- `/home/b/projects/say-it/start_dictation.sh` - Starts audio recording
- `/home/b/projects/say-it/stop_dictation.sh` - Stops recording and types transcribed text
- `/home/b/projects/say-it/toggle_dictation.sh` - Toggle script (used by keyboard shortcut)

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
/home/b/projects/say-it/toggle_dictation.sh
```

#### Change Keyboard Shortcut
Go to: Settings → Keyboard → Custom Shortcuts → "Whisper Dictation Toggle"

#### If ydotool stops working
The warning "ydotoold backend unavailable" is normal and doesn't affect functionality.
If typing stops working completely, you may need to restart your session.

### Performance Tips
- Speak clearly and at a normal pace
- Minimize background noise
- The transcription typically takes 1-3 seconds after stopping
- For longer dictations, the base.en model can handle several minutes of audio

### Alternative Models
To use a different model, edit the MODEL variable in the scripts:
- `tiny.en` (75 MB) - Faster but less accurate
- `small.en` (466 MB) - More accurate but slower
- `large-v3-turbo-q5_0` (547 MB) - Best accuracy, requires more processing time