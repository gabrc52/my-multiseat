#!/bin/bash

source ~/bin/ms.conf
echo
echo res = $res
echo kbd = $kbd
echo mouse = $mouse
echo

if [ -z "$@" ]; then
    echo "Running on :3. To override this run 'ms :DISPLAY'"
    export display=:3
else
    echo Running on $1
    export display=$1
fi

kdesu -c "Xephyr -softCursor \
-dpi 96 \
-screen $res \
-keybd evdev,,device=/dev/input/by-id/$kbd,xkbrules=evdev,xkbmodel=pc105,xkblayout=latam \
-mouse evdev,,device=/dev/input/by-id/$mouse \
-name "multiseat-xephyr" $display" &

until xterm -display $display -geom 0x0 -bd black -bg black -cr black -fg black -ms black -selbg black -selfg black -e "exit 0"; do 
#or just use xhost?
    sleep 1
done

. $HOME/bin/sdesktop $display

# Previous kbd options: -keybd evdev,,device=/dev/input/by-id/$kbd,xkbrules=xorg,xkbmodel=evdev,xkblayout=latam
# They don't really matter anyways as they will be overriden by sdesktop

#qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend
