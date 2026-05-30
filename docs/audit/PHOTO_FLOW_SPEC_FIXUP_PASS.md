# PHOTO_FLOW_SPEC_FIXUP_PASS

## PASS_ID
`PHOTO_FLOW_SPEC_FIXUP_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only spec fixup.

## Trigger
`PHOTO_FLOW_SPEC_AUDIT_PASS` verdict: `NEEDS_SPEC_FIXUP`.

## Objective
Reconcile `docs/PHOTO_FLOW_SPEC.md` to current accepted repo state after the photo-alignment schema -> materializer -> Dart model -> QA chain.

## Implemented doc changes
- Updated `PHOTO_FLOW_SPEC.md` from stale pre-implementation wording to current accepted implemented state.
- Recorded accepted implementation chain explicitly:
  - `photo_to_board_alignment_confirmed` schema/validator support,
  - `known_facts.photo_to_board_alignments` materializer projection,
  - `known_facts` schema support,
  - Dart KnownFacts support,
  - QA hardening acceptance for materializer and Dart model coverage.
- Updated event-family status to include:
  - `photo_to_board_alignment_confirmed` as implemented/accepted canonical alignment event,
  - `photo_reference_points_set` as reserved/deferred placeholder,
  - `photo_layer_aligned` as reserved/deferred placeholder.
- Reframed stale sections (including old scope-lock/future-direction sections) to present accepted state plus canonical owner pointers.
- Added explicit Dart model warning:
  - reference-point storage only,
  - no transform matrix/similarity/affine/homography computation,
  - no board-canvas overlay geometry computation.
- Added explicit still-deferred block:
  - board-canvas photo alignment UI,
  - background photo helper,
  - transform computation,
  - photo-local evidence conversion,
  - visual_trace/damage/suspect canvas geometry rendering,
  - Project ZIP contract changes.

## Boundaries preserved
- photo pixels are not facts.
- photo alignment is not identity confirmation.
- photo alignment is not pin mapping.
- photo alignment is not net confirmation.
- photo alignment is not measurement.
- photo alignment is not fault proof.
- visual_trace is not a net.
- damage is not fault proof.
- suspect is not probability.
- AI transform proposal is not canonical.
- renderer writes nothing.
- no `board_graph.json` / `view_state.json`.

## Routing updates
- Set current pass to `PHOTO_FLOW_SPEC_FIXUP_PASS`.
- Kept next recommended pass as `PHOTO_FLOW_SPEC_FIXUP_AUDIT_PASS`.
- Updated `ACTIVE_SCOPE_LOCK.md` and `AUDIT_INDEX.md` accordingly.

## Validation commands run
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
