#!/bin/bash

uptime=$(/usr/bin/uptime | awk '{print $3,$4}' | sed 's/,//')
days=$(/usr/bin/uptime | awk '{print $3}')
if [ "$days" -ge 7 ] && [ "$uptime" =~ .*"days".* ]
then
/usr/bin/osascript <<-EndOfScript
display dialog "Your laptop was restarted \n$uptime days ago\n\nPlease restart your laptop!\n\nThank you!" with title "Netguru Laptop higiene check!" with icon POSIX file "/Users/dawidbrygier/Desktop/netguru_logo.icns" buttons {"Don't restart", "Restart"} default button "Restart"
EndOfScript
echo "hey"
else
fi