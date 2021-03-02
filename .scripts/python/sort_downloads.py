#!/usr/bin/env python3
# David Garcia,
# Practice automating a dictionary from a list
# dependencies: none
# Date completed: 2-18-2021
# modified by Mikey Garcia, 2021-03-01

import os
import shutil


def get_type_folder(filepath, basepath):
    "Send in filepath and get back folder it should be moved to."
    # Change tuple to list
    pieces = list(os.path.splitext(filepath))
    # remove period
    extension = pieces[1].replace('.', '')
    if extension == '':
        return os.path.join(basepath, 'Misc')
    else:
        return os.path.join(basepath, extension)


if __name__ == "__main__":
    # Folder path
    path = os.path.expanduser('~/Downloads')

    # List all files in the path
    _files = os.listdir(path)

    for filename in _files:
        filepath = os.path.join(path, filename)
        if os.path.isfile(filepath):
            new_folder = get_type_folder(filepath, path)
            new_path = os.path.join(new_folder, filename)
            # make folder if it doesn't exist
            if not os.path.isdir(new_folder):
                os.mkdir(new_folder)
            # move file to new folder
            print(f'mv "{filepath}" "{new_path}"')
            shutil.move(filepath, new_path)
