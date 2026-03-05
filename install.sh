#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

mkdir -p "$SYSTEMD_USER_DIR"

ln -sf "$SCRIPT_DIR/break-reminder.service" "$SYSTEMD_USER_DIR/break-reminder.service"
ln -sf "$SCRIPT_DIR/break-reminder.timer" "$SYSTEMD_USER_DIR/break-reminder.timer"

systemctl --user daemon-reload
systemctl --user enable --now break-reminder.timer

echo "break-reminder installed and running!"
echo "Next trigger:"
systemctl --user list-timers break-reminder.timer --no-pager
