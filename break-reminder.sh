#!/usr/bin/env bash

SOUND="/usr/share/sounds/freedesktop/stereo/complete.oga"

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
  --urgency=normal \
  --app-name="Break Reminder" \
  --icon=dialog-information \
  "Break Reminder" \
  "$MESSAGE"

paplay "$SOUND" &
