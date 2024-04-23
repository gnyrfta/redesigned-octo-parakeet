#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ATOMIC_SYMBOLS=$($PSQL "select symbol from elements");
ATOMIC_NAMES=$($PSQL "select name from elements");
ATOMIC_NUMBERS=$($PSQL "select atomic_number from properties");
MATCH=false;
if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument.";
else
  echo "$ATOMIC_SYMBOLS" | while read SYMBOL
  do
    if [[ $SYMBOL == $1 ]]
    then
    NUMBER=$($PSQL "select atomic_number from elements where symbol='$SYMBOL'");
    ATOMIC_NUMBER=$NUMBER;
    ATOMIC_NAME=$($PSQL "select name from elements where atomic_number=$NUMBER");
    ATOMIC_SYMBOL=$SYMBOL;
    ATOMIC_TYPE=$($PSQL "select type from properties where atomic_number=$NUMBER");
    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
    ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
    ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    fi
  done
  echo "$ATOMIC_NAMES" | while read NAME
  do
    if [[ $NAME == $1 ]]
    then
    NUMBER=$($PSQL "select atomic_number from elements where name='$NAME'");
    ATOMIC_NUMBER=$NUMBER;
    ATOMIC_NAME=$NAME;
    ATOMIC_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$NUMBER");
    ATOMIC_TYPE=$($PSQL "select type from properties where atomic_number=$NUMBER");
    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
    ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
    ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    fi
  done
  echo "$ATOMIC_NUMBERS" | while read NUMBER
  do
    if [[ $NUMBER -eq $1 ]]
    then 
        ATOMIC_NAME=$($PSQL "select name from elements where atomic_number=$NUMBER");
        ATOMIC_NUMBER=$NUMBER;
        ATOMIC_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$NUMBER");
        ATOMIC_TYPE=$($PSQL "select type from properties where atomic_number=$NUMBER");
        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
        ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
        ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
        echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    fi
  done
fi