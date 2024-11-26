import os
import re
import sys
from pathlib import Path


def main() -> None:
    fpath = Path(sys.argv[1])
    stem: str = fpath.stem
    match: re.Match[str] | None = re.fullmatch(
        r"(?P<win>[a-zA-Z0-9]+)_(?P<rel>[a-zA-Z0-9]+)_(?P<lang>\w+)_(?P<arch>[a-zA-Z0-9]+)",
        stem,
    )
    assert match is not None
    with Path(os.environ["GITHUB_ENV"]).open("a") as fp:
        print(f"WIN={match['win']}", file=fp)
        print(f"REL={match['rel']}", file=fp)
        print(f"LANG={match['lang']}", file=fp)
        print(f"ARCH={match['arch']}", file=fp)


if __name__ == "__main__":
    main()
