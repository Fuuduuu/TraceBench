import hashlib
from pathlib import Path
import unittest


class AssetSampleSyncTests(unittest.TestCase):
    def _sha256(self, path: Path) -> str:
        with path.open('rb') as f:
            return hashlib.sha256(f.read()).hexdigest()

    def test_asset_samples_match_source_samples(self):
        base = Path(r"C:/Users/Kasutaja/Desktop/TraceBench")
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

