# dotfiles @gikeymarcia

- **Built on:** Ubuntu 20.10
- **Window Managers:** Qtile, i3, awesome
- **Key Programs:** `nvim tmux fzf fd rofi dmenu git pandoc ranger alacritty`

Welcome to my public dotfile configuration. Here you'll find a treasure trove of ideas and implemented solutions for making a CLI-based Linux experience easier and more powerful. Wherever possible I've tried to ditch the mouse and make simple scripts which can be easily customized with your inputs to do common tasks. These are a continual work-in-progress but I've tried my best to clearly document script dependencies so you can more easily make use of these tools.

My philosophy is to prefer variables over hard-coded paths because it is easier to tweak one or two values to match your configs (or add an environment variable) and be able to use what I've worked on.

### Most Useful Scripts

* [`dotfiles.py`][py-dot]
    + Perform common [dotfile][atlassian dotfiles] actions and easily open file(s) in an editor
    + set `$DOTFILES`{.bash} bare repo environment variable and try `dotfiles.py help`
    + [Aliased to][alias] `d.`
* [`repoman.py`][repoman]
    + keep up-to-date local copies of all the git repositories I am interested in
* [`install-all-programs.py`][install all]
    + Install all packages and ppas in my [install lists][install lists]
* [`tmux-quick-launcher.sh`][tquick]
    + Interactively create, switch, and attach to tmux sessions
    + Aliased to `t` in my [`~/.bash_aliases`][alias]
* [`bookmark-actions.sh`][bookmarks]
    + Read from a [list of bookmarked folders][bm] and `cd` to selection
    + [Aliased to][alias] `bm`
* [`fzf-preview.py`][fzf prev]
    + Intelligently generate a preview for fzf searching
* [`search.sh`][srch]
    + fzf search a directory recursively
    + [Aliased to][alias] `srch`
+ [`build-picom.sh`][build picom]
    + build and install [picom compositor][picom] from git source
* [`py-code.py`][py-code]
    + Split-pane tmux Python REPL. _Uses vim autocmd if not in tmux._
* [`live-code.sh`][live-code]
    + Re-run a script and show output on file write
* [`~/.scripts/launchers/*`][launchers]
    + Various quick launchers mostly using dmenu
- [`~/.scripts/gcloud/*`][gcloud]
    + Scripts to automate setup of Google cloud compute machines to feel comfy and familiar to my home command-line environment.

### Main Features and Programs

- Very structured [`~/.bashrc`][bashrc] for understandable and extensible customization.
- [`tmux` configuration][tmux] with vim-like bindings.
- `nvim` with IDE-like configuration and auto-completion.
- [`qtile`][qtile cfg], [`i3`][i3 cfg], and [`awesome`][awesome] window managers with VI-esque configurations.

### Fork and Feedback

In the spirit of open-source, feel free to fork an play with any of what's here. If you find ways you can improve or expand functionality I'm always interested to see what you've done. I hope these files are useful to you in your computing journey.

If you're new to managing dotfiles using git I highly recommend you checkout [this article][atlassian dotfiles] for the rundown.

_date modified: 2021-03-01_


[atlassian dotfiles]: <https://www.atlassian.com/git/tutorials/dotfiles>
"The best way to store your dotfiles: A bare Git repository"
[tquick]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/tmux/tmux-quick-launcher.sh>
"Quickly create and choose tmux sessions."
[launchers]: <https://github.com/gikeymarcia/dotfiles/tree/master/.scripts/launchers>
"Bash scripts to quickly select and launch applications/documents/sites"
[py-dot]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/python/dotfiles.py>
"Quickly add, edit, status, log, (and more!) git controlled dotfiles."
[bookmarks]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/commands/bookmark-actions.sh>
"Interactively select bookmark location to jump to."
[fzf prev]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/dotfiles/fzf-preview.py>
"Intelligently preview files when filtering with the fzf"
[og dotfiles]: <https://github.com/gikeymarcia/dotfiles/tree/master/.scripts/dotfiles>
"Quickly perform common dotfile actions."
[srch]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/commands/search.sh>
"Interactively find files quickly."
[py-code]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/commands/py-code.py>
"Launch a Python REPL with either Tmux split-pane preview or vim autocmd"
[live-code]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/commands/live-code.sh>
"Turn a terminal window into a REPL-on-write preview of scripts."
[bashrc]: <https://github.com/gikeymarcia/dotfiles/blob/master/.bashrc>
"~/.bashrc"
[gcloud]: <https://github.com/gikeymarcia/dotfiles/tree/master/.scripts/gcloud>
"Scripts to automate setting up google cloud compute machines."
[tmux]: <https://github.com/gikeymarcia/dotfiles/blob/master/.tmux.conf>
"tmux config with vim-like bindings."
[alias]: <https://github.com/gikeymarcia/dotfiles/blob/master/.bash_aliases>
"Bash aliases"
[install all]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/python/install-all-programs.py>
"Install all programs for: apt, pip, snap, npm, cargo"
[install lists]: <https://github.com/gikeymarcia/dotfiles/tree/master/.config/apt>
"Packages, ppas, and snaps OH MY!"
[bm]: <https://github.com/gikeymarcia/dotfiles/blob/master/.config/bookmarks-dirs.dirs>
"bookmark directories"
[awesome]: <https://github.com/gikeymarcia/dotfiles/tree/master/.config/awesome>
"AwesomeWM configuration directory"
[build picom]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/setup/build-picom.sh>
"Build and install picom from source"
[picom]: <https://github.com/yshui/picom>
"A lightweight compositor for X11"
[qtile cfg]: <https://github.com/gikeymarcia/dotfiles/blob/master/.config/qtile/config.py>
"Qtile: a hackable window manager written in Python"
[i3 cfg]: <https://github.com/gikeymarcia/dotfiles/tree/master/.config/i3>
"i3 window manager configuration files"
[repoman]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/python/repoman.py>
"Easily keep a local library of git repos. FOSS FOREVER!!"
