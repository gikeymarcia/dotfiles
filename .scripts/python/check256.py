#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# Check sha256 file hashes
# dependencies: figlet sha256sum


import sys
import os
import subprocess


def check_file(path):
    if os.path.isfile(path):
        return os.path.abspath(path)
    elif os.path.isfile(os.path.expanduser(path)):
        return os.path.abspath(os.path.expanduser(path))
    else:
        sys.exit(f'Arguement 1 must be a valid file path.\n"{path}" given')


if __name__ == "__main__":
    """ Checks sha256sum values: param1=filepath, param2=sha256checksum """
    args = [arg for arg in sys.argv if len(arg) > 1]
    if len(args) == 3:
        target = check_file(sys.argv[1])
        sha256 = sys.argv[2]
        computed_hash = subprocess.run(
            ['sha256sum', target], capture_output=True, text=True).stdout
        computed_hash = computed_hash.split()[0]
        state = "match" if computed_hash == sha256 else "mismatch"
        figlet = subprocess.run(
            ['figlet', state], capture_output=True, text=True)
        print("sha256 checksums", figlet.stdout, sep='\n')
        print((f'filepath:\t{target}\n'
               f'file hash:\t{computed_hash}\n'
               f'given hash:\t{sha256}\n'))
    else:
        arg_count = len(args) - 1
        print(f'Script requires 2 arguments, {arg_count} given')
        print("Contents of `sys.argv`")
        [print(i, v) for i, v in enumerate(sys.argv)]
