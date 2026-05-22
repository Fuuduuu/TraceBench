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


if __name__ == "__main__":
    unittest.main()
