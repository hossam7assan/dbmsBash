#!/bin/bash

 
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

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
                retDtype="varchar("$charlen")"
                break;;
         *)
    #do_nothing()
          echo "other input"
        
        esac
    done
      
}

choosePk()
{
   clear
   while [[ true ]]; do
        read -p "Is Primary Key(y/n)" PK
   case "$PK" in
        "y")
            #yes
            retPK=1
            break;;
        "n")
            #no
            retPK=0
            break;;
         *)
           #do_nothing()
          echo "other input"
        esac
    done
}

checkUnique()
{
      
        while [[ true ]]; do
          clear
            read -p "Is Unique (y/n)" Uniq
            case "$PK" in

              "y")
                 #yes
                 retUinq=1
                 break;;

              "n")
                 #no
                 retUinq=0
                 break;;

              *)
                 #do_nothing()
                 echo "other input"
            esac
    done
}

chooseDefault()
{
    while [[ true ]]; do
          clear
            read -p "Has Default Value (y/n)" default
            case "$default" in

              "y")
                 #yes
                 read -p "What is Your defualt value" retDefault
                 break;;

              "n")
                 #no
                 retDefault="Null"
                 break;;

              *)
                 #do_nothing()
                 echo "other input"
            esac
    done
}
    

checkNull()
{

  clear
  while [[ true ]]; do
     clear
            read -p "Is Null (y/n)" NValue
            case "$NValue" in

              "y")
                 #yes
                 retNValue=1
                 break;;

              "n")
                 #no
                 retNValue=0
                 break;;

              *)
                 #do_nothing()
                 echo "other input"
            esac
    done
}

echo "Create DataBase"
read -p "Enter Your DataBase Name" db
mkdir $db
read -p "Enter Table Name: " table
echo > $db/$table.csv
echo > $db/$table"_config".csv

sed -i 1i"Col,DT,Pk,unique,Def,Null" $db/$table"_config".csv

read -p "Enter Number Of columns: " col
    
    counterConf=1
    counter2=2
    counter=1
    while [ $counter -le $col ]

        do
            read -p "Enter Name of the $counter column: " colName
            arr[$counter]=$colName
	    config[$counterConf]=$colName
            ((counterConf++))
            
#data type
	     
        retDtype
        chooseDateType
        config[$counterConf]=$retDtype
	    ((counterConf++))

#primary key

         retPK
         choosePk
	     config[$counterConf]=$retPK
         ((counterConf++))

#unique

        if [ $retPK == 1 ]
            then
                config[$counterConf]=1
            else
                retUinq
                checkUnique
                config[$counterConf]=$retUinq
        fi
	       ((counterConf++))

#Default

             retDefault
             chooseDefault
             config[$counterConf]=$retDefault
            ((counterConf++))
#null
        if [ $retPK == 1 ]
            then
                config[$counterConf]=0
            else
                retNValue
                checkNull
                config[$counterConf]=$retNValue
        fi
	        ((counterConf++))

 config1=$( echo ${config[@]} | sed 's/ /,/g' )
 sed -i ${counter2}i"${config1[@]}" $db/$table"_config".csv
 config=()

            ((counter2++))
            ((counter++))
 done
            
echo ${arr[@]} 
arr1=$( echo ${arr[@]} | sed 's/ /,/g' )
echo ${arr1[@]}

sed -i 1i"${arr1[@]}" $db/$table.csv
