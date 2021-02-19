#!/usr/bin/env python3
# Mikey Garcia, @gikeymarcia
# dependencies: mediainfo
import subprocess as sp  # noqa: F401
import sys
import os
import re
import json
from shutil import which


def banner(text, figfont=None):
    """Takes a string and prints it as a banner (via figlet)."""
    figlet = which('figlet')
    if figlet is None:
        print(f'~-~ {text} ~-~\n')
    else:
        if figfont is None:
            speed = os.path.expanduser('~/.config/figlet/speed.flf')
            figfont = speed if os.path.isfile(speed) else "smslant"
        sp.run([figlet, '-f', figfont, text])


def extract_json_info(filepath):
    with open(filepath, 'r') as fp:
        data = json.load(fp)

    return {
        'path': filepath,
        'title': data.get("fulltitle"),
        'uploader': data.get("uploader"),
        'url': data.get("webpage_url"),
        'description': data.get("description"),
        'thumbnail': data.get("thumbnail"),
        'channel_url': data.get("channel_url"),
        'channel_id': data.get("channel_id"),
        'height': data.get("height"),
        'width': data.get("width"),
        'resolution': data.get("resolution"),
        'release_date': data.get("release_date"),
    }


def parse_ytdl(filepath):
    lastdot = filepath.rfind(".")
    ytdl_json = filepath[:lastdot] + ".info.json"
    if os.path.isfile(ytdl_json):
        return extract_json_info(ytdl_json)
    else:
        return None


def get_mediainfo(filepath):
    def get_match(regex, body_o_text, return_group=None):
        pattern = re.compile(regex)
        match = pattern.search(body_o_text)
        if match is None:
            return None
        else:
            if return_group is None:
                return match
            else:
                if type(return_group) is int:
                    return_group = [return_group]
                return match.group(*return_group)

    info = sp.run(['mediainfo', filepath],
                  capture_output=True, text=True).stdout
    return {
        "name": get_match(r'Complete name\s*: (.*)\n', info, 1),
        "duration": get_match(r'Duration\s*: (.*)\n', info, 1),
        "filesize": get_match(r'File size\s*: (.*)\n', info, 1),
        "format": get_match(r'Format\s*: (.*)\n', info, 1),
        "a_format": get_match(r'Format\s*: (.*)\n', info, 1),
        "bit_mode": get_match(r'Overall bit rate mode\s*: (.*)\n', info, 1),
        "v_bitrate": get_match(r'Overall bit rate\s*: (.*)\n', info, 1),
        "v_framerate": get_match(r'Frame rate\s*: (.*)\n', info, 1),
        "v_codec": get_match(r'Codec ID\s*: (.*)\n', info, 1),
        "v_width": get_match(r'Width\s*: (.*) pix.*\n', info, 1),
        "v_height": get_match(r'Height\s*: (.*) pix.*\n', info, 1),
        "a_rate": get_match(r'Bit rate\s*: (.*)\n', info, 1),
        "a_mode": get_match(r'Bit rate mode\s*: (.*)\n', info, 1),
        "a_channels": get_match(r'Channel\(s\)\s*: (.*)\n', info, 1),
        "a_speakers": get_match(r'Channel positions\(s\)\s*: (.*)\n', info, 1),
    }


def pretty_media_info(filename):
    banner('media')
    mediainfo = get_mediainfo(filename)
    audio_fields = ['a_channels', 'a_mode', 'format', 'a_rate']
    audio = [mediainfo.get(a)
             for a in audio_fields if mediainfo.get(a) is not None]
    audio = " ".join(audio)
    print((
        "General:\n"
        f"  Duration: {mediainfo.get('duration')}\n"
        f"  Filesize: {mediainfo.get('filesize')}\n"
        "\nVideo:\n"
        f"  Format: {mediainfo.get('format')}\n"
        f"  Pixels: {mediainfo.get('v_width')} x {mediainfo.get('v_height')}\n"
        f"  Rate:   {mediainfo.get('v_bitrate')}\n"
        f"  Codec:  {mediainfo.get('v_codec')}\n"
        f"  FPS:    {mediainfo.get('v_framerate')}\n"
        "\nAudio:\n"
        f"  {audio}\n"
    ))


def pretty_ytdl_info(ytdl_info, filename):
    banner(ytdl_info.get('uploader'), 'small')
    mediainfo = get_mediainfo(filename)
    audio_fields = ['a_channels', 'a_mode', 'format', 'a_rate']
    audio = [mediainfo.get(a)
             for a in audio_fields if mediainfo.get(a) is not None]
    audio = " ".join(audio)
    print((
        f"\n{ytdl_info.get('title')}\n"
        f"~ {ytdl_info.get('uploader')} ~\n\n"
        "General:\n"
        f"  Duration: {mediainfo.get('duration')}\n"
        f"  Filesize: {mediainfo.get('filesize')}\n"
        "\nVideo:\n"
        f"  Format: {mediainfo.get('format')}\n"
        f"  Pixels: {mediainfo.get('v_width')} x {mediainfo.get('v_height')}\n"
        f"  Rate:   {mediainfo.get('v_bitrate')}\n"
        f"  Codec:  {mediainfo.get('v_codec')}\n"
        f"  FPS:    {mediainfo.get('v_framerate')}\n"
        "\nAudio:\n"
        f"  {audio}\n"
        "\nURL:\n"
        f"  {ytdl_info.get('url')}\n"
        "\nChannel:\n"
        f"  {ytdl_info.get('channel_url')}\n"
        "\nDescription:\n"
        f"  {ytdl_info.get('description')}\n"
    ))


if __name__ == "__main__":
    filename = sys.argv[1]

    # ytdl info
    ytdl_info = parse_ytdl(filename)
    if ytdl_info is None:
        pretty_media_info(filename)
    else:
        pretty_ytdl_info(ytdl_info, filename)
