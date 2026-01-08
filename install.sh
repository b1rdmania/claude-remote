#!/bin/bash
#
# Claude Remote - Install Script
# For when leaning forward is too much
#

set -e

INSTALL_DIR="$HOME/.claude-remote"
BIN_DIR="/usr/local/bin"

echo ""
echo "  ╭─────────────────────────────────────╮"
echo "  │        Claude Remote Setup          │"
echo "  ╰─────────────────────────────────────╯"
echo ""

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    echo "   Install it from https://python.org or via Homebrew: brew install python"
    exit 1
fi

echo "📁 Creating install directory..."
mkdir -p "$INSTALL_DIR"

echo "📦 Installing Python dependencies..."
pip3 install --quiet flask flask-cors

echo "📥 Downloading server..."
curl -fsSL https://raw.githubusercontent.com/b1rdmania/claude-remote/main/server.py -o "$INSTALL_DIR/server.py"

echo "🔧 Creating command..."
cat > "$INSTALL_DIR/claude-remote" << 'EOF'
#!/bin/bash
cd "$HOME/.claude-remote"
python3 server.py
EOF
chmod +x "$INSTALL_DIR/claude-remote"

# Try to symlink to /usr/local/bin, fall back to instructions if no permission
if [ -w "$BIN_DIR" ] || sudo -n true 2>/dev/null; then
    sudo ln -sf "$INSTALL_DIR/claude-remote" "$BIN_DIR/claude-remote" 2>/dev/null || \
    ln -sf "$INSTALL_DIR/claude-remote" "$BIN_DIR/claude-remote"
    COMMAND="claude-remote"
else
    COMMAND="~/.claude-remote/claude-remote"
fi

echo ""
echo "  ✅ Installed!"
echo ""
echo "  ╭─────────────────────────────────────╮"
echo "  │  Next steps:                        │"
echo "  │                                     │"
echo "  │  1. Grant Terminal accessibility:   │"
echo "  │     System Settings → Privacy &     │"
echo "  │     Security → Accessibility        │"
echo "  │                                     │"
echo "  │  2. Run the server:                 │"
echo "  │     $COMMAND"
echo "  │                                     │"
echo "  │  3. On your phone, visit:           │"
echo "  │     https://b1rdmania.github.io/    │"
echo "  │     claude-remote                   │"
echo "  │                                     │"
echo "  ╰─────────────────────────────────────╯"
echo ""
