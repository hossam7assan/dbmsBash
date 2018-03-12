#!/bin/bash
echo "Update table"
set -v
db=$1
    while [[ true ]]; do 
        read -p ">" ReplyTable
    			set -- "$ReplyTable" 
                IFS=" "; declare -a altTable=($*)
        if [ ${altTable[0]} == "update" ] 
           then
                if [ -f "$db/${altTable[1]}.csv" ]
                	then
                     echo "Table is exist"
		     no=$(awk 'BEGIN{FS=","}{if($1=="'${altTable[2]}'"){print NR-1}}' "$db/${altTable[1]}_config.csv")
		     last=$(awk 'BEGIN{FS=","}END{print NR; }' "$db/${altTable[1]}_config.csv")
				if [[ $no == $last ]]
				then
				end="\$"
				fi
			if [[ ${altTable[4]} ]] 
			then 
				conditionNo=$(awk 'BEGIN{FS=","}{if($1=="'${altTable[4]}'"){print NR-1}}' "$db/${altTable[1]}_config.csv")
				RowNo=$(awk 'BEGIN{FS=","}{if($('$conditionNo')=="'${altTable[5]}'"){print NR}}' "$db/${altTable[1]}.csv")
				sed -i -e "$RowNo s/[^,]*$end/${altTable[3]}/$no" "$db/${altTable[1]}.csv"
			else
				sed -i -e "2,\$ s/[^,]*$end/${altTable[3]}/$no" "$db/${altTable[1]}.csv"

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
