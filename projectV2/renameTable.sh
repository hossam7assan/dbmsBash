#!/bin/bash

echo "Alter table"

db=$1
    while [[ true ]]; do 
        read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a altTable=($*)
        if [ ${altTable[0]} == "alter" ]
           then
                if [ -f "$db/${altTable[1]}.csv" ]
                	then
                     echo "Table is exist"
                     mv "$db/${altTable[1]}.csv" "$db/${altTable[2]}.csv"
                     mv "$db/${altTable[1]}"_config".csv" "$db/${altTable[2]}"_config".csv"
                     if [ -f "$db/${altTable[1]}.csv" ]  
                	    then 
                		    echo "Can Not Rename Table"
                	 else
                		  echo "Success Renaming Table "
                	 fi

                else
                    echo "Table is not exist"
                fi

        else
            echo "Error: Command Not Found" 
        fi
break
    done
sleep 2
bash project.sh
