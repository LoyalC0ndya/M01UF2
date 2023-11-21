#!/bin/bash

CLIENT="localhost"
PORT="3333"

echo "SERVIDOR EFTP"

echo "(0) Listen"

DATA=`nc -l -p "$PORT" -w 0`

echo $DATA

echo "(3) Test & Send"

if [ "$DATA" != "EFTP 1.0" ]
then
	echo "ERROR 1: BAD HEADER"
	sleep 1
	echo "KO_HEADER" | nc $CLIENT "$PORT"
	exit 1
fi

echo "OK_HEADER"
sleep 1
echo "OK_HEADER" | nc $CLIENT "$PORT"

echo  "(4) Listen"

DATA=`nc -l -p "$PORT" -w 0`

if [ "$DATA" != "BOOM" ]
then
	echo "ERROR 2: BAD HANDSHAKE2"
	
	sleep 1
	echo "KO_HANDSHAKE" | nc $CLIENT "$PORT"
	exit 2
fi

sleep 1
echo "OK_HANDSHAKE" | nc $CLIENT "$PORT"

echo "(8) Listen)"

DATA=`nc -l -p "$PORT" -w 0`
