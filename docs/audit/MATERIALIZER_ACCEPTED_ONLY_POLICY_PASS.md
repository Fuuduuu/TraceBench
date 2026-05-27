# MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS

## Summary

Implemented accepted-only domain projection policy in `tools/materialize_known_facts.py` with no schema, validator, ZIP tooling contract, sample/asset, or runtime/UI changes.

## What changed

- Added accepted-only event gate before domain handler dispatch in materializer loop.
- Non-accepted events are skipped for domain projection side effects.
- `project_id` fallback logic now uses:
  1. manifest project_id when available,
  2. otherwise first accepted event project_id,
  3. otherwise `"unknown"`.
- Preserved accepted behavior for domain handlers, including:
  - remove_component side effects,
  - stale-after-repair handling,
  - visual-only trace boundary,
  - accepted+user-only component visual placement projection.

## Test coverage added

`tests/test_materialize_known_facts.py` now includes synthetic coverage that non-accepted events do not materialize/mutate:
- components create/update/unknown state
- pins
- measurements
- nets
- photos
- damage/suspect regions
- visual traces
- not-populated exclusion list
- remove_component projection side effects
- stale-after-repair side effects
- component visual placements

Also added project_id behavior coverage for manifest-preference and accepted-only fallback.

## Boundaries preserved

- No changes to `schemas/**`.
- No changes to `tools/validate_events_jsonl.py`.
- No changes to Project ZIP tool contract.
- No changes to samples/assets.
- No visual->electrical promotion.
- No AI proposal canonicalization.
