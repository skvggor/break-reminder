# break-reminder

Periodic desktop notifications with sound via systemd user timer.

Edit `break-reminder.sh` to customize messages and `break-reminder.timer` to change the interval (`OnBootSec` / `OnUnitActiveSec`).

## Install

```bash
./install.sh
```

## Uninstall

```bash
./uninstall.sh
```

## Commands

```bash
# Check timer status
systemctl --user status break-reminder.timer

# See next trigger time
systemctl --user list-timers break-reminder.timer

# Test notification manually
./break-reminder.sh

# Stop temporarily
systemctl --user stop break-reminder.timer

# Restart
systemctl --user start break-reminder.timer
```

## License

[GNU GPLv3](LICENSE)
