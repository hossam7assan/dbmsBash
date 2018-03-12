#!/bin/bashalter new_tbl intale

chooseDateType()
{
     clear
        while [[ true ]]; do
            #statements
            echo "Choose Your Data Type"
        echo "1-Integer" 
        echo "2-VarChar"
        
        read -p "What is Your DataType:" Dtype

       case "$Dtype" in
        "1")
            #integer
            retDtype="int(11)"
            break;;
        "2")
    #character
            read -p "Enter The lentgh of characters" charlen
                retDtype="varchar($charlen)"
                break;;
         *)
    #do_nothing()
          echo "other input"
        
        esac
    done
      
}
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
retDtype
chooseDateTypec
		     no=$(awk 'BEGIN{FS=","}{if($1=="'${altTable[2]}'"){print NR}}' "$db/${altTable[1]}_config.csv")
	dtype=$(awk 'BEGIN{FS=","}{if($1=="'${altTable[2]}'"){print $2}}' "$db/${altTable[1]}_config.csv")
			sed -i "$no s/${dtype}/${retDtype}/g" "$db/${altTable[1]}_config.csv"
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
