# PRE_FLUTTER_VIEWER_DATA_CONTRACT_FIXUP_PASS

Status: completed
Lane: TOOLS_PASS

Summary:
- Hardened pre-Flutter data contract checks across validators and Project ZIP tooling.
- Enforced event schema-aligned payload validation in `tools/validate_events_jsonl.py`.
- Added known-facts `pins` materialization and stale-measurement net-connection guard in `tools/materialize_known_facts.py`.
- Hardened Project ZIP validation to compare regenerated known-facts materialization and project_id consistency.
- Updated import flow to validate in temporary staging and only materialize output on success.

Files changed:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/PROJECT_STATE.yml
- docs/PROJECT_ZIP_SPEC.md
- schemas/known_facts.schema.json
- tools/validate_events_jsonl.py
- tools/materialize_known_facts.py
- tools/validate_project_zip.py
- tools/import_project_zip.py
- tools/export_project_zip.py
- tests/test_validate_events_jsonl.py
- tests/test_materialize_known_facts.py
- tests/test_project_zip.py
- tests/test_schema_samples.py
- schemas/samples/valid_measurement_recorded.json
- schemas/samples/valid_repair_action_recorded.json
- docs/audit/PRE_FLUTTER_VIEWER_DATA_CONTRACT_FIXUP_PASS.md
- samples/pelle_pv20_minimal/known_facts.json

Pro audit findings addressed:
- Clarified and enforced allowed event type and status validation in validator.
- Added unknown-field and created_at ISO checks to prevent malformed envelopes.
- Enforced `measurement_recorded` raw lifecycle constraints and legacy field rejection.
- Added visual/evidence suppression for measured net confirmations.
- Added pin materialization and conservative stale-measurement net confirmation filtering.
- Added deterministic Project ZIP validation behavior including known-facts regeneration and project_id agreement.

Validation command:
- py -3 tools\validate_all.py
- python tools\validate_all.py

Deferred items:
- connected-net invalidation implementation
- event-writing from UI
- Dart-side validator parity
- camera/OCR/CV
- AI/fault probability
- source search

No code changes were made for Flutter implementation in this pass.
