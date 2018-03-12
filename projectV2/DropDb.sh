#!/bin/bash

echo "Delete Database"

flagdrop=1
while [[ $flagdrop == 1 ]];do

read -p ">" replydropDB
echo $replydropDB

set -- "$replydropDB" 
IFS=" "; declare -a dropDB=($*) 

if [[ ${#dropDB[@]} == 2 && ${dropDB[0]} == "drop" ]]
    then

        if [ -d "${dropDB[1]}" ] 
            then
                echo "Database exist"
                rm -r ${dropDB[1]}
                flagdrop=0

        else
            echo "Database not exist"
        fi

else
    echo "Error:Command Not Found."
fi
done