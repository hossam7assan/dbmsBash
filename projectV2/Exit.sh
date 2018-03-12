#!/bin/bash

flag=1

while [[ $flag == 1 ]]; do

read -p ">" replyExit
set -- "$replyExit"

IFS=" "; declare -a exitCmd=($*)
if [ ${exitCmd[0]} == "exit" ]
	then
	    echo "command exist"
	    flag=0
	else
		echo "command not found"

    fi

done
