#!/bin/sh -e
if [ ! -d "/Applications/ESET Management Agent.app" ]; then
echo "App does not exist"; exit 0
else
echo "Proceeding to app removal..."
fi
exit 1