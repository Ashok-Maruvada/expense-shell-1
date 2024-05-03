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

validate(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 : $R failed $N "
        exit 1
    else
        echo -e "$2 : $G sucees $N "
    fi
}

check_root(){
    if [ $userid -ne 0 ]
    then
        echo "please use root access"
        exit 1
    else
        echo " u are super user"
    fi
}