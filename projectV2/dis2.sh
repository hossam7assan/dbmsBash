#!/bin/bash

echo "In Display Table Structure:"
read -p ">" replyuseDB
echo $replyuseDB

set -- "$replyuseDB" 
IFS=" "; declare -a useDB=($*) 

if [ ${useDB[0]} == "use" ]
	then 
		echo  "${useDB[1]}"
		if [ -d "${useDB[1]}" ] 
			then
    			echo "DataBase is exist."
    			read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a disTable=($*)
                  
                if [ ${disTable[0]} == "display" ]
                then
                	echo "${disTable[1]}.csv"
                 
                   if [ -f "${useDB[1]}/${disTable[1]}.csv" ]
        			then
                		echo "Table is exist"
                		

                		awk -F"," '{print "+-----------|-----------|-----------|-----------|-----------|----------+\n|  " $1 "     |   " $2 "    |    " $3 "   |  " $4 "     |  " $5 "     |  " $6 "    |"}' "${useDB[1]}/${disTable[1]}_config.csv"
                		                       
                		
                    else
                    	echo "Table is not exist"
                   fi

                else
                    echo ">Error: command  not found."
                fi
    			
		else
    			echo "Error: This DataBase Not exist."
		fi
    else
		echo ">Error: command  not found."
fi