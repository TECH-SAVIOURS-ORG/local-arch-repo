#!/bin/bash

if [[ $EUID -ne 0 ]]
then
echo "This script must be run as root"
exit 1
fi

read -r -p "Do you want to install a server repository or do you want to add a client? [SERVER/client] " prompt

if [[ $prompt == "SERVER" ]]
then
bash scripts/server.sh

elif [[ $prompt == "client" ]]
then
bash scripts/client.sh

else
echo "Nothing has been selected."
fi
