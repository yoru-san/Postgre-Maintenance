#!/bin/bash 
 
ACTUALDIR=$(cd `dirname $0` && pwd)

source $ACTUALDIR/conf.sh

database=$1 
finaldate="$2 days ago" #Conversion of the parameter into language understood by the machine
inferiordate=$(date +%s -d "$finaldate")

for file in $DIR/$database/*; do #Loop on all the archives
	savename=$(basename $file)
	savebasename=${savename%.dump}	#Removing the archive extension to keep the date
	savedatedash=${savebasename//_/-} #Conversion of archive names by replacing underscores 					  with dashes
	savedate=$(date -d $savedatedash +%s)

	if [[ $inferiordate -ge $savedate ]]; then #if the date chosen by the user is greater than 							   the date contained in the archive's name 							  
		echo "---Suppressing archive $file---"
		rm $file 
	fi
done
