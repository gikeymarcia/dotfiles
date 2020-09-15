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
npm install coc-json coc-sh coc-python coc-yank coc-yaml coc-snippets \
    --ignore-scripts --no-bin-links --no-package-lock --only=prod
