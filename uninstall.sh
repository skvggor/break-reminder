#!/usr/bin/env bash

set -euo pipefail

systemctl --user disable --now break-reminder.timer 2>/dev/null || true
rm -f "$HOME/.config/systemd/user/break-reminder.service"
rm -f "$HOME/.config/systemd/user/break-reminder.timer"
systemctl --user daemon-reload

echo "break-reminder uninstalled."
