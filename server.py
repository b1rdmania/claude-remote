#!/usr/bin/env python3
"""
Remote Enter Key Server
Run this on your Mac, then use the web app to press Enter from your phone.
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import os

app = Flask(__name__)
CORS(app)  # Allow requests from your phone

def press_enter():
    """Simulate Enter key press on macOS using AppleScript"""
    script = 'tell application "System Events" to keystroke return'
    subprocess.run(['osascript', '-e', script])

@app.route('/enter', methods=['POST'])
def enter_endpoint():
    press_enter()
    return jsonify({'status': 'ok', 'key': 'enter'})

@app.route('/health', methods=['GET'])
def health():
    return jsonify({'status': 'running'})

if __name__ == '__main__':
    # Get local IP for easy reference
    import socket
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)
    
    print(f"""
╔══════════════════════════════════════════════════════════╗
║  Claude Remote Server                                    ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║  Server running on: http://{local_ip}:5050              
║                                                          ║
║  On your phone:                                          ║
║  1. Visit https://b1rdmania.github.io/claude-remote     
║  2. Tap Setup and enter: {local_ip}:5050                
║  3. Add to Home Screen                                   ║
║                                                          ║
║  Press Ctrl+C to stop                                    ║
╚══════════════════════════════════════════════════════════╝
    """)
    
    app.run(host='0.0.0.0', port=5050, debug=False)
