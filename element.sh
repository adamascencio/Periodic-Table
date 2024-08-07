#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument.";
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUM=$1
  DATABASE_QUERY_RESULT=$($PSQL "
    SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM properties
    JOIN types USING(type_id)
    JOIN elements USING(atomic_number)
    WHERE atomic_number = $ATOMIC_NUM;
  ")
  if [[ -z $DATABASE_QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $DATABASE_QUERY_RESULT | while IFS="|" read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT;
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then
  SYMBOL=$1
  DATABASE_QUERY_RESULT=$($PSQL "
    SELECT name, symbol, atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM properties
    JOIN types USING(type_id)
    JOIN elements USING(atomic_number)
    WHERE symbol = '$SYMBOL';
  ")
  if [[ -z $DATABASE_QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $DATABASE_QUERY_RESULT | while IFS="|" read NAME SYMBOL ATOMIC_NUM TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT;
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
elif [[ $1 =~ ^[a-zA-Z]{3,}$ ]]
then
  NAME=$1
  DATABASE_QUERY_RESULT=$($PSQL "
    SELECT name, symbol, atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM properties
    JOIN types USING(type_id)
    JOIN elements USING(atomic_number)
    WHERE name = '$NAME';
  ")
  if [[ -z $DATABASE_QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $DATABASE_QUERY_RESULT | while IFS="|" read NAME SYMBOL ATOMIC_NUM TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT;
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi