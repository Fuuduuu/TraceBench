#!/usr/bin/env python3
"""Import a TraceBench Project ZIP into a target directory."""
from __future__ import annotations

import os
import shutil
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VALIDATE_SCRIPT = ROOT / "tools" / "validate_project_zip.py"


def _is_safe_member_name(name: str) -> bool:
    if not name:
        return False
    if name.startswith(("/", "\\")):
        return False
    if ":" in name:
        return False

    normalized = name.replace("\\", "/")
    return ".." not in Path(normalized).parts


def _extract_member(zip_file: zipfile.ZipFile, member: zipfile.ZipInfo, destination: Path) -> bool:
    target = (destination / member.filename).resolve()
    destination_root = destination.resolve()
    if not str(target).startswith(str(destination_root) + os.sep):
        return False

    if member.is_dir() or member.filename.endswith("/"):
        target.mkdir(parents=True, exist_ok=True)
        return True

    target.parent.mkdir(parents=True, exist_ok=True)
    with zip_file.open(member) as source, target.open("wb") as output:
        output.write(source.read())
    return True


def _extract_to_temp(zip_path: Path, temp_dir: Path, errors: list[str]) -> bool:
    try:
        with zipfile.ZipFile(zip_path, "r") as zip_file:
            for member in zip_file.infolist():
                if not _is_safe_member_name(member.filename):
                    errors.append(f"rejected unsafe zip member: {member.filename}")
                    return False
                if not _extract_member(zip_file, member, temp_dir):
                    errors.append(f"rejected unsafe extraction target for: {member.filename}")
                    return False
    except zipfile.BadZipFile:
        errors.append(f"invalid zip file: {zip_path}")
        return False
    return True


def import_project_zip(project_zip: Path, output_dir: Path) -> int:
    if not project_zip.exists() or not project_zip.is_file():
        print(f"[ERROR] project zip missing: {project_zip}")
        return 2

    if output_dir.exists() and any(output_dir.iterdir()):
        print(f"[ERROR] output_dir must be empty: {output_dir}")
        return 2

    errors: list[str] = []
    output_existed = output_dir.exists()
    try:
        with tempfile.TemporaryDirectory() as temp_dir:
            staging = Path(temp_dir)
            if not _extract_to_temp(project_zip, staging, errors):
                for message in errors:
                    print(f"[ERROR] {message}")
                return 2

            validate = subprocess.run(
                [sys.executable, str(VALIDATE_SCRIPT), str(staging)],
                cwd=str(ROOT),
                text=True,
            )
            if validate.returncode != 0:
                print(f"[ERROR] project zip validation failed for {project_zip}")
                return validate.returncode

            if output_dir.exists() and output_dir.is_dir():
                for child in output_dir.iterdir():
                    if child.is_dir():
                        shutil.rmtree(child)
                    else:
                        child.unlink()
            output_dir.mkdir(parents=True, exist_ok=True)
            shutil.copytree(staging, output_dir, dirs_exist_ok=True)

            print(f"[OK] imported project to {output_dir}")
            return 0
    except Exception as exc:
        print(f"[ERROR] failed to import project zip: {exc}")
        if not output_existed and output_dir.exists():
            # Keep failed imports from leaving output behind.
            if not any(output_dir.iterdir()):
                output_dir.rmdir()
        return 2


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: python tools/import_project_zip.py <project_zip> <output_dir>")
        return 2
    return import_project_zip(Path(sys.argv[1]), Path(sys.argv[2]))


if __name__ == "__main__":
    raise SystemExit(main())
