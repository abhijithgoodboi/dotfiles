#!/usr/bin/env bash

powermenu ()
{
  options="Cancel\nShutdown\nRestart\nSleep"
  selected=$(echo -e $options | dmenu)
  if [[ $selected = "Shutdown" ]]; then
      poweroff
  elif [[ $selected = "Restart" ]]; then
      reboot
  elif [[ $selected = "Sleep" ]]; then
      systemctl suspend
  elif [[ $selected = "Cancel" ]]; then
      return
  fi
}

powermenu
