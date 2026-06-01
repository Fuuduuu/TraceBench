# PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS

## PASS_ID
`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock. No code/tooling/runtime/samples changes in this pass.

## Context
- V1.1 hardening is active after RC verification and roadmap lock.
- `v1.0.0-rc1` exists and is present on origin.
- Manual post-smoke review noted a non-blocking Project ZIP export duplicate issue for `device_profiles/default.json`.
- `V1_1_POST_SMOKE_NEXT_ROUTE_REVIEW_PASS` routed to this scope-lock then implementation pass.

## Locked scope decision

- Next implementation pass: `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` (`TOOLS_PASS`).
- Scope is narrow and limited to Project ZIP export duplicate arc handling.
- Root cause confirmed:
  - ZIP builder collects `project_dir/device_profiles/default.json` via general project walk,
  - then collects `device_profiles/` again explicitly,
  - causing duplicate `device_profiles/default.json` archive names.
- The LOW defect is export-hygiene-only and non-blocking.

## Exact allowed implementation surface (locked)

- Implementation files:
  - `tools/export_project_zip.py`
  - `tests/test_project_zip.py`
- Governance/audit docs:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS.md`
- Optional docs clarification only if needed:
  - `docs/PROJECT_ZIP_SPEC.md` (only if duplicate-arc contract wording is still ambiguous)

## Required tests for next pass

1. Project ZIP export must contain no duplicate archive names.
2. `device_profiles/default.json` must appear exactly once when source project contains it under `device_profiles/default.json`.
3. Required ZIP contents remain present after dedup change.
4. Existing `tests.test_project_zip` suite continues to pass.

## Evidence boundaries preserved

- Human is the sensor, AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection only.
- `board_graph.json` and `view_state.json` remain forbidden artifacts.
- No event-writing UI or runtime behavior changes.
- No Project ZIP contract expansion in V1.1.
- No reference-image/AI/OCR/transform/photo-overlay implementation.

## Routing
- Current pass recorded as active scope-lock.
- Next recommended pass: `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS`.
