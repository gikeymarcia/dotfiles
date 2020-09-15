#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install vim-binding plugin for jupyter notebooks

ext_dir="$(jupyter --data-dir)/nbextensions"
mkdir -pv "$ext_dir" && cd "$ext_dir" || exit 1
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
# activate extension
jupyter nbextension enable vim_binding/vim_binding
jupyter serverextension list
