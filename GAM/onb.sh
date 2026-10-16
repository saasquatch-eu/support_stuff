#!/bin/bash

: "${ONBOARDING_INITIAL_PASSWORD:?Set ONBOARDING_INITIAL_PASSWORD before running}"

# v1.0
# zeby działał jak GAM, to należy dopisac w ./bash_profile lub ./zshrc
# alias onb="sicezka_do_pliku"
# plik.sh nalezy zmienićna Wykonywalny
# chmod 755 ./sciezka_do_skryptu

# wodotryski
red="\x1b[31m"
rstecho="\x1B[0m"
blink="\033[5m"
stopbl="\033[0m"
path="$HOME/Documents/onboarding"
ghpath="$path/permissions/members/netguru"
# scieżka do gama
# to jest ścieżka u mnie, sprawddźcie, czy u was jest ok
gam="$HOME/bin/gamadv-xtd3/gam"

# funkcja tworząca ymle
create_yml () {

    l1=$(echo "$1" | tr '[:upper:]' '[:lower:]') #lower $1
    l2=$(echo "$2" | tr '[:upper:]' '[:lower:]') #lower $2

echo "---
name: $1 $2
github: $3" > $ghpath/$l1.$l2.yml
echo "public_key: 
emails:
- $1.$2@netguru.com
- $1.$2@netguru.co
- $1.$2@netguru.pl
" | tr '[:upper:]' '[:lower:]' >> $ghpath/$l1.$l2.yml
}

mkdir -p $path
cd $path

clear

sleep .5

echo firstname,lastname,email,groups >> newbies.csv # pierwszy wiersz z nazwami kolumn

while true; # pętelka na wprowadzanie userów i grup do pliku
do
    read -r -p "Create new user? y/n " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo
        echo -e "$red Provide Firstname Lastname Email and GitHubnick (space separated) $rstecho" 
        read firstname lastname email github
        sleep .5
        echo -e "$red What email groups? (comma separated; Team is added by default) $rstecho"
        echo -e "$red i.e. support,finance,pm $rstecho"
        read groups
        echo
        echo "Adding entries to the csv file"
        sleep .5
        echo $firstname,$lastname,$email,\"team,$groups\" >> newbies.csv
        echo $firstname $lastname $github >> gh.txt
    else
        break
    fi
done

clear
echo
echo
echo -e "$blink$red Check your entries $stopbl$rstecho"
echo
sleep .5

cd $path
# pretty csv stuff
echo "GAM csv"
cat newbies.csv | perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' "$@" | column -t -s, | less  -F -S -X -K
echo
echo "Github file"
cat $path/gh.txt
echo
echo "If something is wrong, edit the files mannualy"
echo -e " \x1b[1m$path/newbies.csv $rstecho"
echo -e " \x1b[1m$path/gh.txt $rstecho"
read -p "If it's correct, press enter"
echo
sleep .5

# klonowanie repo /permissions do $path
cd $path
echo 
while true;
do
    echo "This will clone or update permissions repo"
    read -r -p "Do you have /permissions already clonned? y/n " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo "Updating..."
        cd permissions
        git pull
        break
    else
        echo "Cloning..."
        cd $path
        git clone git@github.com:netguru/permissions.git
        cd permissions
        echo "teraz trzeba nadać sobie uprawnienia do pliku ./config"
        sudo chown -R $(whoami) $HOME/.config
        read -p "jeśli to zostało zrobione, mozna usunać wiersze 104-106, enter"
        git init
        break
    fi
done
clear
sleep .2

echo "Creating yml files"
cat $path/gh.txt | while read firstname lastname github
do
    create_yml "$firstname" "$lastname" "$github"
done
# commit do mastera /permissions
cd $path/permissions
git add .
read -p "Name commit: " com
git commit -m $com
git push origin master

# GAM tworzy userów i dodaje do grup
cd $path
echo "GAM starting..."
$gam csv newbies.csv gam create user ~email firstname ~firstname lastname ~lastname password "$ONBOARDING_INITIAL_PASSWORD" changepassword on org "/Active users"
$gam csv newbies.csv gam update group ~groups add member ~email
$gam csv newbies.csv gam user ~email add calendar netguru.pl_nj81hldc5ado5g3jivjnlb5f4k@group.calendar.google.com selected true colorindex 9

#cleanup
mkdir -p $path/arch
mv -v newbies.csv $path/arch/newbies_"$(date +"%Y_%m_%d")".csv
mv -v gh.txt $path/arch/gh_"$(date +"%Y_%m_%d")".txt
