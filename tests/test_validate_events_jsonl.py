import subprocess
import sys
import unittest


class ValidateEventsJsonlTests(unittest.TestCase):
    def test_pelle_sample_validates(self):
        result = subprocess.run(
            [sys.executable, "tools/validate_events_jsonl.py", "samples/pelle_pv20_minimal/events.jsonl"],
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)


if __name__ == "__main__":
    unittest.main()
