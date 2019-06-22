#!/bin/sh

if [ "$#" -eq 1 ]; then
    echo "Illegal number of parameters: blur strength is required"
fi

strength="$@"

if [ -z "$SED" ]; then
  SED="sed"
  command -v gsed > /dev/null && SED="gsed"
fi

# === Get connection parameters ===

dpy=$(echo -n "$DISPLAY" | tr -c '[:alnum:]' _)

if [ -z "$dpy" ]; then
  echo "Cannot find display."
  exit 1
fi

service="com.github.chjj.compton.${dpy}"
interface='com.github.chjj.compton'
object='/com/github/chjj/compton'
type_win='uint32'
type_enum='uint16'

# === DBus methods ===

# List all window ID compton manages (except destroyed ones)
dbus-send --print-reply --dest="$service" "$object" "${interface}.list_win"

# Ensure we are tracking focus
dbus-send --print-reply --dest="$service" "$object" "${interface}.opts_set" string:track_focus boolean:true

# Get window ID of currently focused window
focused=$(dbus-send --print-reply --dest="$service" "$object" "${interface}.find_win" string:focused | $SED -n 's/^[[:space:]]*'${type_win}'[[:space:]]*\([[:digit:]]*\).*/\1/p')

if [ -n "$focused" ]; then
  if [[ "${strength:0:1}" =~ [+-] ]]; then
    # Increment the window to have selected strength
    dbus-send --print-reply --dest="$service" "$object" "${interface}.win_set" "${type_win}:${focused}" string:inc_blur_strength "${type_enum}:$strength"
  else
    # Set the window to have selected strength
    dbus-send --print-reply --dest="$service" "$object" "${interface}.win_set" "${type_win}:${focused}" string:set_blur_strength "${type_enum}:$strength"
  fi
else
  echo "Cannot find focused window."
fi
