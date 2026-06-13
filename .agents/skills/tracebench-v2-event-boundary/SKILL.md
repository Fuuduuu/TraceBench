# tracebench-v2-event-boundary

Reusable workflow for passes touching V2 events, writer, validator, materializer, known_facts projection, or canonical event semantics.

## Required invariants

- `events.jsonl` is canonical truth.
- `known_facts.json` is projection/cache.
- No AI/helper authoring of canonical events.
- No `sequence` field in V2 events.
- Human-confirmed canonical events only.
- Reference/candidate/context/hint/photo/visual_trace cannot be promoted to proof without accepted evidence path.
- materializer/validator/writer changes must be separately scoped and explicit.
- UI cannot change event semantics as a side-effect.

## Required checks

- search for `sequence`
- search for legacy `MeasurementEventWriter` reachability when Save Measurement is involved
- event type allowlist awareness
- projection/cache consistency review
- confirm event schema boundaries in relevant pass scope docs