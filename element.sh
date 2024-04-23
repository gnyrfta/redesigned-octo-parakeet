#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ATOMIC_FACTS=$($PSQL "select symbol,name,atomic_number from elements");
ROW_COUNTER=10;#SHOULD BE TAKEN FROM DB. Fix this.
UNMATCHED_COUNTER=0;
if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument.";
else
  echo "$ATOMIC_FACTS" | sed -E 's/\|/ /g' | while read SYMBOL NAME NUMBER
  do
    if [[ $SYMBOL == $1 ]]
    then
    NUMBER=$($PSQL "select atomic_number from elements where symbol='$SYMBOL'");
    ATOMIC_NUMBER=$NUMBER;
    ATOMIC_NAME=$($PSQL "select name from elements where atomic_number=$NUMBER");
    ATOMIC_SYMBOL=$SYMBOL;
    TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$NUMBER");
    ATOMIC_TYPE=$($PSQL "select type from types where type_id=$TYPE_ID");
    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
    ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
    ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    elif [[ $NAME == $1 ]]
    then
    NUMBER=$($PSQL "select atomic_number from elements where name='$NAME'");
    ATOMIC_NUMBER=$NUMBER;
    ATOMIC_NAME=$NAME;
    ATOMIC_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$NUMBER");
    TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$NUMBER");
    ATOMIC_TYPE=$($PSQL "select type from types where type_id=$TYPE_ID");
    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
    ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
    ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
    echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    elif [[ $NUMBER -eq $1 ]]
    then
     ATOMIC_NAME=$($PSQL "select name from elements where atomic_number=$NUMBER");
        ATOMIC_NUMBER=$NUMBER;
        ATOMIC_SYMBOL=$($PSQL "select symbol from elements where atomic_number=$NUMBER");
        TYPE_ID=$($PSQL "select type_id from properties where atomic_number=$NUMBER");
        ATOMIC_TYPE=$($PSQL "select type from types where type_id=$TYPE_ID");
        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$NUMBER");
        ATOMIC_MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$NUMBER");
        ATOMIC_BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$NUMBER");
        echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ATOMIC_TYPE, with a mass of $ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ATOMIC_MELTING_POINT celsius and a boiling point of $ATOMIC_BOILING_POINT celsius.";
    else 
    UNMATCHED_COUNTER=$((UNMATCHED_COUNTER+1));
    if [[ $UNMATCHED_COUNTER -eq $ROW_COUNTER ]]
    then
    echo "I could not find that element in the database."
    fi
    fi
  done
fi
