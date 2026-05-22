from pathlib import Path


def test_pelle_sample_exists():
    assert Path("samples/pelle_pv20_minimal/events.jsonl").exists()
    assert Path("samples/pelle_pv20_minimal/manifest.json").exists()
