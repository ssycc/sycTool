#!/bin/bash

###

function CHECKme(){ # function for check if email is Available or not .
 # HTTP Request .
 response=$(curl -X GET -s 'https://odc.officeapps.live.com/odc/emailhrd/getidp?hm=0&emailAddress='$2'&_=1604288577990')
 if [[ $response =~ 'MSAccount' ]]; then
  printf "\e[1;92m~\e[0m $2 - (\e[1;91m not Available \e[0m)\n"
  echo $2 >> "$1.notAvailable" # save
 elif [[ $response =~ 'Neither' ]]; then
  printf "\e[1;92m~\e[0m $2 - (\e[1;92m Available \e[0m)\n" # True
  echo $2 >> "$1.Available" # save
 fi; }



###


function PRINTme(){ # function fot print the logo ...
 printf "\n\n\e[1;104m  - sycTOOL v1.0, Telegram: @saycou -    \e[0m\n"
 echo "------coded--------by--------syc---------"
 printf "\e[7;40m  - github: https://github.com/ssycc -   \e[0m\n\n"
 }

###

PRINTme
read -p $'\e[1;92m~\e[0m your file: \e[0m' file # file
if [[ -z $file ]]; then # check if the input is not Empty .
	exit 0 # quit if the input is Empty .
else # countune the code ...
  if [[ -f $file ]]; then # check if input (file) is exist
	export -f CHECKme
	# 1 _ read the file , 2 _ grep emails
 	resp=$(cat $file 2> /dev/null | egrep '[A-Za-z0-9_.]+@(yahoo|gmail|hotmail|outlook)\.\w+' -o 2> /dev/null)
	# check if the $resp value is gt 0 .
	if [[ $(echo $resp | wc -w | cut -d ' ' -f1 ) -gt 0 ]]; then
		process=5 ; echo # Thread ;
		echo $resp | xargs -t -n1 -P$process bash -c 'CHECKme "$@"' _ $file 2> /dev/null
	else # if the file is Empty
		printf "\e[1;92m~\e[0m Error: \e[1;91mYour file is Empty !!\e[0m\n" ;fi
  else # if the file not exist
		printf "\e[1;92m~\e[0m Error: \e[1;91mYour file Not exist !!\e[0m\n" ;fi
fi
echo
#END


