#!/bin/bash 
 
source ./conf.sh

database=$1 
finaldate="$2 days ago"
inferiordate=$(date +%s -d "$finaldate")
 
#echo $(date +\%Y-\%m-\%d -d "$finaldate") 

for file in $DIR/$database/*; do
	savename=$(basename $file)
	savebasename=${savename%.dump}
	savedatedash=${savebasename//_/-}
	savedate=$(date -d $savedatedash +%s)

	if [[ $inferiordate -ge $savedate ]]; then
		echo "Suppression archive $file"
		rm $file
	fi
done
