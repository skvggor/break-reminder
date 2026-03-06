<p align="center">
  <img src="assets/icon.svg" alt="break-reminder icon" width="120" height="120"/><br/>
  <h1 align="center">break-reminder</h1>
</p>

Periodic desktop notifications with sound via systemd user timer.

Edit `break-reminder.sh` to customize messages and `break-reminder.timer` to change the interval (`OnBootSec` / `OnUnitActiveSec`).

## Features

- Desktop notification with critical urgency (stays visible until dismissed)
- Sound plays 3 times with 3-second interval
- Multiple sound backends: paplay → ffplay → canberra-gtk-play → speaker-test
- Debug mode to troubleshoot sound issues

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

# Test with debug output
./break-reminder.sh --debug

# Stop temporarily
systemctl --user stop break-reminder.timer

# Restart
systemctl --user start break-reminder.timer
```

## License

[GNU GPLv3](LICENSE)
