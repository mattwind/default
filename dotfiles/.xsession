while true; do
   xsetroot -name "$(date)"
   sleep 1
done &

#dwmstatus &
feh --bg-scale ~/Pictures/wallpaper.png &
nm-applet &
mate-power-manager &
mate-volume-control-applet &
xscreensaver -no-splash &
dwm
