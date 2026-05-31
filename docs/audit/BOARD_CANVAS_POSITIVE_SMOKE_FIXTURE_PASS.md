# BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PASS

## PASS_ID
`BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PASS`

## Lane
`SAMPLE_PASS / QA_PASS`

## Result
Completed.

## Scope outcome
- Added a dedicated deterministic sample fixture:
  - `samples/board_canvas_positive_smoke`
- Added asset mirror:
  - `assets/samples/board_canvas_positive_smoke`
- Updated sync parity test:
  - `tests/test_asset_sample_sync.py`
- Updated docs ledger:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/AUDIT_INDEX.md`

No schema/tool/lib/runtime/UI/Project-ZIP behavior changes were made.

## Fixture summary
- Project ID: `prj_board_canvas_smoke_001`
- Required files added:
  - `manifest.json`
  - `events.jsonl`
  - `known_facts.json` (materialized)
  - `metadata/schema_versions.json`
  - `exports/customer_report.md`
  - `photos/.gitkeep`
- Event chain contains exactly 8 accepted events (`evt_000001`..`evt_000008`) in locked order:
  1. `component_created` (`SMP001`)
  2. `pin_defined` (`SMP001.1`)
  3. `pin_defined` (`SMP001.2`)
  4. `photo_added` (`photo_smoke_top_001`)
  5. `measurement_recorded` (`M1001`)
  6. `visual_trace_added` (`VT001`)
  7. `component_visual_placement_confirmed` (`board_normalized`)
  8. `photo_to_board_alignment_confirmed` (`ALN1001`)

## Projection summary
- Generated with:
  - `py -3 tools\materialize_known_facts.py samples\board_canvas_positive_smoke\events.jsonl samples\board_canvas_positive_smoke\known_facts.json`
- Materialized `known_facts.json` includes:
  - `components`
  - `pins`
  - `measurements`
  - `visual_traces`
  - `component_visual_placements`
  - `photo_to_board_alignments`

## Asset mirror summary
- Mirrored files copied byte-for-byte for:
  - `manifest.json`
  - `events.jsonl`
  - `known_facts.json`
  - `exports/customer_report.md`
- Also mirrored:
  - `metadata/schema_versions.json`

## Boundary confirmation
Preserved:
- no schema changes
- no validator/tool behavior changes
- no materializer logic changes
- no Dart/Flutter runtime/UI changes
- no `board_graph.json` or `view_state.json`
- no transform computation
- no background photo helper
- no event-writing UI

## Next recommended pass
`BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_AUDIT_PASS`
