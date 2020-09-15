#!/bin/bash
# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/Documents/git_repos/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/Documents/git_repos/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/Documents/git_repos/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/Documents/git_repos/fzf/shell/key-bindings.bash"
