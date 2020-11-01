#!/bin/bash
# Mikey Garcia, @gikeymarcia
# keep all of the git repos I care about up to date on my local machine
# dependencies: git

date
git_dir=~/Documents/git_repos
progs="$git_dir/programs"
ai="$git_dir/AI"
dotfiles="$git_dir/dotfiles"

# repositories+=("local_folder                       remote_repository")
# mine
repositories+=("$git_dir/Collector                   git@github.com:gikeymarcia/Collector.git")
repositories+=("$git_dir/tldr-fork                   git@github.com:gikeymarcia/tldr.git")
# ai repos
repositories+=("$ai/fastai-book                      https://github.com/fastai/fastbook.git")
repositories+=("$ai/fast-ai-docs                     https://github.com/fastai/docs.git")
repositories+=("$ai/fast-ai                          https://github.com/fastai/fastai.git")
# dotfiles
repositories+=("$dotfiles/dt                         https://gitlab.com/dwt1/dotfiles.git")
repositories+=("$dotfiles/lukesmith                  https://github.com/LukeSmithxyz/voidrice.git")
repositories+=("$dotfiles/chrisatmachine             https://github.com/ChristianChiarulli/archrice.git")
repositories+=("$dotfiles/thoughtbox                 https://github.com/thoughtbot/dotfiles.git")
repositories+=("$dotfiles/dt-wallpaper               https://gitlab.com/dwt1/wallpapers.git")
repositories+=("$dotfiles/qtile-samples              https://github.com/qtile/qtile-examples.git")
# programs
repositories+=("$progs/clipnotify                    https://github.com/cdown/clipnotify.git")
repositories+=("$progs/clipmenu                      https://github.com/cdown/clipmenu.git")
repositories+=("$progs/picom                         https://github.com/yshui/picom")
repositories+=("$progs/qtile                         git://github.com/qtile/qtile.git")
repositories+=("$progs/nvcode                        https://github.com/ChristianChiarulli/nvim.git")
repositories+=("$progs/firenvim                      https://github.com/glacambre/firenvim.git")
repositories+=("$progs/watson                        https://github.com/TailorDev/Watson.git")
#repositories+=("$progs/youtube-dl                    https://github.com/ytdl-org/youtube-dl.git")
repositories+=("$progs/fzf                           https://github.com/junegunn/fzf.git")
repositories+=("$progs/polybar                       git@github.com:polybar/polybar.git")
repositories+=("$progs/pulseaudio-ctl                https://github.com/graysky2/pulseaudio-ctl.git")
repositories+=("$progs/pasystray                     https://github.com/christophgysin/pasystray.git")
repositories+=("$progs/screenkey                     https://gitlab.com/screenkey/screenkey.git")
repositories+=("$HOME/.dynamic-colors                https://github.com/sos4nt/dynamic-colors.git")
repositories+=("$HOME/.config/awesome/battery-widget https://github.com/deficient/battery-widget.git")

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
