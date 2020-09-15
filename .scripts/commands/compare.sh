#!/bin/sh
#
# compare two files using sha256sum hash and report match/mismatch

check1=$(sha256sum "$1")
hash1=$(printf "%s" "$check1" | awk '{print $1}' )
file1=$(printf "%s" "$check1" | awk '{print $2}' )

check2=$(sha256sum "$2")
hash2=$(printf "%s" "$check2" | awk '{print $1}' )
file2=$(printf "%s" "$check2" | awk '{print $2}' )

figlet sha256
printf "%s\n%s\n" "$check1" "$check2"
if [ "$hash1" = "$hash2" ]; then
    echo "MATCH!" | lolcat
else
    echo "files differ." | lolcat
    ls -lH1h "$file1"
    ls -lH1h "$file2"
fi
