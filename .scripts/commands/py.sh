#!/bin/bash
# Mikey Garcia, @gikeymarcia
# "autocmd BufWritePost *.py :!python3 %"

if [ -s "$1" ]; then
    filename=$1
elif [ -z "$1" ]; then
    filename="$(mktemp --suffix=.py)"
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
