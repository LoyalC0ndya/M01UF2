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
