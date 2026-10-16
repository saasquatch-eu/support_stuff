#!/bin/bash

osascript -e 'display alert "This MacBook was bought out by you but is still managed by Netguru S.A. 

It needs to be restored to factory settings and set up manually. 

It should no longer be used for Netguru related work!

Click GUIDE to see a guide on how to refresh this machine and fully detach from Netguru." as critical buttons {"Quit", "Guide"} default button "Guide"

set response to button returned of the result

if response is "Guide" then open location "https://support.apple.com/en-us/HT212749"'