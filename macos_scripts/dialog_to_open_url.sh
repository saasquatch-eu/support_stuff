#!/bin/bash

ask() {
osascript -e 'button returned of (display dialog "This MacBook is still managed by Netguru S.A. It needs to be restored to factory settings and set up manually. It can no longer be used for Netguru related work\n\nClick OK to see a guide on how to refresh this machine and detach from Netguru" with title "Netguru Laptop higiene check!" with icon POSIX file "/Applications/Workspace ONE Intelligent Hub.app/Contents/Resources/AppIcon.icns" buttons {"Remind me later", "Open"} default button "Open")'
}

action=$(ask)

if 
[ "$action" == "Open" ]
then 
    sudo /usr/bin/open https://google.com/
else
    exit 0
fi