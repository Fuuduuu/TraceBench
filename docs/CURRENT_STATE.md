# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`
- Next recommended pass: `LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`
- Docs drift countdown: `0`

## Handoff snapshot (compact)

### Accepted board-canvas readiness chain
- `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS` and closeout are accepted (`PASS` / `PREFER_METADATA_ONLY_NEXT`).
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS` is accepted.
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS` is accepted.
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS` and closeout are accepted (`PASS`).
- `BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS` and closeout are accepted (`PASS`).

### Accepted photo-alignment data chain
- `photo_to_board_alignment_confirmed` schema + validator support is accepted.
- `known_facts.photo_to_board_alignments` materializer projection is accepted.
- `known_facts` schema support for `photo_to_board_alignments` is accepted.
- Dart KnownFacts support for `photoToBoardAlignments` is accepted.
- Materializer and Dart QA hardening passes are accepted.

### Current board-canvas photo-alignment UI meaning (locked)
- UI support is metadata-only readiness/status display.
- Readiness panel is project/photo-level, not per-component identity.
- Reference points are displayed as pair count only (no raw `x/y`).
- `transform_type` is labeled `declared type — not computed`.
- Required safety copy remains mandatory.
- `renderer writes: none` remains visible.

### Still deferred
- Full board-canvas photo-alignment UI workflow.
- Background photo helper.
- Transform/matrix computation.
- Photo-local evidence conversion onto board canvas.
- visual_trace/damage/suspect canvas geometry rendering.
- Event-writing/confirm/save/apply alignment controls.
- Project ZIP contract changes.

### Hard boundaries (unchanged)
- `events.jsonl` is canonical event truth.
- `known_facts.json` is Python-materialized projection.
- Renderer/view code writes nothing.
- `board_graph.json` and `view_state.json` remain forbidden.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- `visual_trace` is visual-only and not a net.
- Damage is not fault proof.
- Suspect is not probability.
- AI proposals are non-canonical until explicit accepted human-confirmed paths.

### Live-lite smoke-test planning (accepted)
- Manual runbook exists at `docs/BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md`.
- It captures commands, visual checklist, forbidden-behavior checklist, evidence boundaries, observations template, and stop conditions for Windows local smoke runs.

### Live-lite smoke test run (accepted)
- Manual smoke run completed on Windows target after live-lite plan pass.
- `py -3 tools\validate_all.py` passed; expected warning for missing optional `photos/top_backlight_001.jpg` was observed.
- App launched with `flutter run -d windows`; `flutter run -d chrome` failed because Chrome device was unavailable.
- Project overview opened and `Board Canvas` was reachable through normal UI navigation.
- Board canvas showed expected empty-state copy and `renderer writes: none`.
- Board graph remained separate from board canvas.
- Known facts/events/report surfaces opened and were readable.
- Current opened project lacked confirmed visual placements and visible `photo_to_board_alignments`, so positive board-canvas placement rendering and readiness-panel positive-state behavior were not validated in this run.
- Smoke verdict: `PASS_WITH_FINDINGS`.

### Positive smoke fixture implementation (accepted)
- Dedicated deterministic fixture project created: `samples/board_canvas_positive_smoke`.
- Fixture contains an 8-event accepted chain (`evt_000001`..`evt_000008`) covering:
  - component + pins,
  - measurement metadata,
  - visual trace metadata,
  - `board_normalized` visual placement,
  - accepted `photo_to_board_alignment_confirmed`.
- `known_facts.json` was generated with materializer and includes:
  - `components`, `pins`, `measurements`, `visual_traces`,
  - `component_visual_placements`,
  - `photo_to_board_alignments`.
- Asset mirror added at `assets/samples/board_canvas_positive_smoke` with byte-identical checked files.
- Sync test coverage extended in `tests/test_asset_sample_sync.py` for fixture manifest/events/known_facts/report parity.
- No schema/tool/lib/runtime/Project-ZIP behavior changes were made.
- Claude Code audit verdict: `PASS_WITH_NITS`.
- Non-blocking notes:
  - `ACTIVE_SCOPE_LOCK.md` pointer alignment required in closeout.
  - `validate_all.py` does not auto-validate the new fixture; fixture pass relied on explicit per-fixture validation commands.
- Route next to `LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`.

### Live positive smoke planning (current)
- Practical manual positive smoke runbook added at:
  - `docs/BOARD_CANVAS_LIVE_POSITIVE_SMOKE_TEST_PLAN.md`
- Runbook targets fixture:
  - `samples/board_canvas_positive_smoke`
  - `project_id: prj_board_canvas_smoke_001`
- Opening strategy documented with explicit commands:
  - Option A: open fixture directory directly (if app supports directory-open UI flow).
  - Option B: export fixture to ZIP, validate ZIP, then import/open.
- Runbook includes explicit positive checks for:
  - Board Canvas route/open state,
  - `renderer writes: none`,
  - SMP001 rendered placement and selector behavior,
  - read-only inspector with M1001 and VT001 visibility,
  - readiness panel with ALN1001, source photo, reference-pair count, and required safety copy.
- Runbook includes forbidden observation checklist, evidence-boundary checklist, screenshot/notes template, pass/fail criteria, expected warnings, and stop conditions.
- Route next to `LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`.

## Canonical pointers
- Pass sequencing and countdown: `docs/PASS_QUEUE.md`
- Active scope allowlist/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Stable product invariants: `docs/PROJECT_MEMORY.md`
- Audit index: `docs/AUDIT_INDEX.md`
- Detailed pass evidence: `docs/audit/*.md`
