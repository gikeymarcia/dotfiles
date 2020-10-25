#!/bin/bash
# Mikey Garcia, @gikeymarcia
# make tarball with everything I need to setup a google compute engine machine
# dependencies:

cd ~ || exit 1
tarball="mikey-ball.tar.gz"

peek_file () {
    printf "\n~~%s:\n%s\n" "$(basename "$1")" "$(cat "$1")"
}

# INSTALL CONFIGS
install_config="install-config.sh"
cat > "$HOME/$install_config" << EOL
#!/bin/sh
# install programs
sudo apt install -y vim fzf ranger p7zip-full \
    figlet nmon neofetch ncdu shellcheck tree

appimage() {
    url=\$1
    name=\$(basename \$1)
    path="\$HOME/Documents/debs/\$name"
    curl -L -O "\$url"
    chmod -v +x "\$name"
    mkdir -pv "\$(dirname "\$path" )"
    mv "\$name" "\$path"
    sudo ln -v -f "\$path" "/usr/bin/\$2"
}
# tmux -- using appimage
figlet -f slant tmux
tmux_appimage=https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
appimage \$tmux_appimage tmux

# neovim -- using appimage
figlet -f slant nvim
nvim_appimage=https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
appimage \$nvim_appimage nvim

# install neovim plugins
# TODO install coc-extensions: coc-python
# and make the line below work (seems broken)
nvim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "PlugUpdate" -c "qa"

# https://linuxconfig.org/how-to-test-for-installed-package-using-shell-script-on-ubuntu-and-debian
# fd -- installing from deb
figlet -f slant fd
fd_dl="https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-musl_8.1.1_amd64.deb"
fd_path="\$HOME/Documents/debs/\$(basename "\$fd_dl" )"
[ ! -f "\$fd_path" ] && curl "\$fd_dl" --create-dirs -L -o "\$fd_path"
[ ! -x "\$fd_path" ] && chmod +x "\$fd_path"
sudo apt install "\$fd_path"

# bat -- installing from deb
figlet -f slant bat
bat_dl="https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb"
bat_path="\$HOME/Documents/debs/\$(basename "\$bat_dl" )"
[ ! -f "\$bat_path" ] && curl "\$bat_dl" --create-dirs -L -o "\$bat_path"
[ ! -x "\$bat_path" ] && chmod +x "\$bat_path"
sudo apt install "\$bat_path"

# set LA local time
sudo timedatectl set-timezone America/Los_Angeles
EOL
chmod -v +x  "$HOME/$install_config"
peek_file "$HOME/$install_config"


## useful git repositories
git_repos="git_repos.sh"
cat > "$HOME/$git_repos" << EOL
#!/bin/bash
sources+=("https://github.com/fastai/course-nlp.git               fast-ai-NLP")
sources+=("https://github.com/fastai/course-v3.git                fast-ai-for-coders")
sources+=("https://github.com/fastai/numerical-linear-algebra.git numerical-lin-alg")
sources+=("https://github.com/junegunn/fzf.git                    fzf-git")
sources+=("https://github.com/fastai/fastai1.git                  fastai-v1-docs")
sources+=("https://github.com/fastai/fastai.git                   fastai-v2-docs")

cd ~ || exit
for repo in "\${sources[@]}"; do
    url=\$(printf "%s" "\$repo" | sed -E "s/([^ ]+).*$/\1/g")
    dir=\$(printf "%s" "\$repo" | sed -E "s/.*[ ]+(.*)$/\1/")
    if [ -d "\$dir/.git" ]; then
        echo "\$HOME/\$dir"
        git --git-dir="\$dir/.git" pull
    else
        git clone "\$url" "\$dir"
    fi
done
EOL
chmod +x "$HOME/$git_repos"
peek_file "$git_repos"

# system refresh
returning="returning_to_work.sh"
cat > "$HOME/$returning" << EOL
#!/bin/sh
figlet "open tarball"
# decompress newest tarball
tar xzfv "\$HOME/$tarball"

# install config
figlet "install programs"
"\$HOME/$install_config"

# refresh repos
figlet "pulling git repos"
"\$HOME/$git_repos"

# update programs
figlet "update programs"
sudo apt update -y
apt list --upgradable
sudo apt upgrade -y

# update fastai
figlet "update fastai"
sudo /opt/conda/bin/conda install -c fastai fastai
EOL
chmod -v +x  "$HOME/$returning"
peek_file "$HOME/$returning"


# make google compute platform hacks
google_compute_rc=".bash_gcp"
cat > "$HOME/$google_compute_rc" << EOL
#!/bin/bash
TERM="xterm-256color"
export TERM
TIME="\${BIWhite}\A"
USERatCOMP="\${BYellow}[\${BIRed}\u\${BYellow}@\${BIRed}\h\${BYellow}]"
PROMPT_LOC="\${BYellow}\w\${BIWhite}\\$"
PS1=" \$TIME \${debian_chroot:+(\$debian_chroot)}\${USERatCOMP}\${PROMPT_LOC} \${Color_Off}"
EOL
peek_file "$HOME/$google_compute_rc"

# MAKE TARBALL
tar -czf "$HOME/$tarball" \
    "$install_config" \
    "$git_repos" \
    "$returning" \
    "$google_compute_rc" \
    ".config/nvim/init.vim" \
    ".config/bind/my-bindings" \
    ".kaggle/kaggle.json" \
    ".fzf.bash" \
    ".fzf/completion.bash" \
    ".fzf/key-bindings.bash" \
    ".terminfo/s/screen-256color-italic" \
    ".vimrc" \
    ".tmux.conf" \
    ".bashrc" \
    ".bash_aliases" \
    ".bash_color_codes" \
    ".bash_funcs" \
    ".bash_env" \
    ".bash_profile" \
    ".inputrc" \
    ".profile" \
    ".vim/autoload/plug.vim" \
    ".vim/undo/make-dir.md" \
    ".scripts/tmux/tmux-quick-launcher.sh" \
    ".scripts/commands/bookmark-actions.sh" \
    ".scripts/fzf/bookmark-preview.sh" \
    ".scripts/commands/tree-preview.sh" \
    ".scripts/commands/run-script.sh" \
    ".scripts/commands/jump.sh" \
    ".scripts/commands/delete-history-entry.sh" \
    ".scripts/commands/search.sh" \
    ".scripts/dotfiles/fzf-preview.sh" \
    ".config/bookmarks-dirs.dirs" \
    ".config/dircolors/my.dircolors" \
    ".scripts/sys-info/bookmark-paths.sh" \
    .vim/ftplugin/*.vim \
    .vim/plug-config/*.vim

# list tarball contents
printf "\n%s contents:\n" "$HOME/$tarball"
tar -tvf "$HOME/$tarball"

# remove created files
rm -v \
    "$HOME/$git_repos" \
    "$HOME/$install_config" \
    "$HOME/$google_compute_rc" \
    "$HOME/$returning"

# prompt next actions
printf "\nextract with:\n%s\n" "tar xzfv $(basename "$HOME/$tarball")"
