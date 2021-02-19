#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# launch editor with python script and REPL preview on write
# uses either autocmd or tmux split to show output (prefer split if in TMUX)
# dependencies: python bat live-code.sh
# environment: $EDITOR

from sys import argv
import os
from subprocess import run
import shutil
from pathlib import Path


def make_temp():
    "Make temp file and return it's path."
    temp_dir = '/tmp/py-scratch'
    if not os.path.isdir(temp_dir):
        run(['mkdir', '-pv', temp_dir])
    mktemp = ['mktemp', f'--tmpdir={temp_dir}', '--suffix=.py']
    return run(mktemp, capture_output=True, text=True).stdout.strip()


def choose_editor(ed_list):
    "Return first item in ed_list in system $PATH."
    for e in ed_list:
        if shutil.which(e) is not None:
            return e


def prepare_file(fname):
    "Make python file executable and populate with skelton if empty."
    abspath = os.path.abspath(fname)
    if os.path.isfile(fname) and os.path.getsize(fname) > 2:
        os.chmod(abspath, 0o755)
        return abspath
    else:
        skel = ("#!/usr/bin/env python3\n"
                "# Mikey Garcia, @gikeymarcia\n"
                "import mikey  # noqa: F401\n\n")
        p = Path(fname)
        p.touch(0o755, exist_ok=True)
        p.write_text(skel, encoding='utf-8')
        os.chmod(abspath, 0o755)
        return abspath


def in_tmux():
    "Return bool after checking if we are running inside tmux."
    return False if os.getenv('TMUX') is None else True


if __name__ == "__main__":
    live_code = os.path.expanduser('~/.scripts/commands/live-code.sh')
    editor = choose_editor([os.getenv('EDITOR'),
                            'nvim', 'vim', 'nano', 'pico'])

    # either use filename or make temp file
    if len(argv) > 1 and len(argv[1]) > 0:
        path = prepare_file(argv[1])
    else:
        temp_file = make_temp()
        path = prepare_file(temp_file)

    # if in TMUX:
    if in_tmux():
        live_split = ['tmux', 'split-window', '-h', live_code, path]
        run(live_split)
        run([editor, path])
    else:
        run([editor, '-c autocmd BufWritePost *.py :!python3 %', path])

    print(f"filename:\t{path}")
    run(['bat', path])
