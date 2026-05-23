# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PROMPT_MEMORY_SYSTEM_FULL_AUDIT_FIXUP_PASS`
- Next recommended pass: `DOCS_DRIFT_MINI_CLEANUP_03_PASS` (`DOCS_SYNC`)
- Docs drift countdown: `0`

## Current accepted state snapshot

- Board graph materializer behavior is accepted (`BOARD_GRAPH_MATERIALIZER_PASS`).
- Read-only Flutter board graph view is accepted (`FLUTTER_GRAPH_VIEW_PASS`).
- Component removal is represented only by `repair_action_recorded(action_type="remove_component")` (`COMPONENT_EDIT_EVENT_MODEL_PASS`).
- `BOARD_GRAPH_MATERIALIZER_PASS` includes component update patching, `component_marked_unknown`, and `component_pin_index`.
- Board graph view uses in-memory `BoardGraphProjection` with deterministic `graph_layout` and no persisted layout cache.
- Photo event schema hardening and consistency audit is accepted (`PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS`).
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` remains visual-only evidence; no automatic electrical promotion.
- Photo list/tab is future-scoped; no camera/OCR/CV or event-writing introduced.
- `repair_action_recorded` removal preserves component history and identity fields.
- Full prompt/memory governance audit (`PROMPT_MEMORY_SYSTEM_FULL_AUDIT_PASS`) found system structure sound; only stale current-pass pointers required docs-ledger fixup.

## Validation baseline

- `py -3 tools\validate_all.py`
- Flutter test is required only when Flutter/Dart changes are made in a pass, otherwise not required for docs-only passes.

## Memory pointers

- Stable truth: [docs/PROJECT_MEMORY.md](PROJECT_MEMORY.md)
- Next-step logic: [docs/PASS_QUEUE.md](PASS_QUEUE.md)
- Current scope lock: [docs/ACTIVE_SCOPE_LOCK.md](ACTIVE_SCOPE_LOCK.md)
- Audit evidence: [docs/AUDIT_INDEX.md](AUDIT_INDEX.md)
