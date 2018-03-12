#!/bin/bash

flagTB=1
db=$1
while [[ $flagTB == 1 ]]; do 			
read -p ">" ReplyTable
set -- "$ReplyTable" 
IFS=" "; declare -a disTable=($*)

    if [[ ${#disTable[@]} == 2 && ${disTable[0]} == "display" ]]              
        then
            echo "${disTable[1]}.csv"
            echo "$1/${disTable[1]}.csv"
                if [ -f "$db/${disTable[1]}.csv" ]
        			then
                		echo "Table is exist"
                		

                		awk -F"," '{print "+-----------|-----------|-----------|-----------|-----------|----------+\n|  " $1 "     |   " $2 "    |    " $3 "   |  " $4 "     |  " $5 "     |  " $6 "    |"}' "$db/${disTable[1]}_config.csv"
                		flagTB=0                      
                		
                else
                    echo "Table is not exist"
                fi

    else
        echo ">Error: command  not found."
    fi

done 
