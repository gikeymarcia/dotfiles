#!/bin/bash
# Mikey Garcia, @gikeymarcia
# collect the files needed to bootstrap a new system
# dependencies: figlet ~/.scripts/dotfiles/config.sh

seed="$HOME/MikeyOS--seed"
ssh="$HOME/.ssh"

[ -d "$seed" ] && sudo rm -r "$seed"
mkdir -p "$seed/.ssh"
mkdir -p "$seed/dotfiles-config"

# make copies of ~/.ssh
cp -r   "$ssh"                  "$seed/full-ssh"
cp      "$ssh/config"           "$seed/.ssh"
cp      "$ssh/authorized_keys"  "$seed/.ssh"
cp      "$ssh/gitlab"           "$seed/.ssh"
# shellcheck disable=SC2086
cp      $ssh/*.pub              "$seed/.ssh"

# get documentation
cp "$HOME/.notes/gikeyOS/installing-dotfiles.md" "$seed/00--README.md"
markdown-preview.sh "$seed/00--README.md" "$seed/00--README.html"

# bootstrap scripts
setup="$HOME/.scripts/setup"
cp "$setup/import-dotfiles.sh"              "$seed/01--import-dotfiles.sh"
cp "$HOME/.scripts/system/make-MikeyOS.sh"  "$seed/02--make-MikeyOS.sh"
cp "$DOTFILES/config"                       "$seed/dotfiles-config"
# make and place tarball
echo "making tarball..."
~/.scripts/dotfiles/config.sh tar > /dev/null
mv ~/con-ball.tar.gz                        "$seed/dotfiles.tar.gz"

# display creation
banner () {
    msg=$1
    font="$HOME/.config/figlet/speed.flf"
    [ ! -r "$font" ] && font="big"
    if [ -x "$(which lolcat)" ]; then
        figlet -f "$font" "$msg" | lolcat
    else
        figlet -f "$font" "$msg"
    fi
}
banner "go time!"
tree -L 2 -p -a -c "$seed"
du -sh "$seed"
printf "\n -  -  -  -  -  -  -  -  -  - \n"
printf "\ncopy to import dotfiles...\n\n%s\n\n" "$seed"
