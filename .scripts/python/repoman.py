#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# manage git repos

from pathlib import Path
from subprocess import run


class GitRepo:
    """Specify git repositories to manage and keep them all up-to-date."""
    base = Path('~/Documents/git_repos')
    dirs = {
        'base': base,
        'dotfiles': Path(base, "dotfiles"),
        'progs': Path(base, 'programs'),
        'decentral': Path(base, 'decentralized-web'),
        'data': Path(base, 'datasets'),
        'libs': Path(base, "libs-FOSS"),
        'ai': Path(base, "AI"),
    }

    def __init__(
            self,
            name: str,
            remote=None,
            basedir=None,
            branch='master',
            select_func=None):
        "Specify repository name, remote_location, and local_path."
        self.name = name
        self.remote = remote
        self.local = self.get_local_dir(basedir)
        self.branch = branch

    def __repr__(self):
        out = (f'{self.branch}\t@\t{self.remote}\n local\t@\t{self.local}')
        out = (f'{self.name:18s}@\t{self.local} - {self.branch}')
        return out

    def get_local_dir(self, abbrev):
        "Figure our full path to place repositories into."
        if abbrev in GitRepo.dirs.keys():
            stem = Path.expanduser(GitRepo.dirs[abbrev])
            return Path(stem, self.name)
        else:
            stem = Path.expanduser(Path(abbrev))
            return Path(stem, self.name)

    def is_repo(self):
        "Return True/False if directory contains a git repository."
        git = Path(self.local, '.git')
        return Path.is_dir(git)

    def clone(self):
        "Clone repo into desired local location."
        print(" = - " * 4 + str(self.local))
        clone = ['git', 'clone', '--branch',
                 self.branch, self.remote, str(self.local)]
        run(clone)

    def pull(self):
        "Pull latest changes to a repository, stash changes if needed."
        run_opt = {'capture_output': True, 'text': True}
        git = ['git', '-C', str(self.local.absolute())]
        stash = run(git + ['stash'], **run_opt)
        checkout = run(git + ['checkout', self.branch], **run_opt)
        pull = run(git + ['pull'], **run_opt)
        print(" = - " * 4 + str(self.local))
        if stash.returncode != 0:
            print(stash.stdout)
        if checkout.returncode != 0:
            print(checkout.stderr)
        if pull.returncode != 0:
            print(pull.stderr)
        if pull.stdout.strip() == "Already up to date.":
            pass
        else:
            print(pull.stdout)

    def update(self):
        "Clone repository if missing, otherwise pull latest."
        if self.is_repo():
            self.pull()
        else:
            self.clone()


repos = {
    # BASE Dir
    "Collector": {
        'remote': "git@github.com:gikeymarcia/Collector.git",
        'basedir': 'base'},
    "tldr-fork": {
        'remote': "git@github.com:gikeymarcia/tldr.git",
        'basedir': 'base'},
    # AI Dir
    "pandas-book": {
        'remote': "https://github.com/wesm/pydata-book.git",
        'basedir': 'ai',
        'branch': '2nd-edition'},
    "datasci-handbook": {
        'remote': "https://github.com/jakevdp/PythonDataScienceHandbook.git",
        'basedir': 'ai'},
    "fastai-book": {
        'remote': "https://github.com/fastai/fastbook.git",
        'basedir': 'ai'},
    "fast-ai-docs": {
        'remote': "https://github.com/fastai/docs.git",
        'basedir': 'ai'},
    "fast-ai": {
        'remote': "https://github.com/fastai/fastai.git",
        'basedir': 'ai'},
    # DOTFILES Dir
    "learn-linux-tv--ansible-personal": {
        'remote': "https://github.com/LearnLinuxTV/personal_ansible_desktop_configs.git",
        'branch': "main",
        'basedir': 'dotfiles'},
    "dt": {
        'remote': "https://gitlab.com/dwt1/dotfiles.git",
        'basedir': 'dotfiles'},
    "lukesmith": {
        'remote': "https://github.com/LukeSmithxyz/voidrice.git",
        'basedir': 'dotfiles'},
    "chrisatmachine": {
        'remote': "https://github.com/ChristianChiarulli/archrice.git",
        'basedir': 'dotfiles'},
    "thoughtbox": {
        'remote': "https://github.com/thoughtbot/dotfiles.git",
        'basedir': 'dotfiles'},
    "dt-wallpaper": {
        'remote': "https://gitlab.com/dwt1/wallpapers.git",
        'basedir': 'dotfiles'},
    "qtile-samples": {
        'remote': "https://github.com/qtile/qtile-examples.git",
        'basedir': 'dotfiles'},
    # DATA Dir
    "COVID": {
        'remote': "https://github.com/CSSEGISandData/COVID-19.git",
        'basedir': 'data'},
    "NYT-Election": {
        'remote': "https://github.com/alex/nyt-2020-election-scraper.git",
        'basedir': 'data'},
    "UnixPornSurvey": {
        'remote': "git@github.com:unixporn/surveys.git",
        'basedir': 'data'},
    # DECENTRALIZED Dir
    "radicle": {
        'remote': "https://github.com/radicle-dev/radicle-upstream.git",
        'basedir': 'decentral'},
    "ipfs": {
        'remote': "https://github.com/ipfs/ipfs.git",
        'basedir': 'decentral'},
    "writefreely": {
        'remote': "https://github.com/writeas/writefreely.git",
        'basedir': 'decentral'},
    "zeronet": {
        'remote': "https://github.com/HelloZeroNet/ZeroNet.git",
        'basedir': 'decentral'},
    # PROGRAMS Dir
    "ansible": {
        'remote': "https://github.com/ansible/ansible.git",
        'basedir': 'progs',
        'branch': "stable-2.9"},
    "awesomewm": {
        'remote': "https://github.com/awesomeWM/awesome",
        'basedir': 'progs',
        'branch': "master"},
    "buku": {
        'remote': "https://github.com/jarun/buku.git",
        'basedir': 'progs',
    },
    "dragon": {
        'remote': "https://github.com/mwh/dragon.git",
        'basedir': 'progs',
    },
    "tmux": {
        'remote': "https://github.com/tmux/tmux.git",
        'basedir': 'progs'},
    "discourse": {
        'remote': "git@github.com:discourse/discourse.git",
        'basedir': 'progs'},
    "lemmy": {
        'remote': "git@github.com:LemmyNet/lemmy.git",
        'basedir': 'progs'},
    "clipnotify": {
        'remote': "https://github.com/cdown/clipnotify.git",
        'basedir': 'progs'},
    "clipmenu": {
        'remote': "https://github.com/cdown/clipmenu.git",
        'basedir': 'progs'},
    "picom": {
        'remote': "https://github.com/yshui/picom",
        'basedir': 'progs',
        'branch': 'stable/8'},
    "qtile": {
        'remote': "git://github.com/qtile/qtile.git",
        'basedir': 'progs'},
    "markdownhere": {
        'remote': "https://github.com/adam-p/markdown-here.git",
        'basedir': 'progs'},
    "watson": {
        'remote': "https://github.com/TailorDev/Watson.git",
        'basedir': 'progs'},
    "iterfzf": {
        'remote': "https://github.com/dahlia/iterfzf.git",
        'basedir': 'progs'},
    "nvcode": {
        'remote': "https://github.com/ChristianChiarulli/nvim.git",
        'basedir': 'progs'},
    "firenvim": {
        'remote': "https://github.com/glacambre/firenvim.git",
        'basedir': 'progs'},
    "youtube-dl": {
        'remote': "https://github.com/ytdl-org/youtube-dl.git",
        'basedir': 'progs'},
    "fzf": {
        'remote': "https://github.com/junegunn/fzf.git",
        'basedir': 'progs'},
    "peco": {
        'remote': "https://github.com/peco/peco.git",
        'basedir': 'progs'},
    "polybar": {
        'remote': "git@github.com:polybar/polybar.git",
        'basedir': 'progs'},
    "pulseaudio-ctl": {
        'remote': "https://github.com/graysky2/pulseaudio-ctl.git",
        'basedir': 'progs'},
    "pasystray": {
        'remote': "https://github.com/christophgysin/pasystray.git",
        'basedir': 'progs'},
    "screenkey": {
        'remote': "https://gitlab.com/screenkey/screenkey.git",
        'basedir': 'progs'},
    # LIBS Dir
    "reverse-geocoder": {
        'remote': "git@github.com:thampiman/reverse-geocoder.git",
        'basedir': 'libs'},
    # MISC Dir
    "battery-widget": {
        'remote': "https://github.com/deficient/battery-widget.git",
        'basedir': '~/.config/awesome'},
}

if __name__ == "__main__":
    tracked_repos = [GitRepo(r, **repos[r]) for r in repos]
    for r in tracked_repos:
        r.update()
