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
            retPK="PRI"
            break;;
        "n")
            #no
            retPK="no"
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
                 retUinq="yes"
                 break;;

              "n")
                 #no
                 retUinq="no"
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
                 retDefault="no"
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
                 retNValue="yes"
                 break;;

              "n")
                 #no
                 retNValue="no"
                 break;;

              *)
                 #do_nothing()
                 echo "other input"
            esac
    done
}

      echo "in create table file."
      db=$1

      while [[ true ]]; do
          echo "still here thank god."
          read -p ">" replycrTB
          echo $replycrTB

          set -- "$replycrTB" 
          IFS=" "; declare -a createTB=($*)

          echo "create table."

          if [[ ${#createTB[@]} == 4 && ${createTB[0]} == "create" && ${createTB[1]} == "table" && ${createTB[3]}  =~ ^-?[0-9]+$ ]]
            then

                echo "Okkkkkkkkkkkkk"
                if [ -f "${createTB[2]}" ]
                    then 
                        echo "table name is alreay exist"
                    else
                        echo "okkkkkkkkkkkkkkkkkk"
                        echo > $db/${createTB[2]}.csv
                        echo > $db/${createTB[2]}"_config".csv
                        sed -i 1i"Col,DT,Pk,unique,Def,Null" $db/${createTB[2]}"_config".csv

                        counterConf=1
                        counter2=2
                        counter=1
                        while [ $counter -le ${createTB[3]} ]

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
                                    if [ $retPK == "PRI" ]
                                        then
                                            config[$counterConf]="yes"
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
                                    if [ $retPK == "PRI" ]
                                        then
                                            config[$counterConf]="no"
                                        else
                                            retNValue
                                            checkNull
                                            config[$counterConf]=$retNValue
                                        fi

                                        ((counterConf++))

                            config1=$( echo ${config[@]} | sed 's/ /,/g' )
                            echo ${config1[@]}
                            sed -i ${counter2}i"${config1[@]}" $db/${createTB[2]}"_config".csv
                            config=()

                                    ((counter2++))
                                    ((counter++))
                        done
            
                  echo ${arr[@]} 
                  arr1=$( echo ${arr[@]} | sed 's/ /,/g' )
                  echo ${arr1[@]}

                  sed -i 1i"${arr1[@]}" $db/${createTB[2]}.csv
                  bash project.sh

                fi
            
            else 
                echo "Nooooooooooooo"
            fi
            
      done


          
    






