#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
"""
Script to install all MikeyOS programs

Package lists are all flat txt files
~/.config/apt/ppa-list        ppas to install (e.g., neovim-ppa/stable)
~/.config/apt/install-list    apt-managed packages
~/.config/apt/remove-list     apt-managed packages to remove
~/.config/apt/purge-list      apt-managed packages to purge
~/.config/apt/npm-list        npm packages (installed globally)
~/.config/apt/pip-list        pip3 packages (installed locally)
~/.config/apt/rust-list       rust packages to build from source
~/.config/apt/snap-list       snap packages
~/.config/apt/snap-classic    snap --classic installed packages
"""

import os
import re
import glob
from subprocess import run
from sys import argv


def read_app_list(path: str) -> []:
    def no_comment(app: str) -> str:
        """Strip trailing inline comments."""
        return app if '#' not in app else app.split('#')[0].strip()
    path = os.path.expanduser(path)
    with open(path, "r") as app_list:
        progs = app_list.read().strip().split('\n')
        return [no_comment(app) for app in progs if app[0] != '#']


def install_ppas(ppa_list_path: str) -> None:
    """Takes a path listing PPAs and installs them if missing from system."""
    sources = ["/etc/apt/sources.list"] + \
        glob.glob("/etc/apt/sources.list.d/*.list")

    def missing(ppa_name: str = "neovim-ppa/stable") -> bool:
        pattern = f'^deb .*{ppa_name}'
        for s in sources:
            with open(s, 'r') as src:
                for line in src.read().strip().split('\n'):
                    if re.match(pattern, line) is not None:
                        return False
        else:
            return True

    ppa_list = read_app_list(ppa_list_path)
    to_install = [ppa for ppa in ppa_list if missing(ppa)]
    for ppa in ppa_list:
        if ppa in to_install:
            print(f"Installing ppa:\t{ppa}")
            run(['sudo', 'add-apt-repository', f'ppa:{ppa}'])
        else:
            print(f"Already installed:\t{ppa}")


def apt_fresh():
    for action in ['update', 'autoremove', 'autoclean']:
        run(['sudo', 'apt', action, '-y'])


def apt_do(app_list, action='install'):
    if action == 'install':
        apt_fresh()
    for app in read_app_list(app_list):
        run(['sudo', 'apt', action, '-y', app])


def pip_do(app_list, action='install'):
    packages = read_app_list(app_list)
    run(['pip3', 'install', '--upgrade'] + packages)
    run(['pip3', 'list'])


def cargo_do(app_list, action='install'):
    packages = read_app_list(app_list)
    run(['cargo', 'install'] + packages)


def npm_do(app_list, action='install'):
    packages = read_app_list(app_list)
    run(['sudo', 'npm', 'install', '-g'] + packages)


def snap_do(app_list, action='install', classic=False):
    packages = read_app_list(app_list)
    if action == 'install':
        if classic:
            for app in packages:
                run(['sudo', 'snap', action, '--classic', app])
        else:
            run(['sudo', 'snap', action] + packages)
    elif action == 'refresh':
        run(['sudo', 'snap', 'refresh'])


if __name__ == "__main__":
    # LISTS
    ppa_file = '~/.config/apt/ppa-list'  # ppa
    apt_install = '~/.config/apt/install-list'  # apt
    apt_remove = '~/.config/apt/remove-list'  # apt
    apt_purge = '~/.config/apt/purge-list'  # apt
    npm_install = '~/.config/apt/npm-list'  # npm
    pip_install = '~/.config/apt/pip-list'  # pip
    rust_install = '~/.config/apt/rust-list'  # rust utils
    snap_install = '~/.config/apt/snap-list'  # snap
    snap_classic = '~/.config/apt/snap-classic'  # snap --classic

    def pip_action():
        pip_do(pip_install)

    def apt_action():
        install_ppas(ppa_file)
        apt_do(apt_install, 'install')
        apt_do(apt_remove, 'remove')
        apt_do(apt_purge, 'purge')

    def npm_action():
        npm_do(npm_install, 'install')

    def snap_action():
        snap_do(snap_install, 'install')
        snap_do(snap_classic, 'install', classic=True)
        snap_do(snap_install, 'refresh')

    def rust_action():
        cargo_do(rust_install)

    def vim_action():
        run([os.path.expanduser('~/.scripts/system/vim-fresh.sh')])

    actions = {
        'pip': pip_action,
        'apt': apt_action,
        'npm': npm_action,
        'snap': snap_action,
        'rust': rust_action,
        'vim': vim_action,
    }

    try:
        target = argv[1]
        actions[target]()
    except (KeyError, IndexError):
        print('Running everything...')
        for source, runcmd in actions.items():
            print(f'\nUpdating {source}...')
            runcmd()
        print("\n\nTo run a subset, pass a command.")
        print('commands:\t{}'.format(list(actions)))
