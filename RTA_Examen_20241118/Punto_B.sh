#!/bin/bash

USUARIO=$1
LISTA=$2
CONTRA=$(sudo grep "^$USUARIO:" /etc/shadow | awk -F: '{print $2}')

ANT_IFS=$IFS
IFS=$'\n'
for i in `cat $LISTA | awk -F ',' '{print $1" "$2" "$3}' | grep -v "#"`
do
        USUARIO=$(echo $i | awk '(print$1)')
        GRUPO=$(echo $i | awk '(print$2)')
        sudo useradd -d $HOME_USR -g $GRUPO -p $CONTRA $USUARIO
done
IFS=$ANT_IFS
