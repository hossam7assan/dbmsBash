#!/bin/bash

echo "Delete table"
flagDel=1
db=$1
    while [[ $flagDel == 1 ]]; do 
        read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a disTable=($*)
        if [[ ${#disTable[@]} == 2 && ${disTable[0]} == "delete" ]]
           then
                if [ -f "$db/${disTable[1]}.csv" ]
                	then
                     echo "Table is exist"
                     rm "$db/${disTable[1]}.csv"
                     rm "$db/${disTable[1]}"_config".csv"
                     if [ -f "$db/${disTable[1]}.csv" ]  
                	    then 
                		    echo "Can Not Delete File"
                	 else
                		  echo "Success Delete it"
                          flagDel=0 
                	 fi

                else
                    echo "Table is not exist"
                fi

        else
            echo "Error: Command Not Found" 
        fi
    done