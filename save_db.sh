#!/bin/bash

ACTUALDIR=$(cd `dirname $0` && pwd)

source $ACTUALDIR/conf.sh

date=`date +"%Y_%m_%d"`

#Check if host is local or distant
if [ "$HOST" = "localhost" ]; then
	DBHOST="$USERNAME"
	echo "---Backup for local server---"
else
	DBHOST="$HOST"
	echo "---Backup for remote server : $HOST---"
fi

echo "postgre user : $USERNAME"

#If no database given in conf.sh, saving all database
if [ ! "$DBNAMES" ] || [ "$DBNAMES" = "" ];then


	#Get all DB for given user

	DBNAMES="`psql -U $USERNAME $DBHOST -l -A -F: | sed -ne "/:/ { /Name:Owner/d; /template1/d; /template0/d; s/:.*$//; p }"`"
fi


for db in $DBNAMES 
do
	filename="$DIR/$db/$date.dump"
																			
echo "$DIR"
	echo "Creating backup for $db ..."
	if ! mkdir -p $DIR/$db; then
		echo "ERROR : Failed to create file $DIR/$db, check your privileges"
	fi
	if ! PGPASSWORD=$PASSWORD pg_dump -U $USERNAME -h $HOST -Fc $db > $filename; then
		echo "ERROR : Failed to dump database $db"
	else
		echo "Backup created for $db! --> $filename"
	fi
done

echo "---Database dump finished---"
