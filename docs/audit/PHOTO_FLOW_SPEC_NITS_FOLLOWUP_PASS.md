# PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS

## PASS_ID
`PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only spec polish.

## Goal
Resolve non-blocking nits recorded in `PHOTO_FLOW_SPEC_FIXUP_CLOSEOUT_PASS` without changing implementation surfaces.

## Nits resolved
1. Placeholder event explicitness:
   - Added explicit readiness status for `photo_reference_points_set` and `photo_layer_aligned`.
   - Documented that both currently have no payload schema, no validator business logic, no materializer projection, and no Dart model.
   - Reaffirmed both are reserved/deferred and not writer-ready.
2. Canonical owner pointer:
   - Added `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md` as board-canvas read-only UI boundary owner pointer.
3. Section numbering continuity:
   - Removed numbering gap by renumbering the deferred/canonical-owner/safety-warning sections.
4. Durable wording:
   - Replaced “this docs-only pass” wording with durable scope wording:
     - “No Project ZIP tooling changes are in scope unless separately authorized.”

## Boundaries preserved
- No code/schema/tool/test/runtime changes.
- No Project ZIP contract changes.
- No `board_graph.json` / `view_state.json`.
- No photo-local evidence rendering changes.
- No transform computation changes.

## Routing
- Current pass set to `PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS`.
- Next recommended forward pass set to `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS`.

## Validation commands
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
