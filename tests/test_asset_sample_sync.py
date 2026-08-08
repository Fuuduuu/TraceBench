import hashlib
from pathlib import Path
import unittest


def _repo_root_from_test_file(test_file: Path) -> Path:
    return test_file.resolve().parents[1]


class AssetSampleSyncTests(unittest.TestCase):
    def _sha256(self, path: Path) -> str:
        with path.open('rb') as f:
            return hashlib.sha256(f.read()).hexdigest()

    def test_repository_root_follows_relocated_test_file(self):
        relocated_test_file = Path(
            r"D:\other_clone\TraceBench\tests\test_asset_sample_sync.py"
        )

        self.assertEqual(
            _repo_root_from_test_file(relocated_test_file),
            Path(r"D:\other_clone\TraceBench"),
        )

    def test_asset_samples_match_source_samples(self):
        base = _repo_root_from_test_file(Path(__file__))
        pairs = [
            (
                base / "samples/pelle_pv20_minimal/manifest.json",
                base / "assets/samples/pelle_pv20_minimal/manifest.json",
            ),
            (
                base / "samples/pelle_pv20_minimal/events.jsonl",
                base / "assets/samples/pelle_pv20_minimal/events.jsonl",
            ),
            (
                base / "samples/pelle_pv20_minimal/known_facts.json",
                base / "assets/samples/pelle_pv20_minimal/known_facts.json",
            ),
            (
                base / "samples/pelle_pv20_minimal/exports/customer_report.md",
                base / "assets/samples/pelle_pv20_minimal/exports/customer_report.md",
            ),
            (
                base / "samples/board_canvas_positive_smoke/manifest.json",
                base / "assets/samples/board_canvas_positive_smoke/manifest.json",
            ),
            (
                base / "samples/board_canvas_positive_smoke/events.jsonl",
                base / "assets/samples/board_canvas_positive_smoke/events.jsonl",
            ),
            (
                base / "samples/board_canvas_positive_smoke/known_facts.json",
                base / "assets/samples/board_canvas_positive_smoke/known_facts.json",
            ),
            (
                base / "samples/board_canvas_positive_smoke/exports/customer_report.md",
                base / "assets/samples/board_canvas_positive_smoke/exports/customer_report.md",
            ),
        ]

        for source, asset in pairs:
            with self.subTest(source=source.name):
                self.assertTrue(source.exists(), f"Missing source sample: {source}")
                self.assertTrue(asset.exists(), f"Missing bundled sample: {asset}")
                self.assertEqual(
                    self._sha256(source),
                    self._sha256(asset),
                    f"Asset mismatch for {source.name}",
                )


if __name__ == "__main__":
    unittest.main()
