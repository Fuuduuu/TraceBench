# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `LIVE_LITE_SMOKE_TEST_PLAN_PASS`
- Next recommended pass: `LIVE_LITE_SMOKE_TEST_RUN_PASS`
- Docs drift countdown: `2`

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

### Live-lite smoke-test planning (current)
- A focused manual runbook is defined in `docs/BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md`.
- Plan targets Windows local app launch and visual verification of accepted read-only board-canvas and readiness-panel behavior.
- Plan includes:
  - exact command sequence (`git` state, validation, `flutter devices`, run targets),
  - route/screen verification checklist,
  - forbidden UI/behavior checklist,
  - evidence-boundary checklist,
  - observation template,
  - pass/fail criteria and stop conditions.
- This pass is planning-only:
  - no implementation changes,
  - no automated test implementation,
  - no scope expansion into transform/background/overlay/event-writing surfaces.

## Canonical pointers
- Pass sequencing and countdown: `docs/PASS_QUEUE.md`
- Active scope allowlist/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Stable product invariants: `docs/PROJECT_MEMORY.md`
- Audit index: `docs/AUDIT_INDEX.md`
- Detailed pass evidence: `docs/audit/*.md`
