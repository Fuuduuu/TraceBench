import json
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest


class MaterializeKnownFactsTests(unittest.TestCase):
    def test_materialize_known_facts(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            out = Path(tmpdir) / "known_facts.json"
            result = subprocess.run(
                [sys.executable, "tools/materialize_known_facts.py", "samples/pelle_pv20_minimal/events.jsonl", str(out)],
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            data = json.loads(out.read_text(encoding="utf-8"))
            self.assertEqual(data["project_id"], "prj_pelle_pv20_001")
            self.assertTrue(data["components"])
            self.assertTrue(data["measurements"])


if __name__ == "__main__":
    unittest.main()
