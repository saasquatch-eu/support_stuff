#!/bin/bash
file_name=$1
pswd=$2
mail=$3

zip -P $pswd $file_name.zip $file_name.pdf

echo -e "sender.sh File $file_name.pdf zipped."

python3 sender.py $file_name.zip $mail


#uuencode $file_name.zip $file_name.zip | mail -s "maile z automatu 4" $mail 
