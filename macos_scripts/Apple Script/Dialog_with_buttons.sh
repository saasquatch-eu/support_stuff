#!/bin/bash

osascript -e 'display dialog "This MacBook is still managed by Netguru S.A. 

It needs to be restored to factory settings and set up manually. 

It can no longer be used for Netguru related work!

Click OK to see a guide on how to refresh this machine and detach from Netguru." with icon caution
--> result: {button returned:"OK"}
if button returned of result is equal to "OK" then
	tell application "Safari"
		activate
		tell window 1
			set current tab to make new tab with properties {URL:"https://support.apple.com/en-us/HT212749"}
		end tell
	end tell
end if'