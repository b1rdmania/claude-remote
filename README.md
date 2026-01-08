# Claude Remote

Press Enter on your Mac from your phone. *For when leaning forward is too much.*

Built for use with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — when you're on the couch and Claude's asking if you want to proceed.

## Install (Mac)

```bash
curl -fsSL https://raw.githubusercontent.com/b1rdmania/claude-remote/main/install.sh | bash
```

Then grant Terminal accessibility permissions:
**System Settings → Privacy & Security → Accessibility → Terminal ✓**

## Usage

1. **Start the server on your Mac:**
   ```bash
   claude-remote
   ```

2. **On your iPhone:**
   - Visit [b1rdmania.github.io/claude-remote](https://b1rdmania.github.io/claude-remote)
   - Tap **Setup** and enter the IP shown in your terminal
   - Add to Home Screen (Share → Add to Home Screen)

3. **Press the big orange button.** That's it.

## How it works

- A tiny Flask server runs on your Mac listening for POST requests
- The web app (PWA) sends requests from your phone over your local network  
- AppleScript simulates the Enter keystroke on whatever window is focused

## Requirements

- macOS (uses AppleScript for keystrokes)
- Python 3
- iPhone/iPad on the same WiFi network

## Troubleshooting

**Can't connect?**  
Check your Mac's firewall allows incoming connections on port 5050.

**Button does nothing?**  
Make sure Terminal (or your terminal app) has Accessibility permissions.

**Still not working?**  
Verify both devices are on the same WiFi network. Try `http://YOUR_IP:5050/health` in a browser to test.

## Manual Install

If you prefer not to use the install script:

```bash
pip install flask flask-cors
curl -O https://raw.githubusercontent.com/b1rdmania/claude-remote/main/server.py
python server.py
```

## License

MIT — do whatever you want with it.

---

Made with Claude 🧡
