#!/bin/bash

<<<<<<< HEAD
USUARIO=$1
LISTA=$2
=======
# Parámetros
USUARIO=$1
LISTA=$2

>>>>>>> 693e841 (añadiendo carpetas y el resto de ejercicios)
CONTRA=$(sudo grep "^$USUARIO:" /etc/shadow | awk -F: '{print $2}')

ANT_IFS=$IFS
IFS=$'\n'
<<<<<<< HEAD
for i in `cat $LISTA | awk -F ',' '{print $1" "$2" "$3}' | grep -v "#"`
do
        USUARIO=$(echo $i | awk '(print$1)')
        GRUPO=$(echo $i | awk '(print$2)')
        sudo useradd -d $HOME_USR -g $GRUPO -p $CONTRA $USUARIO
done
=======

for i in $(cat $LISTA | awk -F ',' '{print $1" "$2" "$3}' | grep -v "#")
do
    NUEVO_USUARIO=$(echo $i | awk '{print $1}')
    GRUPO=$(echo $i | awk '{print $2}')
    HOME_USR="/home/$NUEVO_USUARIO"

    sudo groupadd -f $GRUPO

    sudo useradd -d $HOME_USR -g $GRUPO -m -p $CONTRA $NUEVO_USUARIO
done

>>>>>>> 693e841 (añadiendo carpetas y el resto de ejercicios)
IFS=$ANT_IFS
