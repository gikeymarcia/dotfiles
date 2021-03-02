# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][why changelog], and this project doesn't yet adhere to [Semantic Versioning][semantic vers], but I aspire to do so in the future.

## [March 01 2021]

### Added

+ [alias][bash_aliases] `tor` for using `transmission-remote`
+ [`sort_downloads.py`][sort_downloads] to auto-sort by file extension

### Changed

+ tweak `bk` and `bkg` in `~/.bash_funcs` with better previews
+ beginning to replace `dmenu` with `rofi`
+ major cleanup of [`picom` configs][picom]
+ finished [`json-preview.py`][json_preview]

## [1.0.0] - 2021-02-19

### Added
- This `CHANGELOG.md` file!

### Changed
+ moving from firefox to brave-browser as my new default
- Working to move bash solutions into python scripts where helpful

### Removed
- Not using `coc-sh` in nvim because of high CPU use


[why changelog]: <https://keepachangelog.com/en/1.0.0/>
"Keep a changelog: don't let your friends dump git logs into changelogs"
[semantic vers]: <https://semver.org/spec/v2.0.0.html>
"Long Description of Link"
[picom]: <https://github.com/gikeymarcia/dotfiles/tree/master/.config/picom>
"Picom config directory"
[sort_downloads]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/python/sort_downloads.py>
"Script to sort ~/Downloads folder by file extension"
[json_preview]: <https://github.com/gikeymarcia/dotfiles/blob/master/.scripts/python/json-preview.py>
"Preview .json files in ranger and/or read .info.json files from youtube-dl"
[bash_aliases]: <https://github.com/gikeymarcia/dotfiles/blob/master/.bash_aliases>
"Long Description of Link"
