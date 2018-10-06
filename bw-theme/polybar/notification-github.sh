#!/bin/sh

TOKEN="806da33b492f8b859abef17eb69b99ab9f3fa281"

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "# $notifications"
else
    echo ""
fi
