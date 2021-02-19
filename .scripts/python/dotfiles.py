#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# dependencies: git xclip
# pip-dependencies: iterfzf
# environment: $DOTFILES variable which points to your `--bare` dotfiles repo
import os
import sys
from sys import argv
from sys import exit as sys_exit
from iterfzf import iterfzf
import subprocess as sp
from pathlib import Path
from shutil import which
# from mikey import inspect as see
# TODO https://github.com/google/python-fire make CLI d(dot)
# Bash completion!


class Dotfiles:
    """
    Access, modify, and quickly get information about files in a git repo.
    Fuctionality importable with `from dotfiles import Dotfiles`

    Most Useful Functions:
    self.get_paths() -- return sorted list of tracked files
    self.show_raw() -- return git command to access repo directly
    """

    def __init__(self, git_dir=os.getenv('DOTFILES'), work=str(Path.home())):
        """
        Takes a --bare git-dir + work-tree and returns Dotfile instance.

        Arguments:
        git_dir: location of dotfile repo
        work: work-tree associated with `git-dir`
        """
        self.work_tree = self.verify_dir(work)
        self.git_dir = self.verify_dir(git_dir)
        self.config = ['/usr/bin/git', f'--git-dir={self.git_dir}',
                       f'--work-tree={self.work_tree}']
        self.my_branch = self.get_branch()
        self.status = self.get_status()
        self.editor = os.getenv('EDITOR')
        self.editor = 'nvim' if self.editor is None else self.editor

    def verify_dir(self, dir_string):
        path_obj = Path(os.path.expanduser(dir_string)
                        ) if '~' in dir_string else Path(dir_string)
        if path_obj.is_dir():
            return str(path_obj)
        else:
            # TODO give an option to create the dotfiles repo
            sys_exit(f"'{str(path_obj)}' is not a directory.")

    def get_paths(self, full_path=False) -> list:
        """
        Returns a sorted list of dotfiles tracked by the repo.

        INCLUDES staged changes:
        Upon `git mv old new`: Removes `old` filename, adds `new` filename
        Upon `git rm file`: Removes `file`
        Upon `git add`: Adds new filename

        Argument:
        full_path -- True = abs path; False = relative to work_tree (default)
        """
        repo = self.get_tracked() + self.get_adds()
        rm = self.get_rm()
        relative = sorted([dot for dot in repo if dot not in rm])
        if full_path:
            return [str(Path(self.work_tree, dot)) for dot in repo]
        else:
            return relative

    def load_mask(self, mask_name):
        mask = os.path.expanduser(mask_name)
        with open(mask, 'r') as mask_file:
            return mask_file.read().strip().split()

    def make_tar(self, exclude_private=True):
        """Archive config files into tarball @ `work-tree/MikeyOS.tar.gz`.

        Keyword Argument:
        exclude_private: False: include all files from self.get_paths()
                         True (Default Value) load mask of private files and
                         exclude them from the tarball)
        """
        tarname = str(Path(self.work_tree, 'MikeyOS.tar.gz'))
        paths = self.get_paths()
        if exclude_private:
            mask = self.load_mask('~/.config/filter-dotfiles/privatemask.list')
            paths = [p for p in paths if p not in mask]
        make_tarball = ['tar', 'cvzf', tarname] + paths
        print('making tarball...')
        sp.run(make_tarball, capture_output=True)
        print(f'Created tar archive @ {tarname}')
        sp.run(['du', '-h', tarname])
        sp.run(['file', tarname])

    def show_log(self):
        """Show `git log --oneline` for the repo."""
        sp.run(self.config + ['log', '--oneline', '-n', '30'])

    def show_diff(self):
        """Show `git diff -P HEAD` for the repo."""
        sp.run(self.config + ['diff', '-P', 'HEAD'])

    def get_status(self):
        """Returns `git status -s` (short status) as a list."""
        cwd = os.getcwd()
        os.chdir(self.work_tree)
        status = self.run(self.config + ['status', '-s']).strip()
        self.status = [] if len(status) == 0 else status.split('\n')
        os.chdir(cwd)
        return self.status

    def all_branches(self, color=False):
        """
        Return all repo branches with or without coloring (default no-color).
        """
        if color:
            return self.run(self.config + ['branch', '--color=always', '-a'])
        else:
            return self.run(self.config + ['branch', '-a'])

    def get_branch(self):
        """Returns the current branch name as a string."""
        self.my_branch = self.run(self.config + ['branch', '--show-current'])
        return self.my_branch.strip()

    def banner(self, text):
        """Takes a string and prints it as a banner (via figlet | lolcat)."""
        figlet, lolcat = which('figlet'), which('lolcat')
        if figlet is None or lolcat is None:
            print(f'~-~ {text} ~-~\n')
        else:
            speed = os.path.expanduser('~/.config/figlet/speed.flf')
            font = speed if os.path.isfile(speed) else "smslant"
            fig = sp.Popen([figlet, '-f', font, text],
                           stdin=sp.PIPE, stdout=sp.PIPE)
            lol = sp.Popen([lolcat, '-f'], stdin=fig.stdout, stdout=sp.PIPE)
            out, err = lol.communicate()
            print(out.decode('utf-8'), file=sys.stderr)

    def show_status(self):
        """Pretty printer to show status of current Dotfile repo."""
        cwd = os.getcwd()
        os.chdir(self.work_tree)
        print(self.id())
        self.banner(self.get_branch())
        print(self.all_branches(color=True))
        sp.run(self.config + ['status', '-s'])
        print('< - ~ - ~ - ~ - ~ - ~ - ~ - ~ - ~ - ~ - ~ - ~ - ~>')
        os.chdir(cwd)

    def __repr__(self):
        """
        Returns location of git_dir and count of files under version control.
        """
        header = self.id()
        count = len(self.get_paths())
        return (f'{header}\n'
                f'{count} files under version control.')

    def run(self, arg_list):
        """
        Wrapper for `subprocess.run(arg_list, **kwargs).stdout`.

        kwargs = { "capture_output": True, "text": True }
        """
        return sp.run(arg_list, capture_output=True, text=True).stdout

    def commit(self):
        "Commit changes to dotfiles repository."
        sp.run(self.config + ['commit'])

    def search(self, regex_pattern=None):
        """Regex search through all files using ack."""
        if regex_pattern is None:
            self.edit_config()
        else:
            def searchable(pathin):
                non_text = ['otf', 'ttf', 'cow', 'mp3', 'kdbx', 'flf']
                if "." in pathin:
                    ext = pathin.split('.')[-1]
                    return False if ext in non_text else True
                else:
                    return True

            # filter non-text files
            files = [fp for fp in self.get_paths() if searchable(fp)]
            os.chdir(self.work_tree)
            # find all files matching each given regex
            hits = []
            for regex in regex_pattern:
                ack = ['ack', '-l', regex] + files
                ack_o = sp.run(ack, capture_output=True, text=True).stdout
                ack_o = [file for file in ack_o.split('\n') if len(file) > 0]
                hits = hits + ack_o
                # print(f'search for "{regex}": {len(ack_o)} hits')
                print(f'{len(ack_o)} hits\tfor "{regex}": ')
            hits = list(set(hits))
            hits.sort()
            prev = (f'fzf-preview.py {self.work_tree}/' + '{}' +
                    f" {regex_pattern[0]}")
            # TODO make it so the preview does a grep for EACH regex_pattern
            selection = iterfzf(hits, multi=True, preview=prev)
            if selection not in [None, []]:
                files = [str(Path(self.work_tree, sel)) for sel in selection]
                [print(f) for f in files]
                # open file(s) in $EDITOR
                if len(files) == 1:
                    edit = [self.editor, "-c",
                            f'/{regex_pattern[0]}', files[0]]
                else:
                    edit = [self.editor, '-o', '-c',
                            f'/{regex_pattern[0]}', *files]
                sp.run(edit)

    def add(self, file_list=None):
        """Add files to repo staging area.

        If `file_list is None` add all modified tracked files to staging area
        else add everything in file_list to staging area
        """
        git_add = self.config + ['add', '-v']
        if file_list in [None, []]:
            modified = git_add + ['-u']
        else:
            modified = git_add + ['--', *file_list]
        adds = sp.run(modified, capture_output=True, text=True)
        if len(adds.stdout) == 0:
            print('Clean work tree. Nothing to add')
        else:
            print(adds.stdout.strip())

    def get_tracked(self):
        """Returns a list of dotfiles tracked by the repo.

        Does not include changes in the staging area
        """
        tracked_cmd = self.config + \
            ['ls-tree', '--full-tree', '--full-name', '-r', 'HEAD']
        tracked = self.run(tracked_cmd).strip()
        if len(tracked) == 0:
            return []
        else:
            tracked = tracked.split('\n')
            return [t.split()[3] for t in tracked]

    def id(self):
        """Returns a string pointing out the location of the repo."""
        return (f'WorkTree @ {self.work_tree}\n'
                f'Git_Repo @ {self.git_dir}')

    def get_rm(self):
        """Returns a list of removed files (within the staging area).

        Looks for renamed and/or explicitly deleted files
        """
        deletion = [dot.split()[1] for dot in self.status if dot[0] == 'D']
        old_name = [dot.split()[1] for dot in self.status if dot[0] == 'R']
        return deletion + old_name

    def clip_sel(self, files):
        """Copy all items in a list to tmux paste buffer or clipboard."""
        if os.getenv('TMUX'):
            for f in files:
                sp.run(['tmux', 'set-buffer', '-a', '--', f])
        else:
            for f in files:
                echo = sp.Popen(['printf', f], stdin=sp.PIPE, stdout=sp.PIPE)
                xclip = sp.Popen(['xclip', '-selection', 'clipboard'],
                                 stdin=echo.stdout, stdout=sp.PIPE)
                out, err = xclip.communicate()

    def edit_config(self, mod=None):
        """Interactively choose repo file and open in editor."""
        self.banner('edit!')
        prev = f'fzf-preview.py {self.work_tree}/' + '{}'
        selection = iterfzf(self.get_paths(), multi=True, preview=prev)
        if selection not in [None, []]:
            files = [str(Path(self.work_tree, sel)) for sel in selection]
            if mod not in [None, []]:
                if mod[0] == 'p':
                    self.clip_sel(files)
                    [print(f) for f in files]
                elif mod[0] == 'o':
                    fdir = os.path.dirname(files[0])
                    # intended for move-term.sh
                    print(fdir)
            else:
                if len(files) == 1:
                    edit = [self.editor, files[0]]
                else:
                    edit = [self.editor, '-o', *files]
                sp.run(edit)
        else:
            print('selection cancelled.')

    def get_adds(self):
        """Returns a list of files added to the staging area of the repo.

        Looks for renamed and/or explicitly added files
        """
        additions = [dot.split()[1] for dot in self.status if dot[0] == 'A']
        rename_to = [dot.split()[3] for dot in self.status if dot[0] == 'R']
        return additions + rename_to

    def tell_git(self, arg_list=None):
        """Send commands through git without any d. smarts applied."""
        if arg_list is None:
            print("Must pass arguments to this command.", file=sys.stderr)
        else:
            command = self.config + arg_list
            sp.run(command)

    def show_raw(self):
        """Show raw git command being used to talk with repo."""
        print(" ".join(self.config))

    @ staticmethod
    def show_file(location):
        if which('bat'):
            sp.run(['bat', location])
        else:
            with open(location, 'r') as filepath:
                print(filepath.read())

    def show_git_config(self):
        """Show dotfile internal config file."""
        Dotfiles.show_file(Path(self.git_dir, 'config'))


def try_argv(position):
    """Try to get values from argv[position], return None if missing."""
    try:
        return str(argv[position]) if len(argv[position]) > 0 else None
    except IndexError:
        return None


def switch(case, arg_list=None):
    def help_msg():
        print(('A program to help you manage your $HOME dotfiles repo.\n'
               'background: https://www.atlassian.com/git/tutorials/dotfiles\n'
               '\nCommands:\n'))
        valid = [
            ['status',
                "Pretty print dotfile state"],
            ['edit',
                "Interactively select file(s) and open in $EDITOR"],
            ["add",
                "Add unmodified OR list of files to the staging area.",
                "(no files given): $ git add -u -v",
                "(files given)   : $ git add -v -- FILES"],
            ["search",
                "Pass regex search patterns to ack and search all files",
                "under dotfile repo control (i.e., list shown by `path`)"],
            ["commit",
                "Commit changes and open $EDITOR to write commit message.",
                "$ git commit"],
            ['diff',
                "Difference between work-tree and last commit.",
                "$ git diff -P HEAD"],
            ['tar',
                "Make a compressed archive of all files returned by `paths`.",
                "To use: place tarball in a $HOME directory and expand with:",
                "$ tar xf MikeyOS.tar.gz",
                "Very useful for quick and dirty setup on VMs and live-usb"],
            ['log',
                "Short log of last 30 commits.",
                "$ git log --oneline -n 30"],
            ['paths',
                "Sorted list of tracked files (relative to work-tree)",
                "List reflects an up-to-date view of the staging area.",
                "Renamed files are added and old paths removed.",
             ],
            ['fpaths',
                "Sorted list of tracked files (absolute paths)",
                "List reflects an up-to-date view of the staging area.",
                "Renamed files are added and old paths removed.",
             ],
            ["raw",
                "See underlying git command being used to work with dotfiles",
                "Great if you need to use something like `xargs`",
             ],
            ["git",
                "Send commands to the underlying git dotfiles repo.",
                "Be all the power user you can be. No dotfiles smarts applied.",
                "Talk to git without the training wheels.",
                "Same as output of 'raw' commands + arguements you send",
             ],
            ["gitcfg",
                "View dotfile git configuration file",
             ],
            ["help",
                "view this help message.",
             ],
        ]
        for v in valid:
            print(f'  {v[0]:8}--  {v[1]}')
            if len(v) > 2:
                [print(" " * 14 + f'{addendum}') for addendum in v[2:]]
            print()

    """
    Take CLI arguments and apply the right actions.

    Options:
        status: Pretty print repo status.
        add:    Add all modified files i.e., `git add -u -v`
        add:    with arguements: add files to dotfile repo.
        edit:   Choose file(s) and open in editor.
        paths:  Return RELATIVE paths of files under version control.
        fpaths: Return ABSOLUTE paths of files under version control.
        tar:    Make tarball of dotfiles  @ work-tree/MikeyOS.tar.gz
        raw:    Show raw git command being used to talk with repo.
        git:    Talk to underlying git repo directly.
        gitcfg: Show dotfile internal git repo config file.
        log:    Show `git log --oneline` for repo
        help:   print useage information
    """
    opts = {
        'status': main.show_status,
        'edit': main.edit_config,
        'add': main.add,
        'diff': main.show_diff,
        'log': main.show_log,
        'paths': main.get_paths(),
        'fpaths': main.get_paths(full_path=True),
        'tar': main.make_tar,
        'git': main.tell_git,
        'raw': main.show_raw,
        'gitcfg': main.show_git_config,
        'commit': main.commit,
        'search': main.search,
        'help': help_msg,
    }
    try:
        choice = opts[case]
        if callable(choice):
            if arg_list is None:
                choice()
            else:
                choice(arg_list)
        elif type(choice) is list:
            [print(item) for item in choice]
        else:
            print(choice)
    except KeyError:
        print(f'"{case}" is not a valid argument.')
        help_msg()


if __name__ == "__main__":
    # main = Dotfiles(os.getenv('DOTFILES'), str(Path.home()))
    main = Dotfiles()

    one = "status" if try_argv(1) is None else argv[1]
    trailing_args = [arg for arg in argv[2:] if len(arg) > 0]
    trailing_args = None if len(trailing_args) == 0 else trailing_args
    # see(argv, 'argv')

    if trailing_args is []:
        switch(one)
    else:
        switch(one, trailing_args)
