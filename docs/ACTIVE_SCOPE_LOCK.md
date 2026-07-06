# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Lock state

No active implementation lock.

No runtime, test, schema, tool, writer, router, asset, event, fact, `known_facts.json`, `events.jsonl`, `windows/`, or `_incoming` file is armed.

## If a new pass is chosen

Every new pass must define:
- `PASS_ID`
- exact write allowlist
- forbidden surfaces
- required validation
- route result

Runtime or protected-surface work must be scope-locked before implementation.

## Current docs-hygiene review set

For `DOCS_COMPACTION_VISUAL_FIRST_ALIGNMENT_PASS`, expected docs-only review set:
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PROJECT_MEMORY.md`
- `docs/AUDIT_INDEX.md`
- `docs/UI_WORKFLOWS.md`
- `docs/audit/DOCS_COMPACTION_VISUAL_FIRST_ALIGNMENT_PASS.md`

No implementation allowlist is armed by this hygiene pass.

## Forbidden surfaces while route is free

Do not change without a new active lock:
- router files or route definitions
- splash/home/workbench/Board Canvas/Add/Edit/Measure runtime
- writer services
- schemas
- validators/materializers/tools
- canonical events/facts semantics
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- `windows/` or native runner files

## Canonical boundaries

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- Visual drafts must not become pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Exact-file staging only; broad staging is forbidden.