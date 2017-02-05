#Termux URL shortening script. Copy this into /data/data/com.termux/files/usr/bin and chmod +x it. Then launch as `shorten <URL>` to get a short URL. 
set -e 
api="https://domain/yourls-api.php?signature=&action=shorturl&format=simply&url=${1}"
url=$(curl "$api") || exit 
termux-clipboard-set "$url" 
termux-toast "URL copied to clipboard" 
termux-notification --title Shorten --content Success --button1 copy --button1-action "termux-clipboard-set ${url} && termux-toast -s \"URL copied to clipboard\"" --button2 "open in browser" --button2-action "termux-open-url ${url}"
echo "$url" >> shorturllist.log # This file will be stored in $HOME