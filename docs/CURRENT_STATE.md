# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PASS_QUEUE_REVIEW_03_PASS`
- Next recommended pass: `USER_DECISION_PASS` (`DOCS_SYNC` / `DECISION_ONLY`)
- No safe non-loop implementation candidate remains; user direction is required before next product work.
- Docs drift countdown: `1`

## Current accepted state snapshot

- `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS` is accepted and limited to `measurement_recorded` only.
- `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS` appends one event to local unpacked `events.jsonl`, preserves prior event lines, and flags projection as stale/refresh required in UI state.
- `known_facts.json` is not mutated by measurement event writing and Project ZIP files are not directly written.
- `net_connection_confirmed`, component_created, pin_defined, photo, and annotation write paths were not introduced.
- No AI-authored measurement workflow was introduced; target, unit, and value are explicit user inputs.
- Board graph materializer behavior is accepted (`BOARD_GRAPH_MATERIALIZER_PASS`).
- Read-only Flutter board graph view is accepted (`FLUTTER_GRAPH_VIEW_PASS`).
- Component removal is represented only by `repair_action_recorded(action_type="remove_component")` (`COMPONENT_EDIT_EVENT_MODEL_PASS`).
- `FLUTTER_PHOTO_LIST_PASS` is accepted.
- `PROJECT_ZIP_REPORT_HARDENING_PASS` is accepted with ZIP artifact guards and evidence constraints.
- Visual evidence remains non-electrical (`visual_trace` is visual-only evidence).
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `DOCS_DRIFT_MINI_CLEANUP_04_PASS` and `SCOPE_DRIFT_CHECK_PROTOCOL_PASS` are completed.

## Validation baseline

- `py -3 tools\validate_all.py`
- Flutter test is required only when Flutter/Dart changes are made, otherwise not required for docs-only passes.

## Memory pointers

- Stable truth: [docs/PROJECT_MEMORY.md](PROJECT_MEMORY.md)
- Next-step logic: [docs/PASS_QUEUE.md](PASS_QUEUE.md)
- Current scope lock: [docs/ACTIVE_SCOPE_LOCK.md](ACTIVE_SCOPE_LOCK.md)
- Audit evidence: [docs/AUDIT_INDEX.md](AUDIT_INDEX.md)

