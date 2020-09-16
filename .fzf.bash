#!/bin/bash
# I linked the completion.bash and key-bindings.bash from fzf git repo
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/key-bindings.bash"
