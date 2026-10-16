#!/bin/zsh 
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )

echo "Show system prompt"
osascript -e 'display alert "Are you sure?" message "This will shut down Slack, clear its cache and require logging in again after it relaunches. Are you sure you want to continue?" as critical buttons {"Yes", "No! Cancel!"} default button "No! Cancel!" 
set response to button returned of the result 
if response is "No! Cancel!" then error number -128
if response is "Yes" then
end if' || exit 0

echo "Shutting down Slack"
osascript -e 'quit app "Slack"'

echo "Deleting Slack Library Files"

if [[ -d "/Users/$currentUser/Library/Application Support/Slack" ]]
then
	sudo rm -rf "/Users/$currentUser/Library/Application Support/Slack"
	echo "Directory /Application Support/Slack Exists and was removed"
else
	echo "Directory /Application Support/Slack does NOT exist"
fi

if [[ -d "/Users/$currentUser/Library/Saved Application State/com.tinyspeck.slackmacgap.savedState" ]]
then
	sudo rm -rf "/Users/$currentUser/Library/Saved Application State/com.tinyspeck.slackmacgap.savedState"
	echo "File com.tinyspeck.slackmacgap.savedState Exists and was removed"
else
	echo "File com.tinyspeck.slackmacgap.savedState does NOT exist"
fi

if [[ -f "/Users/$currentUser/Library/Preferences/com.tinyspeck.slackmacgap.plist" ]]
then
	sudo rm -f "/Users/$currentUser/Library/Preferences/com.tinyspeck.slackmacgap.plist"
		echo "File com.tinyspeck.slackmacgap.plist Exists and was removed"
else
	echo "File com.tinyspeck.slackmacgap.plist does NOT exist"
fi

if [[ -f "/Users/$currentUser/Library/Preferences/com.tinyspeck.slackmacgap.helper.plist" ]]
then
	sudo rm -f "/Users/$currentUser/Library/Preferences/com.tinyspeck.slackmacgap.helper.plist"
	echo "File com.tinyspeck.slackmacgap.helper.plist Exists and was removed"
else
	echo "File com.tinyspeck.slackmacgap.helper.plist does NOT exist"
fi

if [[ -d "/Users/$currentUser/Library/Logs/Slack/" ]]
then
	sudo rm -rf "/Users/$currentUser/Library/Logs/Slack/"
	echo "Directory /Library/Logs/Slack/ Exists and was removed"
else
	echo "Directory /Library/Logs/Slack/ does NOT exist"
fi

if [[ -f "/Users/$currentUser/Library/Caches/com.tinyspeck.slackmacgap" ]]
then
	sudo rm -f "/Users/$currentUser/Library/Caches/com.tinyspeck.slackmacgap"
	echo "File com.tinyspeck.slackmacgap Exists and was removed"
else
	echo "File com.tinyspeck.slackmacgap does NOT exist"
fi

if [[ -f "/Users/$currentUser/Library/Caches/com.tinyspeck.slackmacgap.ShipIt" ]]
then
	sudo rm -f "/Users/$currentUser/Library/Caches/com.tinyspeck.slackmacgap.ShipIt"
	echo "File com.tinyspeck.slackmacgap.ShipIt Exists and was removed"
else
	echo "File com.tinyspeck.slackmacgap.ShipIt does NOT exist"
fi

echo "Slack cache was nuked"

echo "Opening Slack"

open /Applications/Slack.app

exit 0