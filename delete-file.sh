# Termux image/file delete script. Copy this into /data/data/com.termux/files/usr/bin and chmod +x it. Then launch as `delete-file <URL>` to send a DELETE request to a specific URL or simply `delete-file` to use the last entry in $HOME/filelist.log. 
set -e 
url=""

if [[ $# -eq 0 ]] ; then
    # I originally wanted to build a pretty UI to select a file to delete but... Laziness :(
    url=$(grep "." "$HOME/filelist.log" | tail -1) || exit 
else
    url="$1" 
fi 

curl -H "Linx-Delete-Key: xxx" -X DELETE ${url}
exit