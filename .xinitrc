if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi
exec xmonad
