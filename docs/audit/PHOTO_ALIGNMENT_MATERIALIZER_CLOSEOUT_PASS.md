# PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS

## PASS_ID
`PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only audit closeout.

## Audit verdict recorded
Claude Code audit verdict: `PASS_WITH_NITS`.

## Acceptance decision
`PHOTO_ALIGNMENT_MATERIALIZER_PASS` is accepted as completed and scope-compliant.

## Accepted implementation state
- `tools/materialize_known_facts.py` projects accepted user `photo_to_board_alignment_confirmed` events into `known_facts.photo_to_board_alignments`.
- `schemas/known_facts.schema.json` supports optional top-level `photo_to_board_alignments` with strict item contract.
- Selection/projection rules are accepted:
  - event status `accepted`,
  - actor type `user`,
  - latest accepted event wins per `alignment_id`.
- Projected item behavior is accepted:
  - `source_event_id` preserved from winning event,
  - `status = user_confirmed_alignment`,
  - payload values preserved verbatim,
  - `notes` emitted only when present.

## Boundary confirmation
- No transform matrix computation.
- No photo-local geometry conversion.
- No render-ready overlay data.
- No side effects into components, pins, measurements, nets, visual_traces, photos, damage_regions, suspect_regions, excluded_from_fault_candidates, repair conclusions, or customer report.
- No `board_graph.json` / `view_state.json`.
- No Project ZIP contract change.
- No Dart/Flutter/runtime change.

## Deferred surfaces (unchanged)
- No Dart KnownFacts model support yet.
- No Flutter/UI/rendering support yet.
- No transform computation/preview pipeline.
- No photo-local evidence conversion.
- No Project ZIP contract evolution.

## Non-blocking nits recorded
- Side-effect test does not explicitly assert `damage_regions == []` and `suspect_regions == []`.
- No direct JSON Schema library validation test against a projected `photo_to_board_alignments` item.
- Nits are non-blocking and can be handled in a future QA/test-hardening pass.

## Next recommended pass
`PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`
