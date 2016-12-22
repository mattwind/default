while true; do
   xsetroot -name "$( date +"%a %b %d %Y %r" )"
   sleep 1
done &

xrandr --output HDMI2 --off --output HDMI1 --off --output DP1 --off --output eDP1 --off --output DP2 --mode 1920x1080 --pos 0x0 --rotate normal
solaar &
xcompmgr &
guake &
insync start &
mate-volume-control-applet &
mate-power-manager &
nm-applet &
xscreensaver -no-splash &
feh --bg-scale ~/Pictures/wallpaper.png &
dwm
