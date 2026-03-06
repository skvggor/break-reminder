#!/usr/bin/env bash

DEBUG=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --debug)
      DEBUG=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

export DISPLAY="${DISPLAY:-:0}"
export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}"

MESSAGES=(
  "Hora de levantar! Dá uma volta, estica as pernas."
  "Pausa! Levanta e caminha um pouco."
  "Seu corpo agradece: levanta e dá uma andada."
  "Break time! Vai dar uma volta rápida."
  "30 minutos sentado já chega. Bora levantar!"
)

MESSAGE="${MESSAGES[$((RANDOM % ${#MESSAGES[@]}))]}"

notify-send \
  --urgency=critical \
  --app-name="Break Reminder" \
  --icon=dialog-information \
  --expire-time=0 \
  "⚠️ Break Reminder" \
  "$MESSAGE"

play_sound() {
  local sounds=(
    "/usr/share/sounds/freedesktop/stereo/complete.oga"
    "/usr/share/sounds/freedesktop/stereo/dialog-information.oga"
    "/usr/share/sounds/freedesktop/stereo/message-new-instant.oga"
    "/usr/share/sounds/gnome/default/alerts/glass.ogg"
    "/usr/share/sounds/ubuntu/stereo/bubbles.ogg"
  )

  local sound_file=""
  local player=""

  for sound in "${sounds[@]}"; do
    [[ "$DEBUG" == true ]] && echo "[DEBUG] Trying sound: $sound"
    if [[ -f "$sound" ]]; then
      sound_file="$sound"
      [[ "$DEBUG" == true ]] && echo "[DEBUG] Found: $sound"
      if command -v paplay &>/dev/null; then
        player="paplay"
        [[ "$DEBUG" == true ]] && echo "[DEBUG] Using: paplay"
        break
      elif command -v ffplay &>/dev/null; then
        player="ffplay"
        [[ "$DEBUG" == true ]] && echo "[DEBUG] Using: ffplay"
        break
      elif command -v canberra-gtk-play &>/dev/null; then
        player="canberra"
        [[ "$DEBUG" == true ]] && echo "[DEBUG] Using: canberra-gtk-play"
        break
      fi
    else
      [[ "$DEBUG" == true ]] && echo "[DEBUG] Not found"
    fi
  done

  if [[ -z "$player" ]] && command -v speaker-test &>/dev/null; then
    player="speaker-test"
    sound_file=""
    [[ "$DEBUG" == true ]] && echo "[DEBUG] Using: speaker-test (fallback)"
  fi

  if [[ -z "$player" ]]; then
    [[ "$DEBUG" == true ]] && echo "[DEBUG] No sound player available!"
    return
  fi

  for i in 1 2 3; do
    case "$player" in
      paplay)
        paplay "$sound_file" 2>/dev/null &
        ;;
      ffplay)
        ffplay -autoexit -nodisp "$sound_file" 2>/dev/null &
        ;;
      canberra)
        canberra-gtk-play -i 14 -d "message" 2>/dev/null &
        ;;
      speaker-test)
        speaker-test -t sine -f 440 -l 1 2>/dev/null &
        ;;
    esac
    [[ $i -lt 3 ]] && sleep 3
  done
}

play_sound
