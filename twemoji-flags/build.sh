#!/bin/bash
set -o errexit -o nounset -o pipefail

gh release --repo "JoeBlakeB/ttf-twemoji-aur" download --clobber --output "Twemoji.ttf" --pattern "Twemoji-*.ttf"
uvx --from fonttools pyftsubset "Twemoji.ttf" \
  --no-subset-tables+="FFTM" \
  --unicodes="U+1F1E6-1F1FF,U+1F3F4,U+E0061-E007A,U+E007F" \
  --output-file="TwemojiSubset.ttf"
uv run --with fonttools "https://github.com/fonttools/fonttools/raw/refs/heads/main/Snippets/rename-fonts.py" \
  --suffix " Flags" \
  --output-file "TwemojiFlags.ttf" \
  "TwemojiSubset.ttf"
