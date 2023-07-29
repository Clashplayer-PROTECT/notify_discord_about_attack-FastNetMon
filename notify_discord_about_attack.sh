#!/bin/bash

# URL Webhook Discord
webhook_url="https://discord.com/api/webhooks/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

if [ "$4" = "unban" ]; then
    rm /etc/bird/blackholes/${1}.ipv4.conf
    birdc configure
    message="{\"content\":\"(INFO) removing mitigation for IP $1\"}"
    curl -H "Content-Type: application/json" -d "$message" $webhook_url
    exit 0
fi

if [ "$4" = "ban" ]; then
    message="{\"content\":\"(WARNING) IP $1 is under attack: $3 pps - starting mitigation\"}"
    curl -H "Content-Type: application/json" -d "$message" $webhook_url
    exit 0
fi

if [ "$4" == "attack_details" ]; then
    message="{\"content\":\"FastNetMon Guard: IP $1 blocked because $2 attack with power $3 pps\"}"
    curl -H "Content-Type: application/json" -d "$message" $webhook_url
    exit 0
fi
