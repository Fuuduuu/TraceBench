import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile


ROOT = Path(__file__).resolve().parents[1]
SAMPLE_DIR = ROOT / "samples" / "pelle_pv20_minimal"


def _run_tool(args, **kwargs):
    command = [sys.executable] + args
    return subprocess.run(command, cwd=ROOT, text=True, capture_output=True, **kwargs)


def _export_project_zip(project_dir: Path, output_zip: Path) -> subprocess.CompletedProcess[str]:
    return _run_tool(["tools/export_project_zip.py", str(project_dir), str(output_zip)])


def _validate_project_zip(path: Path) -> subprocess.CompletedProcess[str]:
    return _run_tool(["tools/validate_project_zip.py", str(path)])


def _import_project_zip(project_zip: Path, output_dir: Path) -> subprocess.CompletedProcess[str]:
    return _run_tool(["tools/import_project_zip.py", str(project_zip), str(output_dir)])


def _rewrite_zip(source_zip: Path, target_zip: Path, mutate) -> None:
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir_path = Path(tmpdir)
        with ZipFile(source_zip, "r") as zf:
            zf.extractall(tmpdir_path)
        mutate(tmpdir_path)
        with ZipFile(target_zip, "w", ZIP_DEFLATED) as zf_out:
            for path in sorted(tmpdir_path.rglob("*")):
                if path.is_dir():
                    continue
                arcname = str(path.relative_to(tmpdir_path)).replace("\\", "/")
                zf_out.write(path, arcname)


def _ensure_project_profiles_dir(project_dir: Path) -> None:
    profiles_dir = project_dir / "device_profiles"
    profiles_dir.mkdir(exist_ok=True)
    profile_path = profiles_dir / "generic.json"
    if not profile_path.exists():
        profile_path.write_text("{}", encoding="utf-8")


def _set_first_photo_path(project_dir: Path, path_value: str) -> str:
    known_facts_path = project_dir / "known_facts.json"
    known_facts = json.loads(known_facts_path.read_text(encoding="utf-8"))
    photos = known_facts.get("photos")
    if isinstance(photos, list) and photos and isinstance(photos[0], dict):
        photos[0]["path"] = path_value
    else:
        known_facts.setdefault("photos", []).append({"photo_id": "photo_custom", "path": path_value})
    known_facts_path.write_text(json.dumps(known_facts, indent=2), encoding="utf-8")

    events_path = project_dir / "events.jsonl"
    lines = []
    updated = False
    for line in events_path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        event = json.loads(line)
        if (
            not updated
            and event.get("event_type") == "photo_added"
            and isinstance(event.get("payload"), dict)
        ):
            event["payload"]["path"] = path_value
            updated = True
        lines.append(json.dumps(event, separators=(",", ":"), ensure_ascii=False))
    events_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return known_facts_path.read_text(encoding="utf-8")


class ProjectZipTests(unittest.TestCase):
    def test_export_project_zip_creates_required_files(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

            with ZipFile(output_zip, "r") as zf:
                names = {name.replace("\\", "/") for name in zf.namelist()}
            required = {
                "manifest.json",
                "events.jsonl",
                "known_facts.json",
                "metadata/schema_versions.json",
                "exports/customer_report.md",
            }
            self.assertTrue(required.issubset(names))
            self.assertTrue(any(name.startswith("device_profiles/") for name in names))

    def test_validate_project_zip_accepts_exported_zip(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            validate_result = _validate_project_zip(output_zip)
            self.assertEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)

    def test_project_zip_validation_rejects_zip_slip(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_zip = Path(tmpdir) / "malicious.zip"
            with ZipFile(project_zip, "w", ZIP_DEFLATED) as zf:
                zf.writestr("safe.txt", "ok")
                zf.writestr("../evil.txt", "bad")

            validate_result = _validate_project_zip(project_zip)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("rejected unsafe zip member", validate_result.stdout.lower() + validate_result.stderr.lower())

    def test_project_zip_validation_rejects_mismatched_known_facts(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            good_zip = Path(tmpdir) / "good.zip"
            bad_zip = Path(tmpdir) / "bad.zip"

            export_result = _export_project_zip(SAMPLE_DIR, good_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            def mutate_known(path):
                known_path = path / "known_facts.json"
                known = json.loads(known_path.read_text(encoding="utf-8"))
                if known.get("measurements"):
                    known["measurements"].append({"measurement_id": "BAD001"})
                known_path.write_text(json.dumps(known, indent=2), encoding="utf-8")

            _rewrite_zip(good_zip, bad_zip, mutate_known)
            validate_result = _validate_project_zip(bad_zip)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("known_facts.json does not match materialization output", validate_result.stdout + validate_result.stderr)

    def test_project_zip_validation_rejects_project_id_mismatch(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            good_zip = Path(tmpdir) / "good.zip"
            bad_zip = Path(tmpdir) / "bad.zip"

            export_result = _export_project_zip(SAMPLE_DIR, good_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            def mutate_project_id(path):
                manifest_path = path / "manifest.json"
                manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
                manifest["project_id"] = "prj_other"
                manifest_path.write_text(json.dumps(manifest, indent=2), encoding="utf-8")

            _rewrite_zip(good_zip, bad_zip, mutate_project_id)
            validate_result = _validate_project_zip(bad_zip)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("project_id mismatch", validate_result.stdout.lower() + validate_result.stderr.lower())

    def test_import_project_zip_round_trip(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            tmpdir = Path(tmpdir)
            output_zip = tmpdir / "project.zip"
            output_dir = tmpdir / "imported"

            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            import_result = _import_project_zip(output_zip, output_dir)
            self.assertEqual(import_result.returncode, 0, import_result.stdout + import_result.stderr)

            self.assertTrue((output_dir / "manifest.json").exists())
            self.assertTrue((output_dir / "events.jsonl").exists())
            self.assertTrue((output_dir / "known_facts.json").exists())

    def test_import_does_not_leave_invalid_output_on_failed_validation(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            tmpdir = Path(tmpdir)
            project_zip = tmpdir / "invalid.zip"
            output_dir = tmpdir / "imported"

            with ZipFile(project_zip, "w", ZIP_DEFLATED) as zf:
                zf.writestr("manifest.json", "{}")

            result = _import_project_zip(project_zip, output_dir)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            if output_dir.exists():
                self.assertEqual(list(output_dir.iterdir()), [])

    def test_import_rejects_zip_slip(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            tmpdir = Path(tmpdir)
            project_zip = tmpdir / "malicious.zip"
            output_dir = tmpdir / "output"

            with ZipFile(project_zip, "w", ZIP_DEFLATED) as zf:
                zf.writestr("safe.txt", "ok")
                zf.writestr("../evil.txt", "bad")

            result = _import_project_zip(project_zip, output_dir)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("rejected unsafe zip member", result.stdout.lower() + result.stderr.lower())

    def test_export_rejects_symlinked_file(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)

            external_photo = Path(tmpdir) / "outside_secret.txt"
            external_photo.write_text("outside secret", encoding="utf-8")
            linked_photo = project_dir / "linked_secret.txt"
            try:
                linked_photo.symlink_to(external_photo)
            except OSError as exc:
                self.skipTest(f"symlink creation not supported: {exc}")

            output_zip = Path(tmpdir) / "project.zip"
            result = _export_project_zip(project_dir, output_zip)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            output = result.stdout.lower() + result.stderr.lower()
            self.assertIn("refusing to export symlinked path", output)
            if output_zip.exists():
                with ZipFile(output_zip, "r") as zf:
                    names = {name.replace("\\", "/") for name in zf.namelist()}
                self.assertNotIn("linked_secret.txt", names)
                self.assertNotIn("outside_secret.txt", names)

    def test_validate_rejects_posix_absolute_photo_path(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)

            _set_first_photo_path(project_dir, "/tmp/outside_secret.jpg")
            validate_result = _validate_project_zip(project_dir)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            output = validate_result.stdout.lower() + validate_result.stderr.lower()
            self.assertIn("absolute photo path is not portable", output)

    def test_validate_rejects_windows_absolute_photo_path(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)

            _set_first_photo_path(project_dir, "C:\\secret\\photo.jpg")
            validate_result = _validate_project_zip(project_dir)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            output = validate_result.stdout.lower() + validate_result.stderr.lower()
            self.assertIn("absolute photo path is not portable", output)

    def test_validate_rejects_photo_path_traversal(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)

            _set_first_photo_path(project_dir, "../outside_secret.jpg")
            validate_result = _validate_project_zip(project_dir)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            output = validate_result.stdout.lower() + validate_result.stderr.lower()
            self.assertIn("photo path traversal is not allowed", output)

    def test_export_excludes_codex_and_env_files(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)

            (project_dir / ".codex").mkdir()
            (project_dir / ".codex" / "secret.txt").write_text("secret", encoding="utf-8")
            (project_dir / ".env").write_text("API_KEY=abc", encoding="utf-8")
            pyc_dir = project_dir / "__pycache__"
            pyc_dir.mkdir()
            (pyc_dir / "bad.pyc").write_text("binary", encoding="utf-8")

            output_zip = Path(tmpdir) / "project.zip"
            result = _export_project_zip(project_dir, output_zip)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

            with ZipFile(output_zip, "r") as zf:
                names = {name.replace("\\", "/") for name in zf.namelist()}
            self.assertTrue(all(not name.startswith(".codex/") for name in names))
            self.assertNotIn(".env", names)
            self.assertTrue(all("__pycache__" not in name for name in names))
            self.assertTrue(all(not name.endswith(".pyc") for name in names))

    def test_export_zip_entry_order_is_deterministic(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            with ZipFile(output_zip, "r") as zf:
                names = zf.namelist()
            self.assertEqual(names, sorted(names))

    def test_project_zip_contains_customer_report(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            with ZipFile(output_zip, "r") as zf:
                report_text = zf.read("exports/customer_report.md").decode("utf-8")
            self.assertIn("Pelle PV20", report_text)

    def test_zip_rejects_board_graph_json(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            good_zip = Path(tmpdir) / "good.zip"
            bad_zip = Path(tmpdir) / "bad.zip"

            export_result = _export_project_zip(SAMPLE_DIR, good_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            def mutate(path):
                (path / "board_graph.json").write_text("{\"nodes\": []}\n", encoding="utf-8")

            _rewrite_zip(good_zip, bad_zip, mutate)
            validate_result = _validate_project_zip(bad_zip)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("forbidden V1 ZIP artifact", validate_result.stdout + validate_result.stderr)

    def test_zip_rejects_view_state_json(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            good_zip = Path(tmpdir) / "good.zip"
            bad_zip = Path(tmpdir) / "bad.zip"

            export_result = _export_project_zip(SAMPLE_DIR, good_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            def mutate(path):
                (path / "view_state.json").write_text("{\"state\": []}\n", encoding="utf-8")

            _rewrite_zip(good_zip, bad_zip, mutate)
            validate_result = _validate_project_zip(bad_zip)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("forbidden V1 ZIP artifact", validate_result.stdout + validate_result.stderr)

    def test_export_does_not_include_forbidden_v1_artifacts(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal_with_forbidden"
            shutil.copytree(SAMPLE_DIR, project_dir)

            (project_dir / "board_graph.json").write_text("{\"nodes\": []}\n", encoding="utf-8")
            (project_dir / "view_state.json").write_text("{\"zoom\": 1}\n", encoding="utf-8")

            output_zip = Path(tmpdir) / "project.zip"
            result = _export_project_zip(project_dir, output_zip)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

            with ZipFile(output_zip, "r") as zf:
                names = {name.replace("\\", "/") for name in zf.namelist()}
            self.assertNotIn("board_graph.json", names)
            self.assertNotIn("view_state.json", names)

    def test_project_dir_rejects_board_graph_json_if_directory_validation_supported(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)
            (project_dir / "board_graph.json").write_text("{\"nodes\": []}\n", encoding="utf-8")

            validate_result = _validate_project_zip(project_dir)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("forbidden V1 ZIP artifact", validate_result.stdout + validate_result.stderr)

    def test_project_dir_rejects_view_state_json_if_directory_validation_supported(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "pelle_pv20_minimal"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)
            (project_dir / "view_state.json").write_text("{\"zoom\": 1}\n", encoding="utf-8")

            validate_result = _validate_project_zip(project_dir)
            self.assertNotEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            self.assertIn("forbidden V1 ZIP artifact", validate_result.stdout + validate_result.stderr)

    def test_customer_report_boundary_forbids_inference_claims(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            with ZipFile(output_zip, "r") as zf:
                report_text = zf.read("exports/customer_report.md").decode("utf-8")
            report_lower = report_text.lower()
            forbidden_terms = [
                "diagnosis",
                "fault probability is",
                "fault probability estimate",
                "inferred nets",
                "inferred measurements",
                "inferred component identity",
            ]
            for term in forbidden_terms:
                self.assertNotIn(term, report_lower)
            # Explicitly allow informational scope notes such as:
            # "fault probability are out of scope" while still enforcing claim-free wording.
            self.assertNotIn("ai diagnosed", report_lower)

    def test_customer_report_keeps_visual_trace_non_electrical(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output_zip = Path(tmpdir) / "project.zip"
            export_result = _export_project_zip(SAMPLE_DIR, output_zip)
            self.assertEqual(export_result.returncode, 0, export_result.stdout + export_result.stderr)

            with ZipFile(output_zip, "r") as zf:
                report_text = zf.read("exports/customer_report.md").decode("utf-8")
            report_lower = report_text.lower()
            self.assertNotIn("visual trace measured", report_lower)
            self.assertNotIn("visual trace confirms", report_lower)

    def test_missing_optional_photo_file_is_warning_not_error(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            shutil.copytree(SAMPLE_DIR, project_dir)
            _ensure_project_profiles_dir(project_dir)

            validate_result = _validate_project_zip(project_dir)
            self.assertEqual(validate_result.returncode, 0, validate_result.stdout + validate_result.stderr)
            output = (validate_result.stdout + validate_result.stderr).lower()
            self.assertIn("[warn]", output)
            self.assertIn("missing optional photo file", output)


if __name__ == "__main__":
    unittest.main()
