# Autostart scripts
~/.fehbg &
# gifplay ~/wallpapers/2825704.gif

# Add this near the top of ~/.xinitrc
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources


# $HOME/.local/bin/scripts/random-wallpaper.sh &
# $HOME/suckless/bar/dwm_bar.sh &
$HOME/suckless/bar/bar.sh &
$HOME/.local/bin/scripts/usb.sh &
$HOME/.local/bin/scripts/jack.sh &
$HOME/.local/bin/scripts/wifi.sh &
$HOME/.local/bin/scripts/media.sh &
$HOME/.local/bin/scripts/battery-alert.sh &
$HOME/.local/bin/scripts/battery-charging.sh &
# $HOME/.local/bin/scripts/suspend.sh &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &


# Autostart programs
dunst &
picom &
xautolock -time 5 -locker "slock" -detectsleep &

# Start dwm
exec dwm
