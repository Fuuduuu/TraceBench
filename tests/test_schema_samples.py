import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest


def _run_sample_validator(path: Path) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, "tools/validate_events_jsonl.py", str(path)],
        text=True,
        capture_output=True,
    )


def _validate_json_schema_subset(value, schema, path="$"):
    errors = []
    schema_type = schema.get("type")

    if schema_type == "object":
        if not isinstance(value, dict):
            return [f"{path}: expected object, got {type(value).__name__}"]
        for key in schema.get("required", []):
            if key not in value:
                errors.append(f"{path}.{key}: missing required property")
        for key, child_schema in schema.get("properties", {}).items():
            if key in value:
                errors.extend(_validate_json_schema_subset(value[key], child_schema, f"{path}.{key}"))
    elif schema_type == "array":
        if not isinstance(value, list):
            return [f"{path}: expected array, got {type(value).__name__}"]
    elif schema_type == "string":
        if not isinstance(value, str):
            return [f"{path}: expected string, got {type(value).__name__}"]
        min_length = schema.get("minLength")
        if isinstance(min_length, int) and len(value) < min_length:
            errors.append(f"{path}: expected minLength {min_length}, got {len(value)}")
        max_length = schema.get("maxLength")
        if isinstance(max_length, int) and len(value) > max_length:
            errors.append(f"{path}: expected maxLength {max_length}, got {len(value)}")
        pattern = schema.get("pattern")
        if isinstance(pattern, str) and re.search(pattern, value) is None:
            errors.append(f"{path}: value {value!r} does not match pattern {pattern!r}")

    if "const" in schema and value != schema["const"]:
        errors.append(f"{path}: expected const {schema['const']!r}, got {value!r}")
    return errors


def _minimal_known_facts(projection_provenance=None):
    known_facts = {
        "project_id": "prj_schema_test",
        "components": [],
        "pins": [],
        "measurements": [],
        "nets": [],
        "excluded_from_fault_candidates": [],
    }
    if projection_provenance is not None:
        known_facts["projection_provenance"] = projection_provenance
    return known_facts


def _known_facts_schema_errors(known_facts):
    schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
    return _validate_json_schema_subset(known_facts, schema)


class ProjectionProvenanceSchemaTests(unittest.TestCase):
    def test_legacy_known_facts_without_provenance_remain_valid(self):
        self.assertEqual(_known_facts_schema_errors(_minimal_known_facts()), [])

    def test_valid_and_future_version_envelopes_are_representable(self):
        for version in ("1.0", "2.0-future"):
            with self.subTest(version=version):
                known_facts = _minimal_known_facts(
                    {
                        "projection_contract_version": version,
                        "events_sha256": "a" * 64,
                    }
                )
                self.assertEqual(_known_facts_schema_errors(known_facts), [])

    def test_projection_provenance_requires_both_members(self):
        invalid_envelopes = (
            {"events_sha256": "a" * 64},
            {"projection_contract_version": "1.0"},
        )
        for envelope in invalid_envelopes:
            with self.subTest(envelope=envelope):
                self.assertTrue(_known_facts_schema_errors(_minimal_known_facts(envelope)))

    def test_projection_contract_version_must_be_non_empty(self):
        known_facts = _minimal_known_facts(
            {
                "projection_contract_version": "",
                "events_sha256": "a" * 64,
            }
        )
        self.assertTrue(_known_facts_schema_errors(known_facts))

    def test_projection_provenance_rejects_malformed_hashes(self):
        invalid_hashes = ("A" * 64, "a" * 63, "a" * 65, "g" * 64, "a" * 64 + "\n")
        for events_sha256 in invalid_hashes:
            with self.subTest(events_sha256=events_sha256):
                known_facts = _minimal_known_facts(
                    {
                        "projection_contract_version": "1.0",
                        "events_sha256": events_sha256,
                    }
                )
                self.assertTrue(_known_facts_schema_errors(known_facts))


class SchemaSamplesTests(unittest.TestCase):
    def test_schema_samples_validate_with_validator(self):
        sample_dir = Path("schemas/samples")
        for sample in sorted(sample_dir.glob("*.json")):
            if sample.name == "valid_damage_region_marked.json":
                continue
            result = _run_sample_validator(sample)
            message = f"{sample}: {result.stdout + result.stderr}"
            if sample.name.startswith("invalid_"):
                self.assertNotEqual(result.returncode, 0, message)
            else:
                self.assertEqual(result.returncode, 0, message)

    def test_valid_photo_added_sample_validates(self):
        sample = Path("schemas/samples/valid_photo_added.json")
        result = _run_sample_validator(sample)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        payload = json.loads(sample.read_text(encoding="utf-8")).get("payload", {})
        self.assertIn("photo_id", payload)
        self.assertIn("mode", payload)
        self.assertIn("path", payload)

    def test_valid_damage_region_sample_validates_with_photo_context(self):
        photo_sample = json.loads(
            Path("schemas/samples/valid_photo_added.json").read_text(encoding="utf-8")
        )
        damage_sample = json.loads(
            Path("schemas/samples/valid_damage_region_marked.json").read_text(encoding="utf-8")
        )
        with tempfile.NamedTemporaryFile(mode="w", suffix=".jsonl", delete=False, encoding="utf-8") as handle:
            handle.write(json.dumps(photo_sample) + "\n")
            handle.write(json.dumps(damage_sample) + "\n")
            temp_path = handle.name

        result = _run_sample_validator(Path(temp_path))
        Path(temp_path).unlink(missing_ok=True)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_valid_measurement_sample_is_hardened_raw_payload(self):
        path = Path("schemas/samples/valid_measurement_recorded.json")
        event = json.loads(path.read_text(encoding="utf-8"))
        payload = event.get("payload", {})

        self.assertIn("reading", payload)
        self.assertNotIn("valid_from_event_id", payload)
        self.assertNotIn("valid_until_event_id", payload)
        self.assertNotIn("validity_status", payload)
        self.assertNotIn("value", payload)
        self.assertNotIn("unit", payload)
        self.assertIsInstance(payload["reading"], dict)
        self.assertEqual(payload["reading"].get("kind"), "numeric")

    def test_known_facts_schema_has_pins(self):
        path = Path("schemas/known_facts.schema.json")
        schema = json.loads(path.read_text(encoding="utf-8"))
        required = set(schema.get("required", []))
        self.assertIn("pins", required)
        pins = schema.get("properties", {}).get("pins")
        self.assertIsNotNone(pins)
        item = pins.get("items", {})
        self.assertIn("component_id", set(item.get("required", [])))
        self.assertIn("pin_id", set(item.get("required", [])))

    def test_valid_repair_action_sample_has_typed_targets_and_invalidation_policy(self):
        path = Path("schemas/samples/valid_repair_action_recorded.json")
        event = json.loads(path.read_text(encoding="utf-8"))
        payload = event.get("payload", {})

        targets = payload.get("targets", [])
        self.assertEqual(len(targets), 1)
        self.assertIsInstance(targets[0], dict)
        self.assertIn(
            targets[0].get("target_type"),
            {"component", "area", "pin", "pad", "footprint", "net", "trace", "via", "connector"},
        )
        self.assertIn("target_id", targets[0])

        invalidation = payload.get("invalidation_policy")
        self.assertIsInstance(invalidation, dict)
        self.assertEqual(invalidation.get("direct_component_measurements"), "stale_after_repair")
        self.assertEqual(invalidation.get("connected_net_measurements"), "no_change")

    def test_schema_sample_validation_rejects_raw_lifecycle_and_string_targets(self):
        measurement = json.loads(Path("schemas/samples/valid_measurement_recorded.json").read_text(encoding="utf-8"))
        self.assertNotIn("valid_from_event_id", measurement["payload"])

        repair = json.loads(Path("schemas/samples/valid_repair_action_recorded.json").read_text(encoding="utf-8"))
        self.assertIsInstance(repair["payload"].get("targets"), list)
        self.assertIsInstance(repair["payload"]["targets"][0], dict)

        self.assertIn("invalidation_policy", repair["payload"])

    def test_no_pytest_dependency_required(self):
        target_files = [
            Path("tools/validate_all.py"),
            Path("tools/validate_events_jsonl.py"),
            Path("tools/materialize_known_facts.py"),
        ]
        for target in target_files:
            text = target.read_text(encoding="utf-8")
            self.assertFalse(
                re.search(r"\bpytest\b", text),
                f"{target} should not depend on pytest",
            )


if __name__ == "__main__":
    unittest.main()
