#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [ ! "$1" ]; then
  echo "Please provide an element as an argument."
else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $(($1)) OR symbol = '$1' OR name = '$1';")
  if [ -z $ATOMIC_NUMBER ]; then
    echo "I could not find that element in the database."
  else
    DATA=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = $(($ATOMIC_NUMBER));")
    echo "$DATA" | while read ID BAR SYMBOL BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do
      echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
fi

