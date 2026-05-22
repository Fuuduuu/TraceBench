#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REQUIRED = [
    "AGENTS.md",
    "docs/PROJECT_MEMORY.md",
    "docs/ACTIVE_SCOPE_LOCK.md",
    "docs/SOURCES_INDEX_CURRENT.md",
    "docs/MEMORY_REGISTRY.yml",
    "schemas/events.schema.json",
    "samples/pelle_pv20_minimal/events.jsonl",
]

missing = [p for p in REQUIRED if not (ROOT / p).exists()]
if missing:
    for p in missing:
        print(f"[ERROR] missing {p}")
    raise SystemExit(1)
print("[OK] doctor passed")
