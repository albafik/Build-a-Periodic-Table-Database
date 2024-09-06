#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# INSERT type data
# echo "$($PSQL "select distinct(type) from properties;")" | while read TYPE
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
#       INSERT_TYPE=$($PSQL "UPDATE properties SET type_id = $ID_TYPE;")
#     fi
#   done
# done

# CAPITALIZE SYMBOLS elements
#UPDATE_SYMBOL=$($PSQL "UPDATE elements SET symbol = UPPER(SUBSTRING(symbol, 1, 1)) || LOWER(SUBSTRING(symbol, 2));")

# UPDATE atomic_mass
# cat atomic_mass.txt | while IFS="|" read ID VALUE
# do
#   UPDATE_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM $VALUE::TEXT)::DECIMAL WHERE atomic_number = $ID")
# done

#INSERTING DATA
# FLOUR_PROPS=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');")
# NEON_PROPS=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');")

# INSERT_FLOURINE=$($PSQL "INSERT INTO properties(atomic_number, melting_point_celsius, boiling_point_celsius, type_id, atomic_mass) VALUES(9, -220, -188.1, 3,18.998);")
#INSERT_NEON=$($PSQL "INSERT INTO properties(atomic_number, melting_point_celsius, boiling_point_celsius, type_id, atomic_mass) VALUES(10, -248.6, -246.1, 3,20.18);")
