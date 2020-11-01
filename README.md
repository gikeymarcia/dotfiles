# Dotfiles by @gikeymarcia

Welcome to my public dotfile configuration. Here you'll find a treasure trove of
ideas and implemented solutions for making a CLI-based Linux experience easier
and more powerful. Wherever possible I've tried to ditch the mouse and make
simple scripts which can be easily customized with your inputs to do common
tasks. These are a continual work-in-progress but I've tried my best to clearly
document script dependencies so you can more easily make use of these tools.

My general philosophy with these scripts is to prefer variables over hard-coded
paths because it makes it easier for you to tweak one or two values to match
your config (or add an environment variable) and be able to use what I've worked
on.

- **target:** Ubuntu 20.04
- **WMs:** Qtile, i3, awesome
- **Key Programs:** vim, nvim, tmux, fzf, dmenu, alacritty, ranger, pandoc, git
- **Most useful scripts:**
    * `~/.scripts/dotfiles/edit-config-file.sh`
    * `~/.scripts/dotfiles/config.sh`
    * `~/.scripts/tmux/tmux-quick-launcher.sh`
    * `~/.scripts/commands/search.sh`
    * `~/.scripts/commands/live-code.sh`
    * `~/.scripts/commands/bookmark-actions.sh`
    * `~/.scripts/launchers/*`

### Main Features and Programs

- **`tmux`** configuration with vim-like bindings
- **`nvim`** IDE-like configuration with autocompletion
- **`qtile`**, **`i3`**, and **`awesome`** window manager configs
- **`~/.scripts/dotfiles`** helper scripts to simplify dotfile management
- very structured `~/.bashrc` for understandable and extensible customization
- various scripts to automate setting up google cloud compute machines to feel
comfy and familiar to my personal configs. see `~/.scripts/gcloud`

### Fork and Feedback

In the spirit of open-source, feel free to fork an play with any of what's here.
If you find ways you can improve or expand functionality I'm always interested
to see what you've done. I hope these files are useful to you in your computing
journey. _~ Mikey_

_date modified: 2020-11-01_
