
# Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# set profile
export LANG=ja_JP.utf8
export LC_ALL=ja_JP.utf8

# Set clock
# -s 結果は /var/log/messagesへ出力。
sudo ntpdate -s ntp1.jst.mfeed.ad.jp ntp2.jst.mfeed.ad.jp ntp3.jst.mfeed.ad.jp
# マザーボードの時間を UNIX TIMEに合わせる。
/sbin/hwclock --systohc

# ibus
export GTK_IM_MODULE=ibus
export XMODIFIRES=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon --xim -d

# Screen Saver
xset s on
xset s blank
xset s 600

# Set the cursor
xsetroot -cursor_name left_ptr

# Rotate display
xrandr --output VGA-0 --rate 75 --rotate right
xrandr --output DVI-I-1 --rate 75 --rotate left --left-of VGA-0

# Wallpaper
nitrogen --restore

# Xcompmgr & rxvt
xcompmgr -c &
urxvt &

# gitit
# gitit -f ~/wiki/gitit.conf >> /var/log/local/gitit.log &

# local settings
[[ -f ~/.private/private.xinitrc ]] && source ~/.private/private.xinitrc

# Start xmonad
#exec ck-launch-session xmonad
exec xmonad

