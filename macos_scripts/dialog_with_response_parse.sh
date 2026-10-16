#!/usr/bin/env bash

uptime=$(/usr/bin/uptime | awk '{print $3}') # get uptime as integer
days=$(/usr/bin/uptime | awk '{print $4}' | sed 's/,//') # check if uptime is in days
pref="/Library/Preferences/restart.notification" # path to the preference file
pref_value=$(/bin/cat /Library/Preferences/restart.notification) # value of the preference file

displaydialog() {
osascript -e 'button returned of (display dialog "Your laptop was last restarted \n'$uptime' days ago!\n\nIt is a good idea to regularly restart your laptop in order to have the best possible experience and performance.\n\nPlease restart your laptop!\n\nThank you!" with title "Netguru Laptop higiene check!" with icon POSIX file "/Library/Application Support/Nudge/netguru_logo.jpg" buttons {"Restart now", "Remind me later", "Do not remind me"} default button "Restart now")'
}

if [ ! -f "$pref" ] || [ -z "$pref_value" ] # check if either $pref file exists or if it is empty
then
    if [ "$uptime" = 10 ] || [ "$uptime" = 20 ] || [ "$uptime" = 30 ] && [ "$days" = "days" ] # only display dialog if uptime is 10, 20 or 30 days
    then
    button=$(displaydialog)
        if [[ $button == "Restart now" ]]
        then 
        sudo shutdown -r now
        else 
         if [[ $button == "Do not remind me" ]]
         then
         touch /Library/Preferences/restart.notification # create the file if it doesn't exist
         echo "1" > /Library/Preferences/restart.notification # set the value of the file to 1
         else
         exit 0
         fi
        fi
    else
    exit 0   
    fi
else 
    if [ "$pref" = "1" ] # if the value of the file is 1, mute notification
    then
    exit 0
    fi
fi

exit 0