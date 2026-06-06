# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_VALUES_PANEL_IMPL_PASS`

## Lane

`CODEX / FLUTTER_PASS`

## Next recommended pass

`REFERENCE_VALUES_PANEL_IMPL_POST_AUDIT_PASS`

## Scope

Scoped Flutter/docs/test implementation of the previously accepted display-only Reference Values Panel.

Implement the panel inside or near the existing read-only Measure Sheet shell as the smallest safe integration point. The panel must distinguish measured, reference/source, candidate, and note values while reading only existing projection state and deriving display labels only.

## Write allowlist

- `lib/features/measure_sheet/**`
- `test/widget/measure_sheet_screen_test.dart`
- `test/widget/project_overview_screen_test.dart` only if changed behavior requires it
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/REFERENCE_VALUES_PANEL_IMPL_PASS.md`

## Forbidden surfaces

- Schemas, validators, tools, materializer behavior, and Project ZIP logic/contract.
- Board Canvas runtime or write/edit behavior.
- Reference Images runtime or sidecar behavior.
- AI/OCR/CV, source search, URL import, datasheet parser, or localStorage behavior.
- `events.jsonl`, `known_facts.json`, `board_graph.json`, `view_state.json`, generated artifacts, assets, samples, platform folders, tags, or release objects.
- Real Save Measurement, Add Component, Edit Component, event-writing, canonical fact creation, canonical field creation, file writes, provider mutation, project-data mutation, or persistence.

## Implementation boundaries

- Panel is display-only and writes nothing.
- Panel reads existing known-facts/projection state only.
- Measured values remain visually dominant and human-reading oriented.
- Reference/source, candidate, and note values are subordinate and clearly non-canonical/context/tentative.
- No automatic promotion to measured/canonical.
- No green/success styling that implies good/verified.
- No copy implying verified, confirmed, correct, diagnosed, good, AI-found, app-detected, net-confirmed, component-identified, or fault-probability claims.

## Validation

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat analyze`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test\widget\measure_sheet_screen_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`