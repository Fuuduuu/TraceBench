# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS`

## Goal

Lock a docs-only scope pass for the test-order-isolated `ProjectExporter` fallback test fix.
Implementation is intentionally deferred to `PROJECT_EXPORTER_TEST_FIX_PASS` (`TEST_FIX_PASS`).

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_CLOSEOUT_PASS.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS.md`

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

Scope is docs-only and test-fix targeted:

- allowed implementation surface:
  - `test/unit/project_exporter_test.dart` only (for `PROJECT_EXPORTER_TEST_FIX_PASS`)
- lock the issue class:
  - order-dependent test isolation in the project exporter unit test file,
  - no production behavior changes unless real production bug is demonstrated.
- required test-fix properties:
  - deterministic pass-by-name and full-file execution,
  - no hidden shared state leaks across test cases,
- no temp-root/fake-runner leakage,
- no cross-test call-history leakage.
- prohibited implementation spillover:
  - Reference Images files,
  - Board Canvas scope,
  - Project ZIP contract or tooling,
  - schemas / materializer / events / known_facts / runtime behavior,
  - broad suite refactors.

## Next recommended pass

`PROJECT_EXPORTER_TEST_FIX_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded --plain-name "ProjectExporter falls back to python3/python when earlier candidates fail"`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools\validate_all.py`
