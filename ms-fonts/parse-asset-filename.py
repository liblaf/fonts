import os
import re
import sys
from pathlib import Path


def main() -> None:
    fpath = Path(sys.argv[1])
    stem: str = fpath.stem
    match: re.Match[str] | None = re.fullmatch(
        r"(?P<win>[a-zA-Z0-9]+)-(?P<lang>\w+)", stem
    )
    assert match is not None
    with Path(os.environ["GITHUB_ENV"]).open("a") as fp:
        print(f"WIN={match['win']}", file=fp)
        print(f"LANG={match['lang']}", file=fp)
    with Path(os.environ["GITHUB_OUTPUT"]).open("a") as fp:
        print(f"tag={match['win']}", file=fp)


if __name__ == "__main__":
    main()
