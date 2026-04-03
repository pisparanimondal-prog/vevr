#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# OTP Bot — Ubuntu Setup Script
# Tested on Ubuntu 20.04 / 22.04 / 24.04 (64-bit)
# Run as root or with sudo:  sudo bash install_ubuntu.sh
# ─────────────────────────────────────────────────────────────────────────────
set -e

echo "======================================================"
echo "  OTP Bot — Ubuntu Installer"
echo "======================================================"

# ── 1. System packages ────────────────────────────────────────────────────────
echo ""
echo "[1/4] Installing system packages..."
apt-get update -qq
apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    chromium-browser \
    chromium-chromedriver \
    xvfb \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    wget \
    unzip \
    curl

# ── 2. Symlinks so selenium can find chromium ────────────────────────────────
echo ""
echo "[2/4] Setting up chromium symlinks..."
# Some Ubuntu versions use chromium-browser; others use chromium
if command -v chromium-browser &>/dev/null && ! command -v chromium &>/dev/null; then
    ln -sf "$(which chromium-browser)" /usr/local/bin/chromium
fi
if command -v chromium-chromedriver &>/dev/null && ! command -v chromedriver &>/dev/null; then
    ln -sf "$(which chromium-chromedriver)" /usr/local/bin/chromedriver
fi
echo "  chromium  → $(which chromium 2>/dev/null || echo 'not found')"
echo "  chromedriver → $(which chromedriver 2>/dev/null || echo 'not found')"

# ── 3. Python dependencies ────────────────────────────────────────────────────
echo ""
echo "[3/4] Installing Python packages..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pip3 install --break-system-packages -r "$SCRIPT_DIR/requirements.txt" 2>/dev/null \
    || pip3 install -r "$SCRIPT_DIR/requirements.txt"

# ── 4. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "[4/4] Setup complete!"
echo ""
echo "======================================================"
echo "  To start the bot, run:"
echo "    cd $(dirname "$SCRIPT_DIR/.")"
echo "    python3 otp-bot/main.py"
echo ""
echo "  Or use the helper script:"
echo "    bash otp-bot/start.sh"
echo "======================================================"
