#!/bin/bash
set -o errexit -o nounset -o pipefail

gh release --repo "JoeBlakeB/ttf-twemoji-aur" download --clobber --output "Twemoji.ttf" --pattern "Twemoji-*.ttf"
# https://github.com/talkjs/country-flag-emoji-polyfill/blob/527a3d121d2e198e733934a8b1007c819244e903/build/make-font.sh
uvx --from fonttools pyftsubset "Twemoji.ttf" \
  --no-subset-tables+="FFTM" \
  --unicodes="U+1F1E6-1F1FF,U+1F3F4,U+E0061-E007A,U+E007F" \
  --output-file="TwemojiSubset.ttf" \
  --verbose \
  --timing
uv run --with fonttools "https://github.com/fonttools/fonttools/raw/refs/heads/main/Snippets/rename-fonts.py" \
  --suffix " Flags" \
  --output-file "TwemojiFlags.ttf" \
  "TwemojiSubset.ttf"
