#!/bin/bash

echo "* Add minion ..."
echo "y" | sudo salt-key -A

echo "* Execute salt ssh ..."
sudo salt-call state.apply