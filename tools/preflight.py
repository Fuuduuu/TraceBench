#!/usr/bin/env python3
"""Read-only TraceBench prechecks. Exit 0=prechecks, 1=failure, 2=review required.

An exit of zero never attests tests or independent acceptance. Only the explicit
--doctor option executes an existing Python helper; test/materializer/ZIP commands
are recommendations, never subprocesses. origin/main is a local, unfetched ref.
"""
import sys

sys.dont_write_bytecode = True

import argparse
import json
import os
from pathlib import Path, PurePosixPath
import re
import subprocess


REPOSITORY = "Fuuduuu/TraceBench"
PROTECTED_DOCS = {
    "docs/POHIKIRI.md", "docs/TRUTH_INDEX.md", "docs/PROTECTED_SURFACES.md",
    "docs/EVENT_LOG_SPEC.md", "docs/PROJECT_ZIP_SPEC.md",
    "docs/PROJECTION_REFRESH_SPEC.md", "docs/DATA_MODEL.md",
    "docs/FLUTTER_EVENT_WRITE_SPEC.md",
}
PROTECTED_TOOLS = {
    "tools/event_writer_service.py", "tools/materialize_known_facts.py",
    "tools/validate_events_jsonl.py", "tools/export_project_zip.py",
    "tools/import_project_zip.py", "tools/validate_project_zip.py",
}


def git(repo, *args):
    # Suppress optional index writes, fsmonitor hooks and external diff drivers.
    return subprocess.run(
        ["git", "--no-pager", "--no-optional-locks", "-c", "core.fsmonitor=false",
         "-C", str(repo), *args], capture_output=True, timeout=30,
        env=dict(os.environ, GIT_OPTIONAL_LOCKS="0"), check=True).stdout


def parse_status(data):
    """Porcelain v2 -z: a type-2 record has destination then a separate old path."""
    if not data:
        return [], [], [], [], []
    records = data.split(b"\0")
    if records.pop() != b"":
        raise ValueError("Truncated NUL-delimited Git status")
    staged, unstaged, untracked, unmerged = set(), set(), set(), set()
    renames = []
    records = iter(records)
    for record in records:
        if record.startswith(b"? "):
            if len(record) == 2:
                raise ValueError("Empty untracked path")
            untracked.add(os.fsdecode(record[2:]))
            continue
        kind = record[:1]
        count = {b"1": 8, b"2": 9, b"u": 10}.get(kind)
        if count is None:
            raise ValueError("Unexpected Git status record")
        fields = record.split(b" ", count)
        if len(fields) != count + 1 or len(fields[1]) != 2 or not fields[-1]:
            raise ValueError("Malformed Git status record")
        xy, path = fields[1].decode("ascii"), os.fsdecode(fields[-1])
        old = None
        if kind == b"2":
            original = next(records, b"")
            if not original:
                raise ValueError("Missing original rename path")
            old = os.fsdecode(original)
            renames.append({"from": old, "to": path, "xy": xy})
        if xy[0] != ".":
            staged.add(path)
            if old is not None and xy[0] in "RC":
                staged.add(old)
        if xy[1] != ".":
            unstaged.add(path)
            if old is not None and xy[1] in "RC":
                unstaged.add(old)
        if kind == b"u":
            unmerged.add(path)
    return (sorted(staged), sorted(unstaged), sorted(untracked),
            sorted(unmerged), sorted(renames, key=lambda item: (item["from"], item["to"])))


def is_protected(path):
    name = PurePosixPath(path).name
    return (path in PROTECTED_DOCS or path in PROTECTED_TOOLS
            or path.startswith(("schemas/", "docs/spec/V2_", "device_profiles/",
                                "lib/shared/session/", "lib/shared/models/",
                                "lib/features/component_candidates/models/"))
            or path in {"lib/shared/services/project_loader.dart",
                        "lib/shared/services/project_creator.dart",
                        "lib/shared/services/project_exporter.dart",
                        "lib/shared/services/project_projection_refresher.dart",
                        "lib/shared/widgets/workbench_projection_refresh.dart",
                        "lib/features/photos/services/photo_import_service.dart",
                        "lib/features/board_canvas/widgets/board_canvas_placement_panel.dart",
                        "lib/features/board_canvas/widgets/component_identity_panel.dart",
                        "lib/features/board_canvas/widgets/integrated_measure_panel.dart",
                        "lib/features/components/screens/add_component_screen.dart",
                        "lib/features/components/screens/edit_component_screen.dart",
                        "lib/features/measure_sheet/screens/measure_sheet_screen.dart",
                        "lib/features/photos/widgets/photo_workbench_panel.dart",
                        "lib/features/report/screens/customer_report_screen.dart",
                        "lib/features/board_canvas/geometry/placement_geometry.dart"}
            or name in {"events.jsonl", "known_facts.json"}
            or (path.startswith("lib/") and
                re.search(r"writer|sidecar|persist|store", name, re.IGNORECASE) is not None))


def expected_path(value):
    path = PurePosixPath(value.replace("\\", "/"))
    if path.is_absolute() or ".." in path.parts or re.match(r"^[A-Za-z]:", str(path)) or str(path) == ".":
        raise ValueError("Expected paths must be exact repository-relative paths")
    return path.as_posix()


def recommendations(root, paths, protected):
    pending = ["Task tests not executed; independent review/acceptance is not recorded."]
    if not paths or all(path.endswith(".md") for path in paths):
        pending.append("Docs: review links/anchors and existing tools/validate_project_state.py where applicable.")
    if any(path.endswith(".dart") for path in paths):
        pending += ["flutter analyze --no-pub",
                    "Focused flutter test --no-pub for affected features; full suite when required by task risk."]
    python_tests = set()
    for path in paths:
        if path.endswith(".py"):
            name = PurePosixPath(path).name
            candidate = name if name.startswith("test_") else "test_" + name
            if (root / "tests" / candidate).is_file():
                python_tests.add(candidate)
    pending += ["python -X utf8 -B -m unittest discover -s tests -p " + name
                for name in sorted(python_tests)]
    if any(path.endswith(".py") for path in paths) and not python_tests:
        pending.append("Select focused Python regressions for the changed tools/tests.")
    if protected:
        pending.append("Protected owners: explicit task boundary, relevant contract regressions and independent review required.")
        if any(not path.endswith(".md") for path in protected):
            pending.append("Reuse relevant event/Session/persistence/ZIP tests; tools/validate_all.py only in a separately authorized temporary-output run.")
    return pending


def inspect(repo, baseline=None, expected=None, doctor=False):
    root = Path(os.fsdecode(git(repo, "rev-parse", "--show-toplevel")).strip()).resolve()
    staged, unstaged, untracked, unmerged, renames = parse_status(
        git(root, "status", "--porcelain=v2", "-z", "--find-renames", "--untracked-files=all"))
    paths = set(staged + unstaged + untracked)
    head = git(root, "rev-parse", "--verify", "HEAD").decode().strip()
    branch = git(root, "branch", "--show-current").decode().strip()
    remote = git(root, "remote", "get-url", "origin").decode().strip().rstrip("/")
    identity = remote
    for prefix in ("https://github.com/", "git@github.com:", "ssh://git@github.com/"):
        if remote.lower().startswith(prefix):
            identity = remote[len(prefix):].removesuffix(".git")
            break
    failures, passed = [], []
    pending = recommendations(root, paths, sorted(filter(is_protected, paths)))
    if identity.lower() != REPOSITORY.lower():
        failures.append("Repository identity does not match " + REPOSITORY)
    if branch != "main":
        failures.append("Expected branch main, found " + (branch or "detached HEAD"))
    if baseline is not None and baseline.lower() != head:
        failures.append("HEAD does not match the expected full baseline hash")
    if baseline is None:
        pending.append("Expected baseline not supplied; no baseline comparison performed.")
    origin_main, divergence = None, None
    try:
        origin_main = git(root, "rev-parse", "--verify", "refs/remotes/origin/main").decode().strip()
        ahead, behind = map(int, git(root, "rev-list", "--left-right", "--count", "HEAD...refs/remotes/origin/main").split())
        divergence = {"ahead": ahead, "behind": behind}
        if ahead or behind:
            failures.append("HEAD and local origin/main are not aligned")
    except subprocess.CalledProcessError:
        failures.append("Local origin/main is unavailable; no fetch attempted")
    missing, unexpected = [], []
    if expected is not None:
        expected = set(map(expected_path, expected))
        missing, unexpected = sorted(expected - paths), sorted(paths - expected)
        if missing or unexpected:
            failures.append("Changed paths differ from the expected inventory")
    else:
        pending.append("Expected changed-path set not supplied; inventory comparison not performed.")
    if unmerged:
        failures.append("Unmerged paths require resolution")
    for cached in (False, True):
        args = ["diff", "--no-ext-diff", "--no-textconv", "--check"]
        if cached:
            args.append("--cached")
        label = "tracked whitespace (" + ("staged" if cached else "unstaged") + ")"
        try:
            git(root, *args)
            passed.append(label)
        except subprocess.CalledProcessError:
            failures.append(label + " failed")
    if doctor and not failures:
        helper = root / "tools/doctor.py"
        try:
            if ("tools/doctor.py" in paths or helper.is_symlink()
                    or not helper.is_file() or not helper.resolve().is_relative_to(root)):
                raise ValueError("doctor must be an unmodified, tracked regular file")
            git(root, "ls-files", "--error-unmatch", "--", "tools/doctor.py")
            result = subprocess.run([sys.executable, "-I", "-X", "utf8", "-B", str(helper)],
                                    cwd=root, capture_output=True, timeout=30)
            if result.returncode:
                failures.append("tools/doctor.py failed")
            else:
                passed.append("tools/doctor.py")
        except (ValueError, OSError, subprocess.SubprocessError) as error:
            failures.append("tools/doctor.py not executed: " + str(error).splitlines()[0])
    else:
        pending.append("tools/doctor.py not executed; use --doctor after successful repository checks.")
    protected = sorted(filter(is_protected, paths))
    return {
        "ROOT": str(root), "REPOSITORY": REPOSITORY if identity.lower() == REPOSITORY.lower() else "MISMATCH",
        "BRANCH": branch, "HEAD": head, "ORIGIN_MAIN": origin_main, "DIVERGENCE": divergence,
        "STAGED": staged, "UNSTAGED": unstaged, "UNTRACKED": untracked,
        "UNMERGED": unmerged, "RENAMES": renames, "MISSING": missing, "UNEXPECTED": unexpected,
        "WORK_KIND": "DOCS_ONLY" if all(path.endswith(".md") for path in paths) else "RUNTIME",
        "RISK": "PROTECTED" if protected else ("DOCS_ONLY" if all(path.endswith(".md") for path in paths) else "RUNTIME"),
        "PROTECTED": protected, "failures": failures, "passed": passed, "pending": pending,
    }


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--baseline", help="Optional expected full HEAD hash (no ref movement)")
    parser.add_argument("--expect-paths", nargs="*", help="Exact inventory, including both rename endpoints; not staging authorization")
    parser.add_argument("--doctor", action="store_true", help="Opt in to existing read-only doctor.py; skip modified/untracked helpers")
    args = parser.parse_args(argv)
    try:
        report = inspect(args.repo, args.baseline, args.expect_paths, args.doctor)
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        print("FAIL: Repository inspection incomplete: " + str(error).splitlines()[0])
        print("VERIFY_PENDING: Tests and independent review not executed.")
        return 1
    for key, value in report.items():
        if key not in {"failures", "passed", "pending"}:
            print(key + ": " + json.dumps(value))
    if report["failures"]:
        for failure in report["failures"]:
            print("FAIL: " + failure)
    elif not report["PROTECTED"]:
        print("PRECHECK_PASS: Executed repository/Git checks passed; local origin/main was not fetched. This is not test or review acceptance.")
    if report["PROTECTED"]:
        print("REVIEW_REQUIRED: Protected paths changed; this is not semantic or staging approval.")
    for check in report["passed"]:
        print("PASS: " + check)
    for check in report["pending"]:
        print("VERIFY_PENDING: " + check)
    return 1 if report["failures"] else (2 if report["PROTECTED"] else 0)


if __name__ == "__main__":
    raise SystemExit(main())
