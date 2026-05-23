# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `DOCS_DRIFT_MINI_CLEANUP_04_PASS`
- Next recommended pass: `WORK_INTAKE_SELECTION_PASS` (`DOCS_SYNC`)
- Docs drift countdown: `5`

## Current accepted state snapshot

- Board graph materializer behavior is accepted (`BOARD_GRAPH_MATERIALIZER_PASS`).
- Read-only Flutter board graph view is accepted (`FLUTTER_GRAPH_VIEW_PASS`).
- Component removal is represented only by `repair_action_recorded(action_type="remove_component")` (`COMPONENT_EDIT_EVENT_MODEL_PASS`).
- `FLUTTER_PHOTO_LIST_PASS` is accepted:
  - `/project/photos` route is available.
  - Project Overview includes a Photos entry for read-only navigation.
  - Photo list is read-only and sourced from `known_facts.json`.
  - no camera, photo import, OCR/CV, or event-writing was introduced.
- `visual_trace` remains visual-only evidence; no automatic electrical promotion.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `DOCS_DRIFT_MINI_CLEANUP_04_PASS` is completed and routing drift is repaired.
- Current queue routing is set to `WORK_INTAKE_SELECTION_PASS`.
- Full prompt/memory governance path is stable.

## Validation baseline

- `py -3 tools\validate_all.py`
- Flutter test is required only when Flutter/Dart changes are made, otherwise not required for docs-only passes.

## Memory pointers

- Stable truth: [docs/PROJECT_MEMORY.md](PROJECT_MEMORY.md)
- Next-step logic: [docs/PASS_QUEUE.md](PASS_QUEUE.md)
- Current scope lock: [docs/ACTIVE_SCOPE_LOCK.md](ACTIVE_SCOPE_LOCK.md)
- Audit evidence: [docs/AUDIT_INDEX.md](AUDIT_INDEX.md)
