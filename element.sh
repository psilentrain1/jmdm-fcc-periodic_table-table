#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [ ! "$1" ]; then
  echo "Please provide an element as an argument."
else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $(($1)) OR symbol = '$1' OR name = '$1';")
  if [ -z $ATOMIC_NUMBER ]; then
    echo "I could not find that element in the database."
  else
    echo "Continue"
    fi
fi

