#!/bin/bash
# OTP Bot — Start Script
# Usage: bash otp-bot/start.sh   (from the parent folder)
#        OR:  bash start.sh       (from inside otp-bot/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
echo "Starting OTP Bot..."
exec python3 main.py
