#!/bin/bash
# Mikey Garcia, @gikeymarcia
# keep vim/nvim and plugins up-to-date

printf "\n-- upgrading vim-plug --\n"
nvim --headless +PlugUpgrade +PlugClean +qa

printf "\n-- updating vim plugins--\n"
nvim --headless +PlugInstall +qa

printf "\n-- updating conquer-of-completion plugins --\n"
nvim --headless +CocUpdate +CocRebuild +qa

printf "\n-- vim is fresh! %s --\n" "$(date)"
