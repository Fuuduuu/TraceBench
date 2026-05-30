# BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only UI scope lock.

## Baseline accepted state
- Photo-alignment schema/validator chain is accepted.
- Materializer projection to `known_facts.photo_to_board_alignments` is accepted.
- `known_facts` schema support is accepted.
- Dart KnownFacts support is accepted.
- Board-canvas readiness panel implementation is accepted.
- Readiness panel QA and combined-state readiness QA are accepted.
- Current board-canvas alignment UI support is metadata-only.

## Locked V1 UI meaning
Photo alignment UI in V1 remains readiness/status metadata only.

Allowed:
- read-only metadata display in board-canvas readiness context.

Not allowed:
- transform computation or matrix math,
- background photo helper,
- photo-local evidence rendering/conversion,
- visual_trace/damage/suspect board geometry rendering,
- event-writing alignment workflow,
- Project ZIP contract changes.

## Route options evaluated
- `A. LIVE_LITE_SMOKE_TEST_PLAN_PASS`
- `B. BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS`
- `C. BOARD_CANVAS_PHOTO_ALIGNMENT_METADATA_QA_PASS`
- `D. PHOTO_ALIGNMENT_TRANSFORM_COMPUTATION_SCOPE_AUDIT_PASS`
- `E. BOARD_CANVAS_BACKGROUND_PHOTO_HELPER_SCOPE_AUDIT_PASS`

## Selected next route
`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

Reason:
- conservative forward step,
- validates current readiness UI behavior in live-lite usage before opening any higher-risk UI/transform/photo-helper scopes.

## Required stop gates (locked)
- Any transform computation requires GPT Pro + Claude Code before Codex implementation.
- Any background photo helper requires GPT Pro + Claude Code before Codex implementation.
- Any photo-local evidence rendering requires GPT Pro + Claude Code before Codex implementation.
- Any event-writing UI requires a separate scope lock and audit.
- Any Project ZIP contract change requires a separate scope lock and audit.

## Safety language preserved
- renderer writes nothing
- photo pixels are not facts
- alignment is not identity, pin mapping, net, measurement, or fault proof
- visual_trace is not a net
- damage is not fault proof
- suspect is not probability
- no `board_graph.json`
- no `view_state.json`

## Routing
- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS`
- Next recommended pass: `LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Hard boundaries preserved
- no schema/tool/materializer/Dart/Flutter implementation changes
- no Project ZIP changes
- no transform computation
- no coordinate conversion
- no background photo helper
- no photo-local evidence board rendering
- no visual_trace/damage/suspect canvas geometry
- no event-writing UI
- no `board_graph.json`
- no `view_state.json`
