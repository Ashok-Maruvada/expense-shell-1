#!/bin/bash

set -e

error_spot(){
    echo " error occured at line number $1 : and error command is $2 " 
}
trap 'error_spot ${LINENO} "${BASH_COMMAND}"' ERR

userid=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
script_name=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$script_name-$timestamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){
    if [ $userid -ne 0 ]
    then
        echo "please use root access"
        exit 1
    else
        echo " u are super user"
    fi
}