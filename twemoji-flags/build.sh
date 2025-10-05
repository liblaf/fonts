#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

gh release --repo 'JoeBlakeB/ttf-twemoji-aur' download --clobber --output 'Twemoji.ttf' --pattern 'Twemoji-*.ttf'
# ref: <https://github.com/talkjs/country-flag-emoji-polyfill/blob/master/build/make-font.sh>
uvx --from fonttools pyftsubset 'Twemoji.ttf' \
  --no-subset-tables+='FFTM' \
  --unicodes='U+1F1E6-1F1FF,U+1F3F4,U+E0061-E007A,U+E007F' \
  --output-file='TwemojiSubset.ttf' \
  --verbose \
  --timing
uv run --with fonttools 'https://github.com/fonttools/fonttools/raw/refs/heads/main/Snippets/rename-fonts.py' \
  --suffix ' Flags' \
  --output-file 'TwemojiFlags.ttf' \
  'TwemojiSubset.ttf'
