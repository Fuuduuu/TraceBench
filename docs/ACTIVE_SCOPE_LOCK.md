# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROMPT_PROTOCOL_GUARD_CLAUSES_PASS`

## Goal

Add reusable prompt guard clauses to prevent known implementation failure patterns and route post-recovery next steps.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_PASS.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_CLOSEOUT_PASS.md`
- `docs/audit/PROMPT_PROTOCOL_GUARD_CLAUSES_PASS.md`

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

- Existing closeout state remains accepted:
  - `PROJECT_EXPORTER_TEST_FIX_PASS` is accepted and remains test-only.
  - post-audit result remains `PASS` with `ACCEPT_AS_IS`.
  - no production behavior changes were introduced.
  - a harmless redundant assertion remains non-blocking.
- New guard-lock goals are docs-only and include:
  - bounded recoveries for hanging/failing tests;
  - no full-screen/file rewrite in Flutter polish without explicit scope lock;
  - no real image decode in widget tests and no temp fs-heavy widget test patterns;
  - bounded wait helpers instead of indefinite settles;
  - small-slice UX sequencing for high-risk polish cards.

## Next recommended pass

`TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
