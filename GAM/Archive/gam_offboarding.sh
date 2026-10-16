#!/bin/bash
if [ $# -eq 0 ] || [ $# -eq 1 ]; then
  echo "Arguments are incomplete! Please rerun."
  exit 1
fi

old_user=$1
leader=$2
gam="$HOME/bin/gamadv-xtd3/gam"


sleep 1
echo -e "\x1B[0;36m Transfer calendar events and release resources \x1B[0m"
$gam create datatransfer $old_user calendar $leader release_resources true

echo -e "\x1B[0;36m Processing $old_user \x1B[0m" 
echo -e "\x1B[0;36m Changing user password to random \x1B[0m"

$gam update user $old_user password random

echo -e "\x1B[0;36m Password changed \x1B[0m"

sleep 2

echo -e "\x1B[0;36m Removing user from all groups \x1B[0m"

sleep 1

$gam user $old_user delete groups

echo -e "\x1B[0;36m groups deleted for $old_user \x1B[0m"

sleep 1

echo -e "\x1B[0;36m Changing organisational unit to Leaving users \x1B[0m"

$gam update user $old_user ou "/leaving users"

echo -e "\x1B[0;36m removing access to shared drives \x1B[0m"

$gam user $old_user print teamdrives id > $old_user.csv

$gam csv $old_user.csv gam user dawid.brygier delete drivefileacl ~id $old_user asadmin

echo -e "\x1B[0;36m access to shared drives removed \x1B[0m"

rm $old_user.csv


echo -e "\x1B[0;36m Delegating mailbox \x1B[0m"
$gam user $old_user delegate to $leader

echo -e "\x1B[0;36m Removing email forwarding \x1B[0m"
$gam user $old_user print forwardingaddress > $old_user.csv

$gam csv $old_user.csv gam user $old_user delete forwardingaddress ~forwardingEmail

rm $old_user.csv

echo -e "\x1B[0;36m Deprovisioning user \x1B[0m"
$gam user $old_user deprovision

echo -e "\x1B[0;36m Wiping Devices \x1B[0m"
$gam print mobile query $old_user resourceID > $old_user.csv
$gam csv $old_user.csv gam update mobile ~resourceId action account_wipe
echo -e "\x1B[0;36m Deleting Devices \x1B[0m"
$gam csv $old_user.csv gam delete mobile ~resourceId
rm $old_user.csv

sleep 60
echo -e "\x1B[0;36m Transfer $old_user files to the Graveyard \x1B[0m"
$gam create datatransfer $old_user gdrive graveyard privacy_level shared,private

echo -e "\x1B[0;36m Suspending user \x1B[0m"
$gam update user $old_user suspended on

sleep 1
