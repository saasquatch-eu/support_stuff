#!/bin/sh -e
# ESET Management Agent
#
# Copyright (c) 2022 ESET, spol. s r.o.

## Stop and unload service
echo "Stoping ESET Management Agent... "
sudo /bin/launchctl remove com.eset.remoteadministrator.agent

## Remove launchdaemons
echo "Removing LaunchDaemon... "
sudo /bin/rm "/Library/LaunchDaemons/com.eset.remoteadministrator.agent_daemon.plist"

## Call forget in pkgutil
echo "Removing from pkgutil... "
sudo /usr/sbin/pkgutil --forget com.eset.remoteadministrator.agent

## Remove ESET Management Agent data
echo "Removing application data directory... "
sudo /bin/rm -rf "/Library/Application Support/com.eset.remoteadministrator.agent"

# !!! This has to be the last removal, because this script is located in this directory and sudo needs existing working directory on some versions of OS X, otherwise it will fail !!!
## Remove ESET Management Agent
echo "Removing application directory... "
sudo /bin/rm -rf "/Applications/ESET Management Agent.app"

# Remove the symlink for temporary compatibility fix
sudo /bin/rm -rf "/Applications/ESET Remote Administrator Agent.app"

exit 0