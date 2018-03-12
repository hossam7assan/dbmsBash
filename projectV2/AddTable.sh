echo "create table."
    read -p ">" replycrTB
    echo $replycrTB

    set -- "$replycrTB" 
    IFS=" "; declare -a createTB=($*)

    if [[ ${#createTB[@]} == 4 && ${createTB[0]} == "create" && ${createTB[1]} == "table" && ${createTB[3]}  =~ ^-?[0-9]+$ ]]
       then

           echo "Okkkkkkkkkkkkk"
           if [ -f "${createTB[2]}" ]
                then 
                    echo "table name is alreay exist"
                    else
                        echo "okkkkkkkkkkkkkkkkkk"
                        echo > ${createDB[2]}/${createTB[2]}.csv
                        echo > ${createDB[2]}/${createTB[2]}"_config".csv
                        sed -i 1i"Col,DT,Pk,unique,Def,Null" ${createDB[2]}/${createTB[2]}"_config".csv

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
                            sed -i ${counter2}i"${config1[@]}" ${createDB[2]}/${createTB[2]}"_config".csv
                            config=()

                                    ((counter2++))
                                    ((counter++))
                        done
            
                  echo ${arr[@]} 
                  arr1=$( echo ${arr[@]} | sed 's/ /,/g' )
                  echo ${arr1[@]}

                  sed -i 1i"${arr1[@]}" ${createDB[2]}/${createTB[2]}.csv

                fi
            
    else 
        echo "Nooooooooooooo"
    fi
