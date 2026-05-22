# PROJECT_ZIP_SKELETON_PASS

Status: completed
Lane: TOOLS_PASS

Summary:
- Implemented Project ZIP export/import/validation skeleton tooling.
- Added minimal V1 Project ZIP contract documentation in `docs/PROJECT_ZIP_SPEC.md`.
- Added sample export artifacts for the Pelle PV20 minimal project.

Files changed:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PROJECT_ZIP_SPEC.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- tools/export_project_zip.py
- tools/import_project_zip.py
- tools/validate_project_zip.py
- tools/validate_all.py
- tests/test_project_zip.py
- samples/pelle_pv20_minimal/manifest.json
- samples/pelle_pv20_minimal/exports/customer_report.md
- samples/pelle_pv20_minimal/metadata/schema_versions.json
- docs/audit/PROJECT_ZIP_SKELETON_PASS.md

ZIP contract implemented:
- Required paths: `manifest.json`, `events.jsonl`, `known_facts.json`,
  `metadata/schema_versions.json`, `device_profiles/`, `exports/customer_report.md`.
- Optional paths: `photos/`, `notes/`, `exports/`.
- Export regenerates `known_facts.json` when missing or stale.
- Export validates known file exclusions and produces deterministic ZIP entries.
- Import validates contents after safe extraction with zip-slip checks.
- Validation supports zip file or extracted directory and validates manifest,
  events, known facts JSON parsing, and schema versions JSON parsing.

Verification:
- py -3 tools\validate_all.py

Out-of-scope:
- cloud sync
- live merge
- UI implementation
- photo processing beyond optional file pass-through
- secrets handling beyond exclusion patterns
