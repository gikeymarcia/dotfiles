#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install conquer-of-completion extensions for nvim
# dependencies:
# https://www.chrisatmachine.com/Neovim/04-vim-coc/

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -pv ~/.config/coc/extensions
cd ~/.config/coc/extensions
[ ! -f package.json ] && echo '{"dependencies":{}}' > package.json

# Change extension names to the extensions you need
nvim -c "CocInstall coc-json coc-python coc-yank coc-vimlsp coc-snippets"
