#!/bin/env bash
# Author: 	Christakis Makarios 
# Date:		10/8/2021
# Purpose: 	Build the .env file for docker-compose using a .env.template 
# 		file, evaluating nested variables, since the 
# 		docker-compose parser doesn't do that.
# Invocation: 	./build-env.sh

# Template existance check
[[ -r $PWD/.env.template ]] || { echo "No readable .env.template file found in current directory. Exiting..."; exit 1; }

# Environment file existance check
[[ -e $PWD/.env ]] && echo -e "Environment file .env already exists.\nPlease delete it in order to generate a new one. Exiting..." && exit 2;

touch $PWD/.env;
for var in $(sed -r '/#/d' .env.template | tr -s [:space:] | xargs --replace={} echo {}); do
	export $var;
	eval echo $var >> $PWD/.env;
done

echo -e '---------';
echo -e "Environment variable file .env built is:\n";
cat $PWD/.env;
