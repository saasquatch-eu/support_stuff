#!/bin/bash

# main runner and updater for onb.sh

path="$HOME/Documents/onboarding"
tmp_path=$path/tmp/support_stuff/GAM

#create a temp catalog for /support_stuff repo clone
mkdir -p $path/tmp
mkdir -p $path/arch
cd $path/tmp
# cloning 
git clone git@github.com:netguru/support_stuff.git

if [[ -e $path/onb.sh ]]; then
    mv -v $path/onb.sh $path/arch/onb_old_"$(date +"%Y_%m_%d")".sh
    mv -v $tmp_path/onb.sh $path/onb.sh
else
    mv -v $tmp_path/onb.sh $path/onb.sh
fi

#open onboarding as new process
(
    bash $path/onb.sh
)
#cleanup
rm -rf $path/tmp