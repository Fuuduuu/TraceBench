#!/usr/bin/env python3
"""Import a TraceBench Project ZIP into a target directory."""
from __future__ import annotations

import os
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VALIDATE_SCRIPT = ROOT / "tools" / "validate_project_zip.py"


def _is_safe_member_name(name: str) -> bool:
    if not name:
        return False
    if name.startswith("/") or ":" in name:
        return False
    if ".." in Path(name).parts:
        return False
    if name.endswith("/"):
        return True
    try:
        normalized = Path(name)
    except Exception:
        return False
    return ".." not in normalized.parts and ":" not in normalized.as_posix()


def _extract_member(zip_file: zipfile.ZipFile, member: zipfile.ZipInfo, destination: Path) -> bool:
    target = (destination / member.filename).resolve()
    destination_root = destination.resolve()
    if not str(target).startswith(str(destination_root) + os.sep):
        return False
    destination.mkdir(parents=True, exist_ok=True)
    if member.is_dir():
        target.mkdir(parents=True, exist_ok=True)
        return True
    target.parent.mkdir(parents=True, exist_ok=True)
    with zip_file.open(member) as source, target.open("wb") as output:
        output.write(source.read())
    return True


def import_project_zip(project_zip: Path, output_dir: Path) -> int:
    if not project_zip.exists() or not project_zip.is_file():
        print(f"[ERROR] project zip missing: {project_zip}")
        return 2

    if output_dir.exists() and any(output_dir.iterdir()):
        print(f"[ERROR] output_dir must be empty: {output_dir}")
        return 2

    try:
        with zipfile.ZipFile(project_zip, "r") as zip_file:
            for member in zip_file.infolist():
                if not _is_safe_member_name(member.filename):
                    print(f"[ERROR] rejected unsafe zip member: {member.filename}")
                    return 2
            output_dir.mkdir(parents=True, exist_ok=True)
            for member in zip_file.infolist():
                if not _extract_member(zip_file, member, output_dir):
                    print(f"[ERROR] rejected unsafe extraction target for: {member.filename}")
                    return 2
    except zipfile.BadZipFile:
        print(f"[ERROR] invalid zip file: {project_zip}")
        return 2

    validate = subprocess.run(
        [sys.executable, str(VALIDATE_SCRIPT), str(output_dir)],
        cwd=str(ROOT),
        text=True,
    )
    if validate.returncode != 0:
        print(f"[ERROR] project zip validation failed for {output_dir}")
        return validate.returncode

    print(f"[OK] imported project to {output_dir}")
    return 0


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: python tools/import_project_zip.py <project_zip> <output_dir>")
        return 2
    return import_project_zip(Path(sys.argv[1]), Path(sys.argv[2]))


if __name__ == "__main__":
    raise SystemExit(main())
