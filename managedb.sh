#!/bin/bash
#Nos 2 paramètres
action=$1
database=$2

if [ ! $# -eq 1 ] || [ ! $# -eq 2 ];
then
        echo "Mauvais arguments reçus."
	echo "Usage :"
 	echo "3 options :"
	echo "Sauvegarder une base avec -s"
	echo "Restaurer une base avec -r"
	echo "Supprimer des archives avec -d"
	echo "Ensuite, 2 paramètres :"
	echo "le nom de la base ciblé"
	echo "ou pas de paramètre pour cibler toutes les bases"
fi

case $1 in
	-s)
		#save_db;;
		echo "save";;
	-r)
		#restore_db;;
		echo "restore";;
	-d) 
		#delete_archive;;
		echo "delete";;
esac
	
	

