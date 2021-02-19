#!/bin/sh
# Mikey Garcia, @gikeymarcia
# install my dotfiles from gitlab
# dependencies: git $gitlab_repo
# https://www.atlassian.com/git/tutorials/dotfiles

# setup required programs, variables, and shortcuts
[ ! -x "$(which git)" ] && sudo apt install -y git
DOTFILES="$HOME/.config/dotfiles"
gitlab_repo="git@gitlab.com:gikeymarcia/dotfiles.git"
config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"
my_branch=laptop


# only import if $DOTFILES is missing
if [ ! -d "$DOTFILES" ]; then
    mkdir -pv "$DOTFILES"
    git clone --bare "$gitlab_repo" "$DOTFILES"
    $config config --local status.showUntrackedFiles no
    # backup any files which would be overwritten
    cd ~ || exit 1
    mkdir -p ~/.config-backup && \
        $config checkout "$my_branch" 2>&1 | grep -E "\s+\." |
        awk '{print $1}' | xargs -I {} mv -v {} "$HOME/.config-backup/"{}
    $config stash
    $config checkout $my_branch
    echo "dotfile import complete. Conflicting files moved to '~/.config-backup/'"
    printf "\n\n - - - - - - - - \n%s\n" "open a new shell or 'source ~/.bashrc' to see changes"
    echo "If that fails. Try a reboot."
else
    echo "directory already exists at '$DOTFILES'"
    echo "move that directory before importing"
fi

# view $DOTFILES status
$config branch -a
$config status
