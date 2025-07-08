#!/bin/bash

#Colors
GREEN="\e[0;32m\033[1m"
END="\033[0m\e[0m"
RED="\e[0;31m\033[1m"
BLUE="\e[0;34m\033[1m"
YELLOW="\e[0;33m\033[1m"
PURPLE="\e[0;35m\033[1m"
TURQUOISE="\e[0;36m\033[1m"
GRAY="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${RED}[!] Saliendo...${END}\n"
  tput cnorm; exit 1
}

#Ctrl+C
trap ctrl_c SIGINT

declare -a ports=( $(seq 1 65535) )

function checkPort(){
  (exec 3<> /dev/tcp/$1/$2) 2>/dev/null

  if [ $? -eq 0 ]; then
    echo -e "${PURPLE}[+]${END}${GRAY} Host${END}${BLUE} $1${END}${GRAY} - Port${END}${BLUE} $2${END}${GREEN} (OPEN)${END}"
  fi

  exec 3<&-
  exec 3>&-
}
tput civis
if [ $1 ]; then
  for port in ${ports[@]}; do
    checkPort $1 $port &
  done
else
  echo -e "\n${RED}[!] Debes insertar una IP válida${END}"
  echo -e "\n${PURPLE}[+]${END}${GRAY} Uso: $0 <ip-adress>${END}\n"
fi
wait
tput cnorm
