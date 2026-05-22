# PROJECT_ZIP_SPEC.md

## V1 Project ZIP contract

Project ZIP is a local transport format for a TraceBench project state.
It is not collaboration or cloud sync format and does not imply multi-device
live merge.

### Required ZIP paths

- `manifest.json`
- `events.jsonl`
- `known_facts.json`
- `metadata/schema_versions.json`
- `device_profiles/`
- `exports/customer_report.md`

### Optional ZIP paths

- `photos/`
- `notes/`
- `exports/`

### Rules

- ZIP must be self-contained and portable between machines.
- ZIP must not contain: `.git`, `.codex`, `__pycache__`, `.env`, API keys,
  secrets, local logs, or temporary/local artifacts.
- `events.jsonl` remains the source event log and canonical raw measurement log.
- `known_facts.json` is materialized/derived output and may be regenerated.
- Import must not mutate raw event semantics.
- Import validates content before accepting output.
- Export regenerates `known_facts.json` from `events.jsonl` before packaging,
  unless explicitly told not to.
- ZIP entry order is deterministic in V1 packaging; byte-for-byte
  determinism is not guaranteed across tools/environments.
- V1 import/export is file-copy and file-copy based; no cloud sync.
