#! /usr/bin/bash
exec < /dev/tty7 > /dev/tty7
chvt 7
echo -n "Input user Name: "
read USERNAME
# While loop for password
echo -n "Enter user " 
USERPASSWD=$(mkpasswd -m sha512crypt)
chvt 1
echo "user --name=\"$USERNAME\" --groups=wheel --password=\"$USERPASSWD\" --iscrypted" > /tmp/user_data
#printf "user --name=\"$USERNAME\" --groups=wheel --password=\"$USERPASSWD\" --iscrypted" # >> /tmp/user_data

