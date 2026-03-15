#!/usr/bin/env python3
"""Validate Homebrew tap metadata used by GitHub CI."""

from __future__ import annotations

import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
FORMULA_DIR = REPO_ROOT / "Formula"
README_PATH = REPO_ROOT / "README.md"

EXPECTED_FORMULAE = {"cnb-rs.rb", "cnb-rs-musl.rb"}
EXPECTED_README_SNIPPETS = [
    "brew tap wwvo/cnb-rs https://cnb.cool/wwvo/cnb-rs/homebrew-cnb-rs.git",
    "brew install wwvo/cnb-rs/cnb-rs",
    "alias cnb='cnb-rs'",
]


def validate_formula(path: Path) -> list[str]:
    errors: list[str] = []
    content = path.read_text(encoding="utf-8")

    if 'bin.install "cnb-rs"' not in content:
        errors.append(f"{path.name}: missing bin.install \"cnb-rs\"")
    if "git-cnb" in content:
        errors.append(f"{path.name}: must not mention git-cnb")
    if "cnb-cli/homebrew-cnb-cli" in content:
        errors.append(f"{path.name}: still references old tap path")

    return errors


def validate_readme(path: Path) -> list[str]:
    errors: list[str] = []
    content = path.read_text(encoding="utf-8")

    for snippet in EXPECTED_README_SNIPPETS:
        if snippet not in content:
            errors.append(f"README.md: missing expected snippet: {snippet}")

    if "wwvo/cnb-cli" in content:
        errors.append("README.md: still references old tap namespace")
    if "git-cnb" in content:
        errors.append("README.md: must not mention git-cnb")

    return errors


def main() -> int:
    errors: list[str] = []

    formulae = {path.name for path in FORMULA_DIR.glob("*.rb")}
    if formulae != EXPECTED_FORMULAE:
        errors.append(
            "Formula directory must contain exactly: "
            + ", ".join(sorted(EXPECTED_FORMULAE))
        )

    for formula_path in sorted(FORMULA_DIR.glob("*.rb")):
        errors.extend(validate_formula(formula_path))

    errors.extend(validate_readme(README_PATH))

    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1

    print("CI metadata validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
