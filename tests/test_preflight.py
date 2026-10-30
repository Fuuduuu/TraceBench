"""Black-box Preflight contracts; Git mutations belong only to owned temp fixtures."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
TOOL = ROOT / "tools" / "preflight.py"
REMOTE = "https://github.com/Fuuduuu/TraceBench.git"
OLD_NAV = "lib/features/board_canvas/widgets/component_navigator.part.dart"
NEW_NAV = "lib/features/board_canvas/widgets/component_navigator.dart"
HOST = "lib/features/board_canvas/screens/board_canvas_screen.dart"
CANVAS_TEST = "test/widget/board_canvas_screen_test.dart"
NAV_TEST = "test/widget/component_navigator_test.dart"


def fields(result):
    values = {}
    for line in result.stdout.splitlines():
        key, separator, value = line.partition(": ")
        if separator:
            try:
                values[key] = json.loads(value)
            except json.JSONDecodeError:
                pass
    return values


class PreflightTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="tracebench-preflight-test-")
        owned = Path(self.temp.name).resolve()
        self.assertEqual(owned.parent, Path(tempfile.gettempdir()).resolve())
        self.addCleanup(self.temp.cleanup)
        self.repo = owned / "repo with spaces"
        self.repo.mkdir()
        self.env = dict(os.environ, GIT_OPTIONAL_LOCKS="0",
                        GIT_CONFIG_GLOBAL=os.devnull, GIT_CONFIG_NOSYSTEM="1",
                        PYTHONDONTWRITEBYTECODE="1")
        self.git("init", "-q", "-b", "main")
        self.git("remote", "add", "origin", REMOTE)
        self.write("tools/doctor.py", (ROOT / "tools/doctor.py").read_text())
        for name in ["AGENTS.md", "docs/PROJECT_MEMORY.md",
                     "docs/ACTIVE_SCOPE_LOCK.md", "docs/SOURCES_INDEX_CURRENT.md",
                     "docs/MEMORY_REGISTRY.yml", "schemas/events.schema.json",
                     "samples/pelle_pv20_minimal/events.jsonl"]:
            self.write(name, "fixture\n")
        self.write("README.md", "baseline\n")
        self.write(OLD_NAV, "\n".join(f"// navigator row {i}" for i in range(60)) + "\n")
        self.write(HOST, "// host\n")
        self.write(CANVAS_TEST, "// original Canvas tests\n")
        self.write("tools/validate_all.py", "raise AssertionError('must not run')\n")
        self.git("add", "--", "AGENTS.md", "README.md", "docs", "schemas",
                 "samples", "tools", "lib", "test")
        self.git("commit", "-qm", "fixture baseline")
        self.head = self.git("rev-parse", "HEAD").strip()
        self.git("update-ref", "refs/remotes/origin/main", self.head)

    def git(self, *args):
        # Even fixture setup cannot accidentally target the real checkout.
        self.repo.resolve().relative_to(Path(self.temp.name).resolve())
        result = subprocess.run(
            ["git", "--no-pager", "-c", "init.templateDir=",
             "-c", "core.hooksPath=.git/no-hooks", "-c", "core.autocrlf=false",
             "-c", "core.fsmonitor=false", "-c", "commit.gpgsign=false",
             "-c", "user.name=Preflight Fixture", "-c", "user.email=fixture@example.invalid",
             *args], cwd=self.repo, env=self.env, capture_output=True, text=True,
            encoding="utf-8", check=True)
        return result.stdout

    def write(self, name, text):
        path = self.repo / name
        path.resolve().relative_to(self.repo.resolve())
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text, encoding="utf-8", newline="\n")

    def run_tool(self, *args, baseline=True, repo=None):
        command = [sys.executable, "-X", "utf8", "-B", str(TOOL),
                   "--repo", str(repo or self.repo)]
        if baseline:
            command += ["--baseline", self.head]
        return subprocess.run(command + list(args), cwd=self.repo, env=self.env,
                              capture_output=True, text=True, encoding="utf-8")

    def snapshot(self):
        return {p.relative_to(self.repo).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
                for p in self.repo.rglob("*") if p.is_file()}

    def test_help_describes_read_only_usage(self):
        result = self.run_tool("--help")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--baseline", result.stdout)
        self.assertIn("--expect-paths", result.stdout)

    def test_clean_repository_has_precheck_pass_but_no_test_acceptance(self):
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        data = fields(result)
        self.assertEqual(data["STAGED"], [])
        self.assertEqual(data["UNSTAGED"], [])
        self.assertEqual(data["UNTRACKED"], [])
        self.assertIn("PRECHECK_PASS:", result.stdout)
        self.assertNotIn("FAIL:", result.stdout)
        self.assertNotIn("REVIEW_REQUIRED:", result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)
        self.assertNotIn("All tests passed", result.stdout)

    def test_dirty_document_is_reported_without_requiring_clean_checkout(self):
        self.write("README.md", "edited\n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["UNSTAGED"], ["README.md"])
        self.assertEqual(fields(result)["RISK"], "DOCS_ONLY")

    def test_index_worktree_and_untracked_are_separate(self):
        self.write("README.md", "staged\n")
        self.git("add", "--", "README.md")
        self.write("README.md", "staged plus unstaged\n")
        self.write("notes with spaces.md", "untracked\n")
        result = self.run_tool()
        data = fields(result)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(data["STAGED"], ["README.md"])
        self.assertEqual(data["UNSTAGED"], ["README.md"])
        self.assertEqual(data["UNTRACKED"], ["notes with spaces.md"])

    def test_space_and_unicode_paths_remain_whole(self):
        name = "docs/mõõte ühikud.md"
        self.write(name, "draft\n")
        result = self.run_tool("--expect-paths", name)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["UNTRACKED"], [name])

    def test_expected_paths_reject_unexpected_and_missing_members(self):
        self.write("stray.md", "unexpected\n")
        result = self.run_tool("--expect-paths", "wanted.md")
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(fields(result)["UNEXPECTED"], ["stray.md"])
        self.assertEqual(fields(result)["MISSING"], ["wanted.md"])
        self.assertNotIn("PRECHECK_PASS:", result.stdout)

    def test_explicit_empty_path_set_is_meaningful(self):
        self.assertEqual(self.run_tool("--expect-paths").returncode, 0)
        self.write("unexpected.md", "new\n")
        result = self.run_tool("--expect-paths")
        self.assertEqual(result.returncode, 1)
        self.assertEqual(fields(result)["UNEXPECTED"], ["unexpected.md"])

    def test_deleted_path_is_not_filtered_out_because_file_is_missing(self):
        (self.repo / "README.md").unlink()
        result = self.run_tool("--expect-paths", "README.md")
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["UNSTAGED"], ["README.md"])

    def test_staged_deletion_is_separate_from_worktree_changes(self):
        (self.repo / "README.md").unlink()
        self.git("add", "--", "README.md")
        result = self.run_tool("--expect-paths", "README.md")
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["STAGED"], ["README.md"])
        self.assertEqual(fields(result)["UNSTAGED"], [])

    def move_navigator(self, stage=True):
        old, new = self.repo / OLD_NAV, self.repo / NEW_NAV
        old.resolve().relative_to(self.repo.resolve())
        new.resolve().relative_to(self.repo.resolve())
        old.rename(new)
        if stage:
            self.git("add", "--", OLD_NAV, NEW_NAV)

    def test_navigator_rename_has_all_five_logical_changed_paths(self):
        self.move_navigator()
        self.write(HOST, "// imported independent Navigator\n")
        self.write(CANVAS_TEST, "// boundary retarget\n")
        self.write(NAV_TEST, "// independent widget tests\n")
        self.git("config", "diff.renames", "false")
        self.git("config", "status.renames", "false")
        result = self.run_tool("--expect-paths", OLD_NAV, NEW_NAV, HOST, CANVAS_TEST, NAV_TEST)
        data = fields(result)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(data["STAGED"], [NEW_NAV, OLD_NAV])
        self.assertEqual(data["UNSTAGED"], [HOST, CANVAS_TEST])
        self.assertEqual(data["UNTRACKED"], [NAV_TEST])
        self.assertEqual(data["RENAMES"], [{"from": OLD_NAV, "to": NEW_NAV, "xy": "R."}])

    def test_renamed_destination_can_also_have_unstaged_edits(self):
        self.move_navigator()
        self.write(NEW_NAV, (self.repo / NEW_NAV).read_text() + "// later edit\n")
        result = self.run_tool("--expect-paths", OLD_NAV, NEW_NAV)
        data = fields(result)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(data["STAGED"], [NEW_NAV, OLD_NAV])
        self.assertEqual(data["UNSTAGED"], [NEW_NAV])

    def test_unstaged_move_remains_delete_plus_untracked_without_staging(self):
        self.move_navigator(stage=False)
        result = self.run_tool("--expect-paths", OLD_NAV, NEW_NAV)
        data = fields(result)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(data["STAGED"], [])
        self.assertEqual(data["UNSTAGED"], [OLD_NAV])
        self.assertEqual(data["UNTRACKED"], [NEW_NAV])
        self.assertEqual(data["RENAMES"], [])

    def test_rename_checks_protected_original_path(self):
        old, new = "schemas/events.schema.json", "docs/moved schema.txt"
        (self.repo / old).rename(self.repo / new)
        self.git("add", "--", old, new)
        result = self.run_tool("--expect-paths", old, new)
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertIn(old, fields(result)["PROTECTED"])
        self.assertIn("REVIEW_REQUIRED:", result.stdout)

    def test_protected_paths_cannot_be_downgraded_to_ordinary_work(self):
        for name in ["schemas/new.schema.json", "tools/materialize_known_facts.py",
                     "tools/event_writer_service.py", "tools/export_project_zip.py",
                     "lib/shared/session/project_session.dart",
                     "lib/features/components/services/v2_placement_writer.dart",
                     "lib/features/component_candidates/services/component_candidate_draft_store.dart",
                     "lib/features/component_candidates/models/component_candidate_draft.dart",
                     "lib/shared/services/project_loader.dart", "events.jsonl",
                     "lib/shared/services/project_creator.dart",
                     "lib/shared/services/project_projection_refresher.dart",
                     "lib/shared/widgets/workbench_projection_refresh.dart",
                     "lib/features/photos/services/photo_import_service.dart",
                     "docs/PROJECT_ZIP_SPEC.md"]:
            with self.subTest(path=name):
                self.write(name, "changed\n")
                result = self.run_tool()
                self.assertEqual(result.returncode, 2, result.stdout)
                self.assertEqual(fields(result)["RISK"], "PROTECTED")
                self.assertIn(name, fields(result)["PROTECTED"])

    def test_protected_doc_requires_review_without_flutter_recommendation(self):
        self.write("docs/PROJECTION_REFRESH_SPEC.md", "contract description\n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertEqual(fields(result)["WORK_KIND"], "DOCS_ONLY")
        self.assertNotIn("flutter test", result.stdout)

    def test_canonical_handoff_ui_paths_each_require_protected_review(self):
        for name in [
                "lib/features/board_canvas/widgets/board_canvas_placement_panel.dart",
                "lib/features/board_canvas/widgets/component_identity_panel.dart",
                "lib/features/board_canvas/widgets/integrated_measure_panel.dart",
                "lib/features/components/screens/add_component_screen.dart",
                "lib/features/components/screens/edit_component_screen.dart",
                "lib/features/measure_sheet/screens/measure_sheet_screen.dart",
                "lib/features/photos/widgets/photo_workbench_panel.dart",
                "lib/features/report/screens/customer_report_screen.dart"]:
            with self.subTest(path=name):
                self.write(name, "// canonical handoff UI\n")
                try:
                    result = self.run_tool()
                    self.assertEqual(result.returncode, 2, result.stdout)
                    self.assertEqual(fields(result)["RISK"], "PROTECTED")
                    self.assertEqual(fields(result)["PROTECTED"], [name])
                    self.assertIn("REVIEW_REQUIRED:", result.stdout)
                    self.assertIn("VERIFY_PENDING:", result.stdout)
                finally:
                    (self.repo / name).unlink()

    def test_ordinary_feature_ui_paths_remain_runtime(self):
        for name in [HOST,
                     "lib/features/board_canvas/widgets/placement_template_preview.dart",
                     "lib/features/board_canvas/widgets/component_navigator.dart",
                     "lib/features/photos/screens/photo_list_screen.dart"]:
            with self.subTest(path=name):
                self.write(name, "// ordinary presentation\n")
                result = self.run_tool()
                self.assertEqual(result.returncode, 0, result.stdout)
                self.assertEqual(fields(result)["RISK"], "RUNTIME")
                self.assertEqual(fields(result)["PROTECTED"], [])

    def test_protected_review_does_not_emit_precheck_pass(self):
        self.write("lib/shared/session/project_session.dart", "// protected\n")
        before = self.snapshot()
        result = self.run_tool()
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertIn("REVIEW_REQUIRED:", result.stdout)
        self.assertNotIn("PRECHECK_PASS:", result.stdout)
        self.assertNotIn("FAIL:", result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)
        self.assertEqual(self.snapshot(), before)

    def test_failure_takes_precedence_over_protected_review(self):
        self.write("schemas/events.schema.json", "changed\n")
        before = self.snapshot()
        result = self.run_tool("--baseline", "0" * 40)
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(fields(result)["RISK"], "PROTECTED")
        self.assertIn("FAIL:", result.stdout)
        self.assertIn("REVIEW_REQUIRED:", result.stdout)
        self.assertNotIn("PRECHECK_PASS:", result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)
        self.assertEqual(self.snapshot(), before)

    def test_runtime_file_recommends_flutter_checks_without_running_them(self):
        self.write("lib/new_widget.dart", "// new UI\n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["RISK"], "RUNTIME")
        self.assertIn("flutter analyze --no-pub", result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)

    def test_python_change_recommends_its_focused_tests(self):
        self.write("tools/small_tool.py", "pass\n")
        self.write("tests/test_small_tool.py", "# proposed tests\n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("-p test_small_tool.py", result.stdout)

    def test_wrong_remote_is_a_failure(self):
        self.git("remote", "set-url", "origin", "https://github.com/Someone/Other.git")
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertIn("FAIL:", result.stdout)
        self.assertNotIn("PRECHECK_PASS:", result.stdout)

    def test_ssh_remote_identifies_the_same_repository(self):
        self.git("remote", "set-url", "origin", "git@github.com:Fuuduuu/TraceBench.git")
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)

    def test_incorrect_expected_baseline_fails(self):
        result = self.run_tool("--baseline", "0" * 40)
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertIn("baseline", result.stdout.lower())

    def test_missing_optional_baseline_is_explicitly_pending(self):
        result = self.run_tool(baseline=False)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)
        self.assertIn("baseline", result.stdout.lower())

    def test_local_origin_main_divergence_fails_without_fetching(self):
        self.write("README.md", "next commit\n")
        self.git("add", "--", "README.md")
        self.git("commit", "-qm", "fixture ahead")
        result = self.run_tool(baseline=False)
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(fields(result)["DIVERGENCE"], {"ahead": 1, "behind": 0})

    def test_wrong_branch_fails(self):
        self.git("checkout", "-qb", "fixture-branch")
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(fields(result)["BRANCH"], "fixture-branch")

    def test_behind_and_diverged_local_refs_fail(self):
        self.git("checkout", "-qb", "remote-fixture")
        self.write("remote.md", "remote-only commit\n")
        self.git("add", "--", "remote.md")
        self.git("commit", "-qm", "remote fixture")
        remote_head = self.git("rev-parse", "HEAD").strip()
        self.git("checkout", "-q", "main")
        self.git("update-ref", "refs/remotes/origin/main", remote_head)
        behind = self.run_tool()
        self.assertEqual(behind.returncode, 1, behind.stdout)
        self.assertEqual(fields(behind)["DIVERGENCE"], {"ahead": 0, "behind": 1})
        self.write("main.md", "local-only commit\n")
        self.git("add", "--", "main.md")
        self.git("commit", "-qm", "local fixture")
        self.head = self.git("rev-parse", "HEAD").strip()
        diverged = self.run_tool()
        self.assertEqual(diverged.returncode, 1, diverged.stdout)
        self.assertEqual(fields(diverged)["DIVERGENCE"], {"ahead": 1, "behind": 1})

    def test_missing_remote_ref_is_reported_not_fetched(self):
        self.git("update-ref", "-d", "refs/remotes/origin/main")
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(self.git("for-each-ref", "refs/remotes/origin/main"), "")

    def test_non_repository_is_a_concise_failure(self):
        other = Path(self.temp.name) / "not a repository"
        other.mkdir()
        result = self.run_tool(repo=other)
        self.assertEqual(result.returncode, 1)
        self.assertIn("FAIL:", result.stdout)
        self.assertNotIn("Traceback", result.stdout + result.stderr)

    def test_unmerged_state_fails(self):
        self.git("checkout", "-qb", "other")
        self.write("README.md", "other branch\n")
        self.git("add", "--", "README.md")
        self.git("commit", "-qm", "other")
        self.git("checkout", "-q", "main")
        self.write("README.md", "main branch\n")
        self.git("add", "--", "README.md")
        self.git("commit", "-qm", "main")
        self.git("update-ref", "refs/remotes/origin/main", "HEAD")
        self.head = self.git("rev-parse", "HEAD").strip()
        with self.assertRaises(subprocess.CalledProcessError) as merge:
            self.git("merge", "--no-commit", "other")
        self.assertEqual(merge.exception.returncode, 1)
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertEqual(fields(result)["UNMERGED"], ["README.md"])

    def test_doctor_is_opt_in_and_does_not_supply_test_evidence(self):
        result = self.run_tool("--doctor")
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("PASS: tools/doctor.py", result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)
        self.assertIn("not executed", result.stdout.lower())

    def test_doctor_failure_is_not_a_pass(self):
        (self.repo / "docs/PROJECT_MEMORY.md").unlink()
        result = self.run_tool("--doctor")
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertIn("doctor", result.stdout)
        self.assertNotIn("PRECHECK_PASS:", result.stdout)

    def test_modified_doctor_is_never_executed(self):
        self.write("tools/doctor.py", "from pathlib import Path\nPath('should-not-exist').touch()\n")
        result = self.run_tool("--doctor")
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertFalse((self.repo / "should-not-exist").exists())

    def test_default_does_not_run_even_a_modified_doctor(self):
        self.write("tools/doctor.py", "raise AssertionError('must not run')\n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("VERIFY_PENDING:", result.stdout)

    def test_command_preserves_files_index_refs_and_ignored_outputs(self):
        self.write("docs/local draft.md", "must survive\n")
        self.write("events.jsonl", "fixture data\n")
        self.write(".git/info/exclude", "generated/\n")
        self.write("generated/keep.txt", "ignored but preserved\n")
        before = self.snapshot()
        result = self.run_tool("--doctor")
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertEqual(self.snapshot(), before)
        self.assertFalse((self.repo / ".codex").exists())
        self.assertFalse((self.repo / "tools/__pycache__").exists())

    def test_configured_fsmonitor_is_not_executed(self):
        hook = Path(self.temp.name) / ("monitor.cmd" if os.name == "nt" else "monitor.sh")
        marker = self.repo / "hook-was-run"
        text = f'@echo off\necho called > "{marker}"\n' if os.name == "nt" else f'#!/bin/sh\ntouch "{marker}"\n'
        hook.write_text(text)
        hook.chmod(0o700)
        self.git("config", "core.fsmonitor", str(hook))
        result = self.run_tool()
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertFalse(marker.exists())

    def test_rename_destination_with_spaces_is_not_split(self):
        new = "docs/a moved README.md"
        (self.repo / "README.md").rename(self.repo / new)
        self.git("add", "--", "README.md", new)
        result = self.run_tool("--expect-paths", "README.md", new)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(fields(result)["STAGED"], ["README.md", new])
        self.assertEqual(fields(result)["RENAMES"], [{"from": "README.md", "to": new, "xy": "R."}])

    def test_tracked_whitespace_failure_is_not_a_precheck_pass(self):
        self.write("README.md", "trailing spaces  \n")
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertIn("FAIL: tracked whitespace (unstaged)", result.stdout)

    def test_staged_whitespace_failure_is_not_a_precheck_pass(self):
        self.write("README.md", "trailing spaces  \n")
        self.git("add", "--", "README.md")
        result = self.run_tool()
        self.assertEqual(result.returncode, 1, result.stdout)
        self.assertIn("FAIL: tracked whitespace (staged)", result.stdout)

    def test_nul_parser_preserves_embedded_separators_and_rejects_truncation(self):
        from tools.preflight import parse_status
        path = "docs/with spaces\tand\na newline.md"
        record = b"1 .M N... 100644 100644 100644 " + b"0" * 40 + b" " + b"0" * 40 + b" "
        self.assertEqual(parse_status(record + path.encode() + b"\0")[1], [path])
        for data in [record + b"missing nul", b"2 R. N... 100644 100644 100644 "
                     + b"0" * 40 + b" " + b"0" * 40 + b" R100 new.dart\0", b"invalid\0"]:
            with self.subTest(data=data), self.assertRaises(ValueError):
                parse_status(data)


if __name__ == "__main__":
    unittest.main()
