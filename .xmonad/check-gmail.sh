#/usr/bin/bash

# GMAIL_ACCOUNT=*****
# GMAIL_PASSWORD=*****
source ~/.private/private.gmail

MAIL=`curl -u ${GMAIL_ACCOUNT}:${GMAIL_PASSWORD} --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n'`
RESULT=`echo ${MAIL} | perl -pe 's/.*<fullcount>(\d+)<\/fullcount>.*$/$1/'`

if [ "$RESULT" -eq 0 ];then
	echo "Mail:<fc=#99CCCC>${RESULT}</fc>"
else
	CONTENT=`echo ${MAIL} | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | perl -pe 's/^<title>(.*)<\/title>.*?<name>(.*?)<\/name>.*$/$2 - $1/'`
	echo "Mail:<fc=#FF4040>${RESULT}</fc>    ${CONTENT}"
fi
