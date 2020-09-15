#!/bin/sh
# Mikey Garcia, @gikeymarcia
# delete tmux buffers
# dependencies:

selected=$(tmux list-buffers | fzf \
    --prompt="which buffer do you want to delete? " |
    sed -E "s/^(buffer[0-9]+):?.*$/\1/")

if [ -n "$selected" ] ; then
    # TODO multiselect (test if it works)
    printf "deleting buffer(s): \n%s\n" "$selected"
    printf "%s" "$selected" | xargs -I _ tmux delete-buffer -b _
else
    echo "selection cancelled."
fi
#tmux list-buffers | fzf | sed -E "s/^(buffer[0-9]+):?.*$/\1/"

# tmux  delete-buffer [-b buffer-name]
#       (alias: deleteb)
#       Delete the buffer named buffer-name, or the most recently added automati‐
#       cally named buffer if not specified.
