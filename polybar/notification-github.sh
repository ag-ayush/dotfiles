#!/bin/sh

TOKEN="1ef4456ec2d4b1246830ea3a73a0422519353718"

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "# $notifications"
else
    echo ""
fi
