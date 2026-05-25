# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `USER_DECISION_NEXT_FEATURE_PASS`
- Next recommended pass: `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS`
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
- Projection refresh policy is locked to POLICY_D (`PROJECT_ZIP` export-time refresh with global stale indicator).
- Flutter marks projection as stale after any local measurement event append.
- `known_facts.json` remains projection-owned by Python materializer; Flutter does not regenerate or mutate it directly in V1.
- Mobile export remains a placeholder flow in V1.
- Projection refresh policy is locked; stale UI scope-lock is next.
- `PROJECTION_STALE_UI_PASS` is accepted and implemented as display-only stale warning UI.
- `ProjectionStaleBanner` is shown on derived views when `ProjectState.isProjectionStale` is true and hidden otherwise.
- No refresh/export/materializer actions are introduced by the banner.
- No `known_facts.json` mutation, no event-writing changes, and no Project ZIP tooling changes were introduced.
- AUI-01 layout/content-flow issue for BoardGraph and CustomerReport stale banner is fixed.
- AUI-02 (exported report artifact absence test) is deferred to export/report validation.
- Project ZIP security hardening fixes are accepted:
  - `tools/export_project_zip.py` rejects symlinked files during ZIP export.
  - `tools/validate_project_zip.py` rejects non-portable absolute or traversal photo paths in `known_facts.json`.
- `FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS` is accepted and locks V1 export scope:
  - Desktop/dev export direction is permitted to be implemented later.
  - Mobile export remains placeholder in V1.
  - Flutter must not mutate `known_facts.json` directly.
  - Python materializer remains the only canonical known-facts projection owner.
  - No ZIP contract expansion.
- `FLUTTER_ZIP_EXPORT_PASS` is implemented:
  - `ProjectExporter` added as a narrow desktop export handoff service.
  - Desktop path uses Python discovery (`py -3` then `python3`, then `python`).
  - Export flow always runs `tools/materialize_known_facts.py` before `tools/export_project_zip.py`.
  - Success path writes sibling `.../<project_id_or_folder>_export.zip`.
  - Mobile export remains placeholder via explicit user message.
  - Export success does not clear stale state.
- Export audit/polish series is completed:
  - `FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS` completed with `PASS_WITH_NITS`.
  - `FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS` fixed `FZ-02` with sanitized failure messages.
  - `FZ-01` is formally closed as V1 accepted risk and deferred to `FLUTTER_PROCESS_LIFECYCLE_HARDENING_PASS` only if timeout issues appear in practice.
- `TOOLS_EMPTY_PROJECT_SUPPORT_PASS` is implemented:
  - `tools/materialize_known_facts.py` now materializes minimal valid `known_facts.json` when `events.jsonl` is empty/whitespace only.
  - New project IDs are taken from `manifest.json` when available; otherwise `unknown`.
  - Empty project export/validate/import round-trip is supported.

- Next milestone decision: implement `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS` to enable blank-project creation flow after tools support.

## Validation baseline

- `py -3 tools\validate_all.py`
- Flutter test is required only when Flutter/Dart changes are made, otherwise not required for docs-only passes.

## Memory pointers

- Stable truth: [docs/PROJECT_MEMORY.md](PROJECT_MEMORY.md)
- Next-step logic: [docs/PASS_QUEUE.md](PASS_QUEUE.md)
- Current scope lock: [docs/ACTIVE_SCOPE_LOCK.md](ACTIVE_SCOPE_LOCK.md)
- Audit evidence: [docs/AUDIT_INDEX.md](AUDIT_INDEX.md)

