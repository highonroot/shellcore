#!/bin/bash

url="$1"

if [ -z "$url" ]; then
    read -p "Enter URL: " url
fi

if [[ "$url" != http* ]]; then
    url="http://$url"
fi

url_host=$(echo "$url" | sed -E 's|https?://||' | cut -d'/' -f1)

echo ""
echo "Checking: $url"
echo "----------------------------------"

dns_output=$(host "$url_host" 2>/dev/null)

if [ $? -eq 0 ]; then
    ipv4=$(echo "$dns_output" | awk '/has address/ {print $4}')
    ipv6=$(echo "$dns_output" | awk '/has IPv6 address/ {print $5}')

    if [ -n "$ipv4" ]; then
        echo "DNS (IPv4): $ipv4"
    fi

    if [ -n "$ipv6" ]; then
        echo "DNS (IPv6): $ipv6"
    fi

    if [ -z "$ipv4" ] && [ -z "$ipv6" ]; then
        echo "DNS: Resolved (no IP extracted)"
    fi
else
    echo "DNS: Failed"
fi

if ping -c 1 -W 2 "$url_host" > /dev/null 2>&1; then
    echo "Ping: Reachable"
else
    echo "Ping: Unreachable"
fi

result=$(curl -L -o /dev/null -s -w "%{http_code} %{time_total}" --max-time 5 "$url")

http_status=$(echo "$result" | awk '{print $1}')
response_time=$(echo "$result" | awk '{print $2}')

if [ -n "$http_status" ]; then
    echo "HTTP Status: $http_status"
    echo "Response Time: ${response_time}s"
else
    echo "HTTP: Failed"
fi

echo "----------------------------------"
