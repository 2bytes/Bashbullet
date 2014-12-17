
#!/bin/bash

LOGGING=true # This will print the message and response to the syslog. 
URL="https://api.pushbullet.com/v2/pushes"

API_KEY="" #token

TITLE="Alert"

MESSAGE="{\"type\": \"note\", \"title\": \"$TITLE\", \"body\": \"$*\"}"

#echo $MESSAGE

if [ ${#API_KEY} == 0 ]
then
	echo "Error: You need to supply an API key"
	exit 1;
fi

if [ ${#MESSAGE} == 0 ]
then
	MESSAGE="{'type': 'note', 'title': '$TITLE', 'body': '$(cat)'}"
fi

RESPONSE=`curl -s -u "$API_KEY:" --header 'Content-Type: application/json' --data-binary "$MESSAGE" -X POST $URL`

#echo $RESPONSE

if [ $LOGGING == true ]
then
	logger "PUSH"
	logger "|"
	logger "| MESSAGE: $MESSAGE"
	logger "| RESPONSE: $RESPONSE"
	logger "|___________________________________________________________________________________________"
fi
