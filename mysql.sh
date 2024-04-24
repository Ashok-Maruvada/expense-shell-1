#!/bin/bash

source ./common.sh

check_root

echo " please enter DB password"
read -s mysql_root_password
dnf install mysql-server -y &>>$LOGFILE
# validate $? "installing mysql server"

systemctl enable mysqld &>>$LOGFILE
# validate $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
# validate $? "starting mysql"

# mysql_secure_installation --set-root-password ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"
# below code is to make script idempotent 

mysql -h 172.31.20.107 -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    # validate $? " setting root password "
else
    echo -e " root password is already set up : $G skipping $N "
fi
