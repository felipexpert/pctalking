#!/bin/sh
# Take a inexistent file
LAST_=`ls mp3 | sort | tail -n 1 | sed -E 's/\.mp3//'`
if [ "$LAST_" == "" ]; then
	LAST_="mp3/1.mp3"
else
	LAST_=`expr $LAST_ + 1`
	LAST_="mp3/${LAST_}.mp3"
fi
TEXT_=""
LANG_="pt"

if [ "$#" -eq 2 ]; then
	TEXT_=$1
	LANG_=$2
elif [ "$#" -eq 1 ]; then
	TEXT_=$1
fi

wget -q -U Mozilla -O "$LAST_" "http://translate.google.com/translate_tts?ie=UTF-8&tl=$LANG_&q=$TEXT_"

mpg123 "$LAST_"

rm "$LAST_"
