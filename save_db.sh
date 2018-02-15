#!/bin/bash

source ./conf.sh


date=`date +"%Y_%m_%d"`

if [ "$HOST" = "localhost" ]; then
	HOST="$USERNAME"
	echo "---Backup for local server---"
else
	echo "---Backup for remote server : $HOST---"
fi

echo "postgre user : $USERNAME"

DBNAMES="`psql -U $USERNAME $HOST -l -A -F: | sed -ne "/:/ { /Name:Owner/d; /template1/d; /template0/d; s/:.*$//; p }"`"
for db in $DBNAMES 
do
	filename="$DIR/$date.dump"

	echo "Creating backup for $db ..."
	if ! mkdir -p $DIR/$db; then
		echo "ERROR : Failed to create file $dir/$db, check your prilileges"
	fi
	if ! pg_dump -Fc $db > $filename; then
		echo "ERROR : Failed to dump database $db"
	else
		echo "Backup created for $db! --> $filename"
	fi
done

echo "---Database dump finished---"
