#!/bin/bash

dir=$HOME/db/save
date=`date +"%Y_%m_%d"`
DBNAMES="`psql -U appli_web appli_web -l -A -F: | sed -ne "/:/ { /Name:Owner/d; /template1/d; /template0/d; s/:.*$//; p }"`"
for db in $DBNAMES 
do
	echo $db
	mkdir -p $dir/$db
	pg_dump -Fc $db > $dir/$db/$date.dump
done
