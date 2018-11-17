# Termux image/file upload script. Save as $HOME/bin/termux-file-editor, apply chmod +x to it and then simply share your files with Termux.
set -e

# Upload
notid=1
domain="https://domain"

termux-toast -s "Uploading..."
echo "$1"
var=$(curl -# --http1.1 -H "Accept: application/json" -H "Linx-Randomize: yes" -T "$1" "$domain") # This does a PUT upload to a linx.li instance. Change the curl to work with your own server.

# Prepare the notification
url=$(echo "$var" | jq -r '.url') || $(termux-notification -c Upload -t FAILED && exit) # This assumes that the response returns a json with an url parameter. Change this to parse your server's response.
termux-notification --title Upload --content "Success: ${url}" --button1 copy --button1-action "termux-clipboard-set ${url} && termux-toast -s \"URL copied to clipboard\"" --button2 delete --button2-action "termux-notification --id ${notid} --title Upload --content DELETING... && curl -H \"Linx-Delete-Key: xxx\" -X DELETE ${url} && termux-notification --id ${notid} --title Upload --content DELETED" --button3 "open in browser" --button3-action "termux-open-url ${url}" --id "$notid" # The DELETE button sends a DELETE request to the server. You might need to fix that curl request (or even remove it) for your own setup.
termux-clipboard-set "$url"
termux-toast -s "URL copied to clipboard."

echo "$url" >> filelist.log # This file will be stored in $HOME

# Delete the file from termux cache ($HOME/downloads)
rm "$1"
