#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#CORRECTING TABLES
# $($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")
# $($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;")
# $($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;")
# $($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;")
# $($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;")
# $($PSQL "ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE(symbol);")
# $($PSQL "ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name);")
# $($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;")
# $($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL;")
# $($PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);")
#$($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR(30) NOT NULL);")


# INSERT type data
# echo "$($PSQL "SELECT DISTINCT(type) FROM properties;")" | while read TYPE
# do
#   INSERT=$($PSQL "INSERT INTO types(type) VALUES('$TYPE');")
#   echo $TYPE
# done

#ADD TYPE INDEX ON "properties"
# PROPERTIES=$($PSQL "SELECT atomic_number, type FROM properties;")
# TYPES_T=$($PSQL "SELECT * FROM types;")
# echo "$PROPERTIES" | while read N_ATOMIC BAR TYPE
# do
#   echo "$TYPES_T" | while read ID_TYPE BAR TYPES
#   do
#     if [[ $TYPES == $TYPE ]]
#     then
#       INSERT_TYPE=$($PSQL "UPDATE properties SET type_id = $ID_TYPE WHERE atomic_number = $N_ATOMIC;")
#     fi
#   done
# done

# CAPITALIZE SYMBOLS elements
# UPDATE_SYMBOL=$($PSQL "UPDATE elements SET symbol = UPPER(SUBSTRING(symbol, 1, 1)) || LOWER(SUBSTRING(symbol, 2));")

# UPDATE atomic_mass
# cat atomic_mass.txt | while IFS="|" read ID VALUE
# do
#   UPDATE_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM $VALUE::TEXT)::DECIMAL WHERE atomic_number = $ID")
# done

#INSERTING DATA
# FLOUR_PROPS=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');")
# NEON_PROPS=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');")

# INSERT_FLOURINE=$($PSQL "INSERT INTO properties(atomic_number, melting_point_celsius, boiling_point_celsius, type_id, atomic_mass) VALUES(9, -220, -188.1, 2,18.998);")
# INSERT_NEON=$($PSQL "INSERT INTO properties(atomic_number, melting_point_celsius, boiling_point_celsius, type_id, atomic_mass) VALUES(10, -248.6, -246.1, 2,20.18);")

# PROGRAM LOGIC
#echo -e "\n~~~ Periodic Table Program ~~~\n"

if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
    GET_ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, melting_point_celsius, boiling_point_celsius, atomic_mass, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
  fi
  if [[ $1 =~ ^[A-Z][a-z]*$ ]]
  then 
    GET_ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, melting_point_celsius, boiling_point_celsius, atomic_mass, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1' OR symbol = '$1';")
  fi
  if [[ -z $GET_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $GET_ELEMENT | while IFS="|" read NUMBER SYMBOL NAME MELTING BOILING MASS TYPE
    do
      NUMBER_FORMATTED=$(echo $NUMBER | sed -E 's/^ *| *$//g')
      SYMBOL_FORMATTED=$(echo $SYMBOL | sed -E 's/^ *| *$//g')
      NAME_FORMATTED=$(echo $NAME | sed -E 's/^ *| *$//g')
      MELTING_FORMATTED=$(echo $MELTING | sed -E 's/^ *| *$//g')
      BOILING_FORMATTED=$(echo $BOILING | sed -E 's/^ *| *$//g')
      MASS_FORMATTED=$(echo $MASS | sed -E 's/^ *| *$//g')
      TYPE_FORMATTED=$(echo $TYPE | sed -E 's/^ *| *$//g')
      echo "The element with atomic number $NUMBER_FORMATTED is $NAME_FORMATTED ($SYMBOL_FORMATTED). It's a $TYPE_FORMATTED, with a mass of $MASS_FORMATTED amu. $NAME_FORMATTED has a melting point of $MELTING_FORMATTED celsius and a boiling point of $BOILING_FORMATTED celsius."
    done
  fi
fi

