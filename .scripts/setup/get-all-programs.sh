#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install packages, remove/purge junk, pip/snap/cargo
# dependencies:


# shellcheck disable=SC2046
get_list () {
    # remove lines beginning with `#` and trim endline comments
    sed -E "/^#.*$/d;s/#.*//;s/[ ]+$//" "$1" | tr '\n' ' '
}

apt_path=~/.config/apt

# add ppas
# https://askubuntu.com/a/561628
while read -r ppa; do
    src_list=/etc/apt/sources.list
    src_list_d=/etc/apt/sources.list.d
    if ! grep -q "^deb .*$ppa" $src_list $src_list_d/* ; then
        printf "installing ppa...\t%s\n" "$ppa"
        install_ppa="sudo add-apt-repository ppa:$ppa"
        printf "$  %s\n\n" "$install_ppa"
        $install_ppa
    else
        printf "already installed \t%s\n" "$ppa"
    fi
done < <(get_list "$apt_path/ppa-list" | tr " " "\n" )

# apt installs
sudo apt install -y $( get_list "$apt_path/install-list"        )
#sudo apt install -y $( get_list "$apt_path/groups/jupyter"      )
# apt remove
sudo apt purge   -y $( get_list "$apt_path/purge-list"          )
sudo apt remove  -y $( get_list "$apt_path/remove-list"         )

# other sources
pip3 install        $( get_list "$apt_path/pip-list"   )
sudo snap install   $( get_list "$apt_path/snap-install-list"   )
cargo install       $( get_list "$apt_path/cargo-install-list"  )
