#!/bin/bash

set -e

# replace waf configurations

if [[ $UrlDeny ]]; then
    if [[ $UrlDeny == "on" ]]; then
        sed -i "s#^UrlDeny =.*#UrlDeny = \"on\"#g" /usr/local/nginx/conf/waf/config.lua
    else
        sed -i "s#^UrlDeny =.*#UrlDeny = \"off\"#g" /usr/local/nginx/conf/waf/config.lua
    fi
fi

if [[ $CCDeny ]]; then
    if [[ $CCDeny == "on" ]]; then
        sed -i "s#^CCDeny =.*#CCDeny = \"on\"#g" /usr/local/nginx/conf/waf/config.lua
    else
        sed -i "s#^CCDeny =.*#CCDeny = \"off\"#g" /usr/local/nginx/conf/waf/config.lua
    fi
fi

if [[ $CCrate ]]; then
    sed -i "s#^CCrate =.*#CCrate = \"$CCrate\"#g" /usr/local/nginx/conf/waf/config.lua
fi

if [[ $CookieMatch ]]; then
    if [[ $CookieMatch == "on" ]]; then
        sed -i "s#^CookieMatch =.*#CookieMatch = \"on\"#g" /usr/local/nginx/conf/waf/config.lua
    else
        sed -i "s#^CookieMatch =.*#CookieMatch = \"off\"#g" /usr/local/nginx/conf/waf/config.lua
    fi
fi

if [[ $PostMatch ]]; then
    if [[ PostMatch == "on" ]]; then
        sed -i "s#^postMatch =.*#postMatch = \"on\"#g" /usr/local/nginx/conf/waf/config.lua
    else
        sed -i "s#^postMatch =.*#postMatch = \"off\"#g" /usr/local/nginx/conf/waf/config.lua
    fi
fi

if [[ $ReplayDeny ]]; then
    if [[ $ReplayDeny == "on" ]]; then
        sed -i "s#^ReplayDeny =.*#ReplayDeny = \"on\"#g" /usr/local/nginx/conf/waf/config.lua
    else
        sed -i "s#^ReplayDeny =.*#ReplayDeny = \"off\"#g" /usr/local/nginx/conf/waf/config.lua
    fi
fi

if [[ $IPWhitelist ]]; then
    sed -i "s#^ipWhitelist =.*#ipWhitelist = { $IPWhitelist }#g" /usr/local/nginx/conf/waf/config.lua
fi

if [[ $IPBlocklist ]]; then
    sed -i "s#^ipBlocklist =.*#ipBlocklist = { $IPBlocklist }#g" /usr/local/nginx/conf/waf/config.lua
fi

if [[ $UrlWhitelist ]]; then
    sed -i "s#^urlWhitelist =.*#urlWhitelist = { $UrlWhitelist }#g" /usr/local/nginx/conf/waf/config.lua
fi

if [[ $UrlPrefixBlocklist ]]; then
    sed -i "s#^urlPrefixBlocklist =.*#urlPrefixBlocklist = { $UrlPrefixBlocklist }#g" /usr/local/nginx/conf/waf/config.lua
fi

exec "$@"