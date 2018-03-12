#!/bin/bash
echo "Alter table"

db=$1
    while [[ true ]]; 
	do 
        read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a altTable=($*)
        if [ ${altTable[0]} == "alter" ]
           then
                if [ -f "$db/${altTable[1]}.csv" ]
                	then
                     echo "Table is exist"
		     no=$(awk 'BEGIN{FS=","}{if($1=="'${altTable[2]}'"){print NR-1}}' "$db/${altTable[1]}_config.csv")
		     last=$(awk 'BEGIN{FS=","}END{if($1=="'${altTable[2]}'"){print NR-1; }}' "$db/${altTable[1]}_config.csv")
			sed -i "/\b${altTable[2]}\b/d" "$db/${altTable[1]}_config.csv"
	                #cut  -d, -f$no --complement "$db/${altTable[1]}.csv" > "temp.csv"
			#mv "temp.csv" "$db/${altTable[1]}.csv"
	if [[ $no == $last ]]
	then
		end="\$"
	else
		end=","
	fi

			sed -i "s/[^,]*$end//$no" "$db/${altTable[1]}.csv"
				res=$?
				if [[ $res == 0 ]]
				then
					 echo "${altTable[2]} deleted Successfully"
				else 
					"Failed to delete ${altTable[2]} "
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
