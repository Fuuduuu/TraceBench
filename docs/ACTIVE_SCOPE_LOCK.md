# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

Baseline: `e563835950de7ca5ba8b485ad0375b9f540dd11e`
(`docs: add code map standard`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Lock state

The code-map standard bootstrap lock is released. No implementation or docs
write allowlist is active, and no next pass is armed. A new human-selected pass
and exact allowlist are required before further changes.

## Established framework

- Code maps are repo-local, task-specific, descriptive, symbol-anchored, and
  committed-state-only.
- Bootstrap v1 is Dart-only; production and test maps qualify independently.
- Map paths mirror source paths and the index lists only maps that exist.
- Maps cannot authorize writes, refactors, files, scope expansion, or protected
  changes; canonical owners and active scope locks outrank them.
- No production, test, or Board Canvas map exists yet.

## Preserved boundaries

No event/fact, writer, schema, validator, materializer, projection, Project ZIP,
route, package, asset, measurement, component identity, AI/OCR/CV, electrical,
Board Canvas, runtime, test, tool, or `_incoming` change is open. Known untracked
scratch/design/generated material remains outside every staging set.
