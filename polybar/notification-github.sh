#!/bin/sh

TOKEN="422b5d07d7c3d57480c2de104f0a247db051f54e"

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "# $notifications"
else
    echo ""
fi
