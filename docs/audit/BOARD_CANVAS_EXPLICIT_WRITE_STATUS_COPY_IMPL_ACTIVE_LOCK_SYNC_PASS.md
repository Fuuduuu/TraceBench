# BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

Verified before edits:

- branch: `main...origin/main`
- tracked diff: clean
- cached diff: clean
- `git diff --check`: clean
- latest pushed scope-lock commit: `e50c2e9` (`docs: lock board canvas explicit write status copy scope`)
- route before sync:
  - Current: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS`
  - Next: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

Known untracked scratch artifacts remained unmodified and unstaged.

## Route after sync

- Current: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Implementation pass armed

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings

- `board_canvas_screen.dart` still shows top badge copy `Ainult vaatamine · kirjutusi pole`.
- `board_canvas_screen.dart` still shows footer/status copy `renderer writes: none` through key `renderer_writes_none`.
- Placement save success copy is already truthful: `Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist.`
- Existing-idempotent save copy is already truthful: `See visuaalne paigutus oli juba salvestatud. Projektsioon vajab värskendamist.`
- Save guard copy remains:
  - `Vali olemasolev komponent enne salvestamist.`
  - `Salvestamiseks ava projekt kohalikust kaustast.`
- `Salvesta` is disabled unless `onConfirmPlacement` is non-null.
- `Muuda` is visible with an empty callback.
- `Kustuta` calls local reset/default behavior.
- `Tühista` calls the same local reset/default behavior.
- Widget tests assert current visible copy, action labels, source-boundary behavior, no-write paths, and explicit save behavior.

## Allowlist rationale

The required future change is localized to visible Board Canvas copy/action semantics and tests. No placement writer, project-open, rotation-normalization, schema, tool, materializer, validator, router, event, known-facts, sample, or `_incoming` file is required.

## Future implementation requirements

The future implementation must:

- distinguish renderer/painter read-only behavior from explicit panel `Salvesta` write behavior
- preserve `Salvesta` as the only canonical write trigger
- preserve save guards for missing selected component and missing local folder project
- preserve projection-stale success copy
- make `Muuda`, `Kustuta`, and `Tühista` labels/tooltips/copy match current actual behavior
- keep `Kustuta` and `Tühista` as no-write local draft paths
- update tests for visible copy and boundary assertions without weakening writer/no-write coverage

## Forbidden surfaces

The future implementation must not edit or change:

- placement writer contract/files
- Project Open From Directory behavior
- rotation normalization behavior
- schemas
- tools/materializer/validator/router
- `events.jsonl` / `known_facts.json`
- sample/project fixtures
- `_incoming`
- component identity
- pins/contacts/pads/nets/traces/electrical facts
- measurements
- visual-contact layout facts
- AI-authored facts
- repair conclusions

## Validation

Validation requested for this docs-only active-lock sync:

- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Audit status

DRAFTED / PENDING CLAUDE AUDIT.

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
