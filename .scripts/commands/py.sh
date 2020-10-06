#!/bin/bash
# Mikey Garcia, @gikeymarcia
# launch nvim with python script in buffer and autocommand set to run the
# script each time the file is written
# dependencies: python bat
# environment: $EDITOR

# if file exists and > 0 size
if [ -s "$1" ]; then
    filename=$1
elif [ -z "$1" ]; then
    scratchdir=/tmp/py-scratch/
    [ ! -d "$scratchdir" ] && mkdir -pv "$scratchdir"
    filename="$(mktemp --tmpdir="$scratchdir" --suffix=.py)"
elif [ -n "$1" ]; then
    filename="./$1"
fi

# make, executable, or populate file (as needed)
[ ! -f "$filename" ] && touch "$filename"
[ ! -x "$filename" ] && chmod u+x "$filename"
[ ! -s "$filename" ] && cat > "$filename" << EOF
#!/usr/bin/env python
x =
print(x)
EOF

echo "filename: $filename"
$EDITOR -c "autocmd BufWritePost *.py :!python3 %" "$filename"
bat "$filename"
