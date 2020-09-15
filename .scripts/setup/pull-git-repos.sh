#!/bin/bash
# Mikey Garcia, @gikeymarcia
# keep all of the git repos I care about up to date on my local machine
# dependencies: git

date
git_dir=~/Documents/git_repos

# repositories+=("local_folder                       remote_repository")
# mine
repositories+=("$git_dir/Collector                   git@github.com:gikeymarcia/Collector.git")
repositories+=("$git_dir/tldr-fork                   git@github.com:gikeymarcia/tldr.git")
# ai repos
repositories+=("$git_dir/fastai-book                 https://github.com/fastai/fastbook.git")
repositories+=("$git_dir/fast-ai-docs                https://github.com/fastai/docs.git")
repositories+=("$git_dir/fast-ai                     https://github.com/fastai/fastai.git")
# dotfiles
repositories+=("$git_dir/dotfiles-dt                 https://gitlab.com/dwt1/dotfiles.git")
repositories+=("$git_dir/dotfiles-lukesmith          https://github.com/LukeSmithxyz/voidrice.git")
repositories+=("$git_dir/dotfiles-chrisatmachine     https://github.com/ChristianChiarulli/archrice.git")
repositories+=("$git_dir/nvcode                      https://github.com/ChristianChiarulli/nvim.git")
# programs
repositories+=("$git_dir/clipnotify                  https://github.com/cdown/clipnotify.git")
repositories+=("$git_dir/clipmenu                    https://github.com/cdown/clipmenu.git")
repositories+=("$git_dir/picom                       https://github.com/yshui/picom")
repositories+=("$git_dir/qtile                       git://github.com/qtile/qtile.git")
repositories+=("$git_dir/st                          https://git.suckless.org/st")
repositories+=("$git_dir/youtube-dl                  https://github.com/ytdl-org/youtube-dl.git")
repositories+=("$git_dir/fzf                         https://github.com/junegunn/fzf.git")
repositories+=("$git_dir/pulseaudio-ctl              https://github.com/graysky2/pulseaudio-ctl.git")
repositories+=("$git_dir/pasystray                   https://github.com/christophgysin/pasystray.git")
repositories+=("$git_dir/screenkey                   https://gitlab.com/screenkey/screenkey.git")
repositories+=("$HOME/.dynamic-colors                https://github.com/sos4nt/dynamic-colors.git")
repositories+=("$HOME/.config/awesome/battery-widget https://github.com/deficient/battery-widget.git")
# misc
repositories+=("$git_dir/dt-wallpaper                https://gitlab.com/dwt1/wallpapers.git")

for repo in "${repositories[@]}"; do
    url=$(echo "$repo" | awk '{print $2}')
    repo_dir=$(echo "$repo" | awk '{print $1}')
    printf "\n = - = - = \n\n"
    echo "$repo_dir"
    if [ ! -d "$repo_dir/.git" ]; then
        git clone "$url" "$repo_dir"
    else
        cd "$repo_dir" || exit
        git stash
        git checkout master
        git pull
    fi
done
