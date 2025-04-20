#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [ ! "$1" ]; then
  echo "Please provide an element as an argument."
else
  QUERY="SELECT * FROM elements WHERE atomic_number = '$1' OR symbol = '$1' OR name = '$1';"
fi

