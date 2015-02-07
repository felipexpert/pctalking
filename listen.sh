#!/bin/sh
trap "" 2
LAST_WAV_=`ls mylogs/ | egrep ".wav" | sort | tail -n 1 | cut -d '.' -f 1`
LAST_FLAC_=""
if [ "$LAST_WAV_" == "" ]; then
	LAST_WAV_="speech/1.wav"
	LAST_FLAC_="speech/1.flac"
else
	LAST_WAV_=`expr $LAST_WAV_ + 1`
	LAST_FLAC_="speech/"${LAST_WAV_}".flac"
	LAST_WAV_="speech/"${LAST_WAV_}".wav"
fi

rec -r 16000 -b 16 -c 1 "$LAST_WAV_"

sox "$LAST_WAV_" -r 16000 -b 16 -c 1 "$LAST_FLAC_" vad reverse vad reverse lowpass -2 2500

LANG_="pt_BR"

if [ "$#" -ge 1 ]; then
	LANG_="$1"
fi
OUTPUT_=`curl --data-binary @$LAST_FLAC_ --header 'Content-type: audio/x-flac; rate=16000' "https://www.google.com/speech-api/v2/recognize?output=json&lang="${LANG_}"&key=AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw&client=chromium&maxresults=1&pfilter=2"`
OUTPUT_=`echo "$OUTPUT_" | cut -c 43- | cut -d '"' -f 1`
rm "$LAST_WAV_" "$LAST_FLAC_"
echo "$OUTPUT_"
#trap 2
