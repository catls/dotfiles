# User-defined zlogin file for zsh login shells
#
weather_area=osaki
weather_data=/tmp/weather/`date +"%m%d"`
[ ! -d /tmp/weather ] && mkdir /tmp/weather
if [ ! -f $weather_data ];then
    curl wttr.in/$weather_area 2> /dev/null | sed -n '8,17p' > $weather_data
fi
cat $weather_data
unset weather_area
unset weather_data

pwd && uptime
