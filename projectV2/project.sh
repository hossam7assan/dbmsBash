#!/bin/bash

DrawMainMenu()
{
  echo "1-Create New DataBase."
  echo "2-Show DataBases."
  echo "3-Drop DataBase."
  echo "4-Manipulate In DataBase."
  echo "5-Exit."
}

DrawShowMenu()
{
  echo "1-Add Table."
  echo "2-Display Table Structure."
  echo "3-Alter Table."
  echo "4-Sort Table."
  echo "5-Drop Table."
  echo "6-To Return To Main Menu"
}

ManipulateMenu()
{
  echo "1-Insert Into Table."
  echo "2-Select Table."
  echo "3-Update Table."
  echo "4-Delete From Table."
  echo "5-To Return To Main Menu"
}
echo "Our DBMS"

          clear
          DrawMainMenu
          read -p "choose Your Option from Menu" chOption
 while [[ true ]]; do
          
            case "$chOption" in

              "1")
                 #add new table
                 echo "In creation."
                 echo "Create DataBase"
                 flagdb=1

                  while [[ $flagdb == 1 ]]; do
                      read -p ">" replycrDB
                      echo $replycrDB

                      set -- "$replycrDB" 
                      IFS=" "; declare -a createDB=($*) 
                      if [[ ${#createDB[@]} == 3 && ${createDB[0]} == "create" && ${createDB[1]} == "database" ]]
                          then
    
                          #check if this db is already exist or no

                          if [ -d "${createDB[2]}" ] 
                              then
                                  echo "This DataBase Is Already Exist."
          
                          else
                              echo "ok we can create it."
                              mkdir ${createDB[2]}
                              bash Create.sh ${createDB[2]}

                          fi
                      else
                          echo "Error:Command Not Found."
                      fi

                  done
                 
                 break;;

              "2")
                 #show DataBases
                 clear
                 echo "In Show Databases."

                 for d in */; do
                    echo $d | sed 's/\///g'
                 done
                 flagSMM=1
                  while [[ $flagSMM == 1 ]]; do

                    read -p ">" replyuseDB
                    echo $replyuseDB
                    set -- "$replyuseDB" 
                    IFS=" "; declare -a useDB=($*) 
                    if [[ ${#useDB[@]} == 2 && ${useDB[0]} == "use" ]]
                    then
                        echo "Correct Command"
                        if [ -d "${useDB[1]}" ]
                          then
                          echo "This DB is exist."
                              DrawShowMenu
                              while [[ true ]]; do
                              read -p "Select Your Option" showOp
                              case "$showOp" in
                                  "1")
                                      #add table in this database
                                      bash Create.sh ${useDB[1]}
                                      echo "in our file 1"
                                      break;;
                                  "2")
                                       #display table structure
                                       bash Display.sh ${useDB[1]}
                                       sleep 2
                                       bash project.sh
                                       break;;
                                  "3")
                                      #alter table 
                                        echo '1)add new col'
					echo '2)change col datatype'
 					echo '3)delete col'
					echo '4)change table name'
					echo '5)Exit'
						while [[ true ]]; do
                              			read -p "Select Your Option" opt
                              			case "$opt" in
                                  		"1")
							bash AddNewCol.sh ${useDB[1]}
                                      		 ;;
                                  		"2")
							bash EditCol.sh ${useDB[1]}
                                      		 ;;
                                  		"3")
							bash deleteCol.sh ${useDB[1]}
                                      		 ;;
                                  		"4")
							bash renameTable.sh ${useDB[1]}
                                      		 ;;
                                  		"5")
                                      		 break;;
						esac
						done
                                      break;;
                                  "4")
                                      #sort table
                                      bash sort.sh ${useDB[1]}
                                      break;;
                                  "5")
                                      #drop table
                                      echo "in drop table"
                                      bash Drop.sh ${useDB[1]}
                                      echo "in our file 5"
                                      sleep 2
                                      bash project.sh
                                      break;;

                                  "6")
                                      bash project.sh
                                      break;;

                                  *)
                                       #do_nothing()
                                       echo "other input"
        
                              esac
                              done
    
                              
                        else
                            echo "This DB isn't exist."
                        fi  
                  else
                      echo "False Command"
                  fi
                  done



       
                 break;;

              "3")
                 #Drop DataBase
                 echo "Drop Database."
                 bash DropDb.sh
                 echo "after drop"
                 sleep 2
                 bash project.sh
                 break;;
              "4")
                  clear
                  flagMMenu=1
                  ManipulateMenu
                  read -p "Select Your Option To Manipulate into database" optMin
                while [[ $flagMMenu == 1 ]]; do
                  case "$optMin" in
                                  "1")
                                      #insert in table.
                                      echo "insert into table"
                                      bash insert
                                      echo "in back insert"
                                      sleep 2
                                      bash project.sh
                                      break;;
                                  "2")
                                       #select from table.
                                       echo "Select from Table"
                                       bash search
                                       echo "in back search"
                                       sleep 2
                                       bash project.sh
                                       break;;
                                  "3")
                                      #update table
                                      echo "update table"
                                      bash updateRow.sh
                                      #echo "in back update"
                                      #sleep 2
                                      #bash project.sh
                                      break;;
                                  "4")
                                      #delete from table
                                      echo "Delete from table"
                                      bash delete
                                      echo "in back delete"
                                      sleep 2
                                      bash project.sh
                                      break;;

                                  "5")
                                      #to return to main menu
                                      echo "Return To main Menu"
                                      break;;
                                  *)
                                    #There is no option 
                                    echo "Out Of Boundry"
                                    ManipulateMenu
                                    read -p "Select Your Option To Manipulate into database" optMin


                  esac
                done

                  break;;

              "5")
				  #exit the program
				  echo "In exit Databases."
				  killall -9 bash
                  break;;
               *)
				 #out of sequence
				 echo "out of sequence."
         DrawMainMenu
         read -p "choose Your Option from Menu" chOption
				
                    
            esac
    done

