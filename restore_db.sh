#!/bin/bash

ACTUALDIR=$(cd `dirname $0` && pwd)

source $ACTUALDIR/conf.sh

#If only database name given
if [ $# = 1 ]; then
	DB=$1

	echo "Restoring last dump for $DB..."

	#Get the most recent file for the database dump

	if ! last_dump="$HOME/db/save/$DB/$(ls -Art $HOME/db/save/$DB | tail -n 1)"; then
		echo "Failed to load last dump, check your files in $HOME/db/save/"
	else
		echo "Dump file used :$last_dump"
		if ! PGPASSWORD=$PASSWORD pg_restore -v -U $USERNAME -h $HOST -c -d $DB $last_dump; then
		
			echo "Failed to restore database from $last_dump"
			echo "Check error messages for further informations"
		else
			echo "Auto-restoration finished successfully"
		fi
	fi
		
#If database name and archive path given 
elif [ $# = 2 ]; then
	DB=$1
	ARCHIVE=$2

	echo "Restoring $DB from $ARCHIVE"
	if ! PGPASSWORD=$PASSWORD pg_restore -v -U $USERNAME -h $HOST -c -d $DB $ARCHIVE; then
		echo "Failed to restore db $1 from $2, check error messages for further informations"
	else
		echo "Manual restoration finished sucessfully"
	fi
else
	echo "ERROR : invalid argument (restore_db.sh 'db_name' {'archive_path'})"
fi
