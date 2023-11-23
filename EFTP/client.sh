#!/bin/bash

echo "EFTP 1.0" | nc localhost 3333 

echo "(1) Send"

echo "EFTP 1.0" | nc localhost 3333	

echo "(2) Listen"

DATA=`nc -l -p 3333 -w 0`


if [ "$DATA" != "OK_HEADER" ]
then
echo "ERROR 1: BAD HEADER"
exit 1
fi

echo "BOOOOM"
sleep 1
echo "BOOOOM" | nc localhost 3333

echo "(6) Listen"

DATA=`nc -l -p 3333 -w 0`
echo $DATA

echo "(9) test"

if [ "$DATA" != "OK_HANDSHAKE" ]
then
	echo "ERROR 2: BAD HANDSHAKE"
	exit 2
fi

echo "(10) Send"

echo "FILE_NAME fary1.txt" | nc localhost 3333

echo "(11) Listen"

