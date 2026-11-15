#!/bin/bash
# Installs (or reinstalls) Courtside into Applications and opens it.
# Usage: curl -fsSL https://raw.githubusercontent.com/sunny9781/courtside-releases/main/install.sh | bash
set -e
if [ "$(uname -m)" != "arm64" ]; then
  echo "Courtside needs a Mac with Apple Silicon (M1 or newer)."; exit 1
fi
TMP=$(mktemp -d)
echo "Downloading Courtside…"
curl -fsSL "https://github.com/sunny9781/courtside-releases/releases/latest/download/Courtside.zip" -o "$TMP/Courtside.zip"
ditto -x -k "$TMP/Courtside.zip" "$TMP"
osascript -e 'quit app "Courtside"' 2>/dev/null || true
rm -rf /Applications/Courtside.app
ditto "$TMP/Courtside.app" /Applications/Courtside.app
xattr -dr com.apple.quarantine /Applications/Courtside.app 2>/dev/null || true
rm -rf "$TMP"
echo "Installed. Opening Courtside…"
open /Applications/Courtside.app
