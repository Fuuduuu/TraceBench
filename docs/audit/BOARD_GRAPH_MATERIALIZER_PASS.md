# BOARD_GRAPH_MATERIALIZER_PASS

## Status

completed

## Lane

TOOLS_PASS

## Goal

Extend known_facts materialization so board-graph projection inputs are deterministic and complete without changing event semantics or ZIP tooling.

## Files changed

- `tools/materialize_known_facts.py`
- `schemas/known_facts.schema.json`
- `samples/pelle_pv20_minimal/known_facts.json`
- `tests/test_graph_projection.py`
- `tests/test_materialize_known_facts.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`

## Changes made

- Handle `component_updated` events with patch semantics:
  - match by `component_id`
  - overwrite only provided fields
  - never overwrite `component_id`
  - do not create components when no match is found
- Handle `component_marked_unknown`:
  - match by `component_id`
  - set status to `needs_identification`
  - clear `mpn` and `marking`
  - keep component in projection
- Add optional `component_pin_index` to `known_facts.json` output and schema.
- Add deterministic invariant warnings (stderr only, non-fatal) for projection sanity:
  - visual traces must not appear in measured net endpoints or identifiers
  - not-populated footprints must not appear in measured net endpoints
  - visual traces must not have `evidence_type="measured"`
- Add graph-projection and materializer tests in Python stdlib `unittest`.
- Regenerate the Pelle PV20 sample materialized output.

## Validation

- `py -3 tools\validate_all.py`

## Governance notes

- `board_graph.json` and `view_state.json` remain forbidden outputs; no Project ZIP tooling changes were made.
- `visual_trace` remains non-electrical evidence and is never promoted to measured net.
- `component_pin_index` is optional projection metadata, not canonical truth and not a UI cache.
