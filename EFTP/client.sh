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

sleep 1
echo "FILE_NAME fary1.txt" | nc localhost 3333

echo "(11) Listen"
DATA=`nc -l -p 3333 -w 0`


echo "(14) Test & Send"
if [ "$DATA" != "OK_FILE_NAME" ]
then 
	echo "ERROR 3: BAD FILE_NAME"
	exit3
fi

sleep 1
cat imgs/fary1.txt | nc localhost 3333

echo "(15) Listen" 
DATA?`nc -l -p 3333 -w 0`

if [ "$DATA" != "OK_DATA" ]
then
	echo "ERROR 4: BAD DATA"
	exit 4
fi

echo "FIN"
exit 0
