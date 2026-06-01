# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_EXPORTER_TEST_FIX_CLOSEOUT_PASS`

## Goal

Record the accepted closeout for `PROJECT_EXPORTER_TEST_FIX_PASS` and preserve scope discipline.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_PASS.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_CLOSEOUT_PASS.md`

## Forbidden surfaces

- `tools/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `events.jsonl`
- `known_facts.json`
- `materializer/**`
- `schemas/**`
- `Project ZIP tooling/contracts`
- runtime/schema/materializer/sample/model changes
- path/storage/model expansion
- Board Canvas overlay/alignment/transform/photo-layer work
- AI/OCR/CV/proposal UI
- event-writing/edit/confirm/save/apply controls
- reference-image URL import/download
- `lib/features/reference_images/services` / path-clamp changes
- metadata grouping expansion
- missing/error/unsupported state rewrite
- accessibility overhaul
- responsive layout rewrite.

## Scope boundary (lock)

Closeout state:

- `PROJECT_EXPORTER_TEST_FIX_PASS` is accepted and remains test-only.
- Post-audit result was `PASS` with `ACCEPT_AS_IS`.
- No production behavior changes were introduced.
- The remaining issue from implementation is a harmless redundant assertion (no patch required).
- `PROJECT_EXPORTER_TEST_FIX_CLOSEOUT_PASS` remains docs-only and does not open implementation scope.

## Next recommended pass

`PROMPT_PROTOCOL_GUARD_CLAUSES_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded --plain-name "ProjectExporter falls back to python3/python when earlier candidates fail"`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools\validate_all.py`
