#!/bin/bash


pg_restore -d $1 -C $2
