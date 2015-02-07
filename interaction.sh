#!/bin/sh

LANG_="en_US"
speak(){
	./speak.sh "$1" `echo "$LANG_" | cut -c 1,2`
}
listen(){
	echo `./listen.sh "$LANG_"`
}

./speak.sh "Welcome my lord" "en"

while :
do
	read INPUT_
	if [ ${#INPUT_} -gt 0 ]; then
		SPEECH_="$INPUT_"
	else
		SPEECH_=`listen`
	fi
	echo `date '+%Y/%m/%d - %H:%M:%S'` >> chatbotData.txt
	echo "You said: $SPEECH_" >> chatbotData.txt
	ANSWER_=`./chatbot.sh "$SPEECH_"`
	echo "Computer answered: $ANSWER_" >> chatbotData.txt
	echo "" >> chatbotData.txt
	speak "$ANSWER_"
	clear
	echo "`cat chatbotData.txt`"
done
