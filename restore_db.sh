#!/bin/bash

source ./conf.sh


if [ $# = 1 ]; then
	echo "Restoring last dump for $1..."
	if ! last_dump="$HOME/db/save/$1/$(ls -Art $HOME/db/save | tail -n 1)"; then
		echo "Failed to load last dump, check your files in $HOME/db/save/"
	else
		echo "Dump file used :$last_dump"
		if ! pg_restore -d $1 -v $last_dump; then
		
			echo "Failed to restore database from $last_dump"
			echo "Check error messages for further informations"
		else
			echo "Auto-restoration finished successfully"
		fi
	fi
		

elif [ $# = 2 ]; then
	echo "Restoring $1 from $2"
	if ! pg_restore -d $1 -v $2; then
		echo "Failed to restore db $1 from $2, check error messages for further informations"
	else
		echo "Manual restoration finished sucessfully"
	fi
fi
