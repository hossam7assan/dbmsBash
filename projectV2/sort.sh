#!/bin/bash

echo "Sort table"
db=$1
    while [[ true ]]; do 
        read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a sortTable=($*)
        if [ ${sortTable[0]} == "sort" ]
           then
                if [ -f "$db/${sortTable[1]}.csv" ]
                	then
                     echo "Table is exist"
	no=$(awk 'BEGIN{FS=","}{if($1=="'${sortTable[2]}'"){print NR-1}}' "$db/${sortTable[1]}_config.csv")
	numb=$(awk 'BEGIN{FS=","}{if($1=="'${sortTable[2]}'"){if($2=="int(11)"){print "-n"}}}' "$db/${sortTable[1]}_config.csv")
	if [[ ${sortTable[3]} == 'Asc' ]]
	then 
        sed 1d "$db/${sortTable[1]}.csv" | sort -k$no $numb -t',' 
	fi
	if [[ ${sortTable[3]} == 'Desc' ]]
	 then
         sed 1d "$db/${sortTable[1]}.csv" | sort $nubm -r -k$no -t',' 
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
