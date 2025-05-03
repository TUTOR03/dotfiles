#!/usr/bin/env bash

options="Poweroff\nReboot\nSuspend"
choice=$(echo -e "$options" | rofi -dmenu)
case "$choice" in
  Poweroff) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Suspend) systemctl suspend ;;
esac