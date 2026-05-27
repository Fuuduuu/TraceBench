# ACTIVE_SCOPE_LOCK.md

## Current pass

`VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_CLOSEOUT_PASS`

## Goal

Close out the `VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_PASS` second-review result as docs-only with final verdict `PASS_WITH_NITS`, and route next pass by docs-drift policy.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_CLOSEOUT_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `tests/**`
- `samples/**`
- `assets/**`
- `lib/**`
- `test/**`
- `pubspec.yaml`
- `pubspec.lock`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter renderer/UI implementation
- `CustomPainter`
- canvas rendering implementation
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. Final closeout verdict is `PASS_WITH_NITS`.
2. Registry skeleton remains accepted as metadata/model/const registry only.
3. No renderer/UI, schema/tool/ZIP/event/projection, or AI proposal persistence scope is opened.
4. Next recommended pass is `DOCS_DRIFT_MINI_CLEANUP_12_PASS` because docs drift countdown is `0`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
