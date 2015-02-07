#!/bin/sh

MESSAGE_='{"message":{"message":"'${1}'","chatBotID":6,"timestamp":2352857013},"user":{"firstName":"Lord","lastName":"God","gender":"m","externalID":"abc-639184572"}}'

HASH_=`echo -n "$MESSAGE_" | openssl dgst -sha256 -hmac "rY37GEGm5r78NM10xakJejflMxCRQXHr" | cut -c 10-`

URL_="http://www.personalityforge.com/api/chat/?apiKey=PF6xdbvmW64zurje&hash=$HASH_&message=$MESSAGE_"

OUTPUT_=`wget -q -U Mozilla -O - "$URL_"`

OUTPUT_=`echo "$OUTPUT_" | egrep -o ',"message":".*","' | cut -c 13-`

FINAL_=`expr "${#OUTPUT_}" - 3`

OUTPUT_=`echo "$OUTPUT_" | cut -c 1-"$FINAL_"`
OUTPUT_=`echo "$OUTPUT_" | perl -pe 's/<.*?>//g'`

echo "$OUTPUT_" 

