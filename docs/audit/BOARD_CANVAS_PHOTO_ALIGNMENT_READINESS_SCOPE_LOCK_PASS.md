# BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only readiness scope lock.

## Accepted baseline recorded
- `photo_to_board_alignment_confirmed` schema/validator support is accepted.
- `known_facts.photo_to_board_alignments` materializer projection is accepted.
- `known_facts` schema support is accepted.
- Dart KnownFacts `photoToBoardAlignments` support is accepted.
- `PHOTO_FLOW_SPEC.md` is aligned to this accepted chain.

## Readiness lock: what is ready now
- Canonical data-chain exists end-to-end for alignment reference-point facts:
  - event schema -> validator -> materializer -> known_facts schema -> Dart KnownFacts.
- Read-only board-canvas baseline exists:
  - board-canvas shell,
  - read-only inspector,
  - read-only measurement summary metadata,
  - read-only visual_trace metadata summary.

## Readiness lock: what is not ready now
- No board-canvas photo-alignment UI.
- No background photo helper.
- No transform matrix computation.
- No photo-local evidence conversion to board rendering.
- No visual_trace/damage/suspect canvas geometry rendering.
- No Project ZIP contract change.
- No `board_graph.json` / `view_state.json`.

## Readiness decision
Chosen next safe routing: **A. `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS`**.

Rationale:
- Conservative governance-first progression before any Flutter implementation.
- UI-scope audit is safer than routing directly to implementation while transform/conversion and helper boundaries remain explicitly deferred.
- Keeps evidence and no-write boundaries explicit before any future interaction design.

## Hard boundaries locked for future UI/alignment scopes
- Alignment data remains reference-point data only.
- Dart model does not compute transforms.
- Renderer must not compute canonical truth.
- Background photo helper must not become hidden truth.
- Any volatile preview must not be saved/exported/materialized/reported.
- Photo-local evidence must not be board-rendered without explicitly accepted transform scope.
- `visual_trace` is not net.
- damage is not fault proof.
- suspect is not probability.
- renderer writes nothing.
- no `board_graph.json`.
- no `view_state.json`.

## Routing updates
- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS`.
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS`.

## Validation commands
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
