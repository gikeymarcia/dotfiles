#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
"""
Personal helper module by Mikey Garcia, @gikeymarcia.

Contains mostly functions that help me see the result of commands I run
"""
import subprocess as sp
from shutil import which
import pprint as pp
import os
import sys
import random
from pathlib import Path


def banner(text, figfont=None):
    """Takes a string and prints it as a banner (via figlet | lolcat)."""
    figlet, lolcat = which('figlet'), which('lolcat')
    if figlet is None or lolcat is None:
        print(f'~-~ {text} ~-~\n')
    else:
        if figfont is None:
            speed = os.path.expanduser('~/.config/figlet/speed.flf')
            figfont = speed if os.path.isfile(speed) else "smslant"
        fig = sp.Popen([figlet, '-f', figfont, text],
                       stdin=sp.PIPE, stdout=sp.PIPE)
        lol = sp.Popen([lolcat, '-f'], stdin=fig.stdout, stdout=sp.PIPE)
        out, err = lol.communicate()
        print(out.decode('utf-8'))


def choose_host(local, secondary):
    """Return local if ping_success(local) else secondary."""
    ping = ['ping', '-c', '1', '-w', '1', local]
    lrun = sp.run(ping, capture_output=True, text=True)
    return local if len(lrun.stdout) > 1 else secondary


def pprint(*args):
    """Preconfigured pretty printer wrapper."""
    my_printer = pp.PrettyPrinter(indent=2, width=80, compact=True)
    my_printer.pprint(*args)


class clr:
    """Strings containing ANSI color codes.

    Thanks to https://stackoverflow.com/a/287944 and Blender!
    """
    header = '\033[95m'
    okblue = '\033[94m'
    okcyan = '\033[96m'
    okgreen = '\033[92m'
    warning = '\033[93m'
    fail = '\033[91m'
    endc = '\033[0m'
    bold = '\033[1m'
    underline = '\033[4m'
    flash = bold + okgreen


def elist(alist, title=None):
    """
    Take a list and enumerate + print headers for chars in each item.
    """
    start, end, head = clr.okblue, clr.endc, clr.okcyan
    if title:
        print(f'\t{head}~{title}{end}')
    print('\t|{}'.format('0123456789' * 4))
    [print(f'{i}\t|{start}{v}{end}') for i, v in enumerate(alist)]


def inspect(obj, title=None):
    "Prints helpful information about objects for REPL coding/debugging."
    objtype = type(obj)
    if objtype in [list, str]:
        objlen = len(obj)
    if title:
        print(f'{clr.bold}{title}:{clr.endc}\n')
    if objtype is list:
        print((f'Type:\t{objtype}\n'
               f'length:\t{objlen}'))
        elist(obj)
    elif objtype is str:
        print((f'Type:\t{objtype}\t{obj}\n'
               f'Length:\t{len(obj)}\n'))
        print('.split()\t{}'.format(obj.split()))
        print('.split("-")\t{}\n\n'.format(obj.split('-')))
    else:
        print(type(obj))
        print(obj)
    print()


def random_file(filepath, restrict_2_filetypes=None):
    """Get a random file from a directory.

    Optionally: pass a list of file extensions and the search will be
                restricted to those types.
    """
    path_obj = Path(os.path.expanduser(filepath))
    if path_obj.is_dir():
        extensions = []
        if type(restrict_2_filetypes) is list:
            for filetype in restrict_2_filetypes:
                extensions = extensions + ['--extension', filetype]
        fd_cmd = ['fd', '--color', 'never', '--type', 'file'] + \
            extensions + ['.', str(path_obj)]
        files = sp.run(fd_cmd, capture_output=True,
                       text=True).stdout.rstrip().split('\n')
        return random.choice(files)
    else:
        sys.exit(f"'{filepath}' must be a directory. It is not.")


if __name__ == "__main__":
    pass
