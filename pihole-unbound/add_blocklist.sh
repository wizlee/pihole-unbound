#!/bin/bash

# DO NOT use this script yet, this is a unrefined copy paste from ChatGPT
# refined based on this repo: https://github.com/mmotti/pihole-regex/blob/22c7d626b200a263c0798126c9a20bd20ffb6f33/install.py#L133

# Define blocklist URL
BLOCKLIST_URL="https://example.com/blocklist.txt"

# Check if URL is valid and not already in gravity database
if curl --output /dev/null --silent --head --fail "$BLOCKLIST_URL"; then
  echo "URL exists: $BLOCKLIST_URL"
  if sqlite3 "/etc/pihole/gravity.db" "SELECT address FROM adlist WHERE address = '$BLOCKLIST_URL';" | grep -q "$BLOCKLIST_URL"; then
    echo "URL already in gravity database: $BLOCKLIST_URL"
  else
    echo "Adding URL to gravity database: $BLOCKLIST_URL"
    sqlite3 "/etc/pihole/gravity.db" "INSERT INTO adlist (address) VALUES ('$BLOCKLIST_URL');"
  fi
else
  echo "URL does not exist: $BLOCKLIST_URL"
fi
