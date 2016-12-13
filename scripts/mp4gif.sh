#avconv -i $1 -vf format=rgb8,format=rgb24 -r 3  output.gif

palette="/tmp/palette.png"
filters="fps=15,scale=420:-1:flags=lanczos"

ffmpeg -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y output.gif

