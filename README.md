# Say-It: Whisper.cpp Voice Dictation System

## Prerequisites

### Platform

Tested on: 
- Ubuntu 24.04
- Wayland

### 1. Install whisper.cpp

```bash
git clone https://github.com/ggml-org/whisper.cpp.git
cd whisper.cpp
cmake -B build
cmake --build build -j

# Download base.en model (recommended for dictation)
cd models
bash download-ggml-model.sh base.en
```

### 2. System Dependencies

Install required packages on Ubuntu:
```bash
sudo apt install ydotool sox alsa-utils
```

## Setup

### 1. Clone this repository

```bash
git clone <repository-url> ~/projects/say-it
cd ~/projects/say-it
```

### 2. Configure whisper.cpp path

The scripts will look for whisper.cpp in `~/whisper.cpp` by default.

If your whisper.cpp is installed elsewhere, set the environment variable:
```bash
# Add to your ~/.bashrc or ~/.profile
export WHISPER_CPP_PATH="/path/to/your/whisper.cpp"
```

### 3. Set Up Keyboard Shortcut (Ubuntu GNOME)

1. Open **Settings** → **Keyboard** → **View and Customize Shortcuts**
2. Scroll down to **Custom Shortcuts**
3. Click the **'+'** button to add a new shortcut
4. Enter:
   - **Name:** Say-It Dictation
   - **Command:** Full path to toggle script (e.g., `/home/YOUR_USERNAME/projects/say-it/toggle_dictation.sh`)
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

- `start_dictation.sh` - Starts audio recording
- `stop_dictation.sh` - Stops recording and types transcribed text
- `toggle_dictation.sh` - Toggle script (used by keyboard shortcut)

### Whisper Model

Default: **base.en** (142 MB) - English-only model with good speed/accuracy balance

To use a different model:
1. Download it to your whisper.cpp/models directory
2. Update the MODEL variable in start_dictation.sh and stop_dictation.sh

## Troubleshooting

### Check Debug Log
```bash
tail -f /tmp/dictation_debug.log
```

### Test Recording
```bash
# Run the toggle script manually to test
cd ~/projects/say-it
./toggle_dictation.sh
```

### If ydotool stops working
The warning "ydotoold backend unavailable" is normal and doesn't affect functionality.
If typing stops working completely, you may need to restart your session.

## Performance Tips

- Speak clearly and at a normal pace
- Minimize background noise
- The transcription typically takes 1-3 seconds after stopping
- For longer dictations, the base.en model can handle several minutes of audio

## Alternative Models

To use a different model, edit the MODEL variable in the scripts:
- `tiny.en` (75 MB) - Faster but less accurate
- `small.en` (466 MB) - More accurate but slower
- `large-v3-turbo-q5_0` (547 MB) - Best accuracy, requires more processing time