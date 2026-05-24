## Purpose

Flutter event-writing V1 enables carefully scoped human-entered events while preserving append-only event sourcing for V1.

## Non-negotiables

- `events.jsonl` remains the canonical truth.
- `known_facts.json` remains materialized projection.
- No AI-authored measurements.
- No AI-invented component identity, net, hidden-layer link, or fault probability.
- No `visual_trace -> measured` / electrical-net promotion.
- No camera/OCR/CV, source-search, BLE, or cloud in first event-write pass.
- No `board_graph.json` / `view_state.json` usage.
- No direct Project ZIP mutation.

## Sequence management

Decision:

- Dart owns next sequence number for local Flutter writes.
- Dart reads existing events at write time.
- `next_sequence = max(existing sequence values) + 1`.
- If `events.jsonl` is empty, `first sequence = 1`.
- If sequence values are missing, duplicated, non-integer, or out-of-order in the loaded project, write flow stops and requires validation/repair before new writes.

Rationale:

- Flutter cannot rely on Python tool calls for local sequencing.
- Local calculation is deterministic and compatible with append-only event logs.

## Event IDs

Decision:

- Dart generates deterministic-enough local IDs with collision check against existing IDs.
- Allowed V1 format should be documented, for example: `evt_flutter_<timestamp_utc>_<short_random>`.
- On collision, regenerate.
- Do not reuse or rewrite old IDs.

## Dart-side validation approach

Decision:

- Validate locally before write with a minimal Dart validator.
- Required checks:
  - required envelope fields present
  - `event_type` in allowed V1 write allowlist
  - `actor.type != "ai"` for evidence/measurement write events
  - payload is an object
  - `sequence > 0`
  - `event_id` unique
  - accepted timestamp format if required by schema
- Full Python validation remains canonical for import/export validation.
- Dart V1 validator is a safety gate, not full schema parity.

## Append-only guarantee

Decision:

- Flutter never rewrites existing event lines.
- Flutter appends exactly one JSONL line to `events.jsonl` in the unpacked local project folder.
- Write strategy:
  - read current `events.jsonl`
  - verify file has not changed since read if feasible
  - write through temporary file
  - fsync/flush if platform supports
  - atomic rename over `events.jsonl`
- Existing lines remain byte-preserved where feasible.
- If write fails, keep original `events.jsonl` intact.

## Project storage path

Decision:

- Flutter writes only to unpacked local project folder.
- Flutter does not mutate ZIP directly.
- Import flow:
  ZIP → validate/unpack → local project folder.
- Work flow:
  append to local `events.jsonl`.
- Export flow:
  regenerate known_facts if supported by app architecture or mark projection stale until export tooling refreshes; then package ZIP through accepted export path.

## known_facts after write

Decision:

- Event-write must not claim known-facts parity unless regeneration actually occurs.
- If regeneration cannot be guaranteed, UI must show “events changed; projection refresh required.”
- Avoid inventing or synthesizing facts in `known_facts`.
- Projection refresh policy after event writes is defined in `docs/PROJECTION_REFRESH_SPEC.md` (POLICY_D).
- Flutter V1 marks `isProjectionStale = true` and must not mutate `known_facts.json`.

## First writable event subset

Allowed first writable candidates:

- `component_created`
- `pin_defined`
- `measurement_recorded`

Decision:

- First implementation pass should choose smallest subset:
  - `measurement_recorded` only.
- Deferred in V1:
  - `photo_added`
  - `damage_region_marked`
  - `suspect_region_marked`
  - `visual_trace_added`
  - `net_connection_confirmed`
  - `repair_action_recorded`
  - conflict events
  - component removal/editing UI
  - camera capture
  - photo import
  - OCR/CV
  - BLE capture

## Measurement write boundary

For `measurement_recorded`:

- Human/technician supplies values.
- AI cannot author measurement values.
- UI must not guess units, pins, nets, or component IDs.
- No measured-net confirmation is created automatically.

## Future implementation path

Candidate passes:

- `FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS`
- `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS`

Recommended sequence:

1. `FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS`
2. `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS`
3. later component/pin write scope pass
4. later annotation/photo write scope pass

## Measurement event write V1 scope

Future implementation pass:
- FLUTTER_EVENT_WRITE_MEASUREMENT_PASS

Writable event type:
- `measurement_recorded` only

Explicitly forbidden in this implementation:
- `component_created`
- `pin_defined`
- `photo_added`
- `damage_region_marked`
- `suspect_region_marked`
- `visual_trace_added`
- `net_connection_confirmed`
- `repair_action_recorded`
- `conflict` events
- component editing/removal UI
- camera/photo import
- OCR/CV
- BLE capture
- AI-authored measurements

Required UI behavior:
- user manually enters measurement value
- user selects or types the measurement target explicitly
- user selects unit explicitly
- UI must not infer units, targets, pins, nets, or component identity
- UI must not create net confirmations
- UI must mark projection stale after append unless accepted regeneration exists
- UI must show event append result / validation result clearly

Required event-write behavior:
- append only one `measurement_recorded` JSONL event
- generate next sequence from current events
- generate unique `event_id`
- `actor.type` must not be `ai`
- payload must satisfy minimal Dart pre-write checks
- do not mutate existing event lines
- do not mutate `known_facts.json`
- do not mutate ZIP directly

Required storage behavior:
- write only to unpacked local project folder
- never directly write into ZIP
- export remains separate accepted path

Future implementation write allowlist:
- `lib/app/router.dart` only if route/nav needed
- `lib/features/measurements/**`
- `lib/features/project/**` only if adding entry point
- `lib/shared/event_write/**` or equivalent event-writing service folder
- `lib/shared/models/**` only if needed for event envelope/value models
- `test/unit/**` event-writing tests
- `test/widget/**` measurement write UI tests
- `test/integration/**` measurement append flow tests
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_PASS.md`

Forbidden future implementation surfaces:
- schemas/**
- tools/**
- samples/**
- assets/**
- pubspec.yaml / pubspec.lock unless unavoidable and separately approved
- Project ZIP tooling changes
- event schema changes
- known_facts mutation
- `board_graph.json` / `view_state.json`
- camera/OCR/CV/source-search/cloud/BLE

Required tests for future implementation:
- sequence = max(existing)+1
- duplicate/bad sequence blocks writing
- `event_id` collision regenerates or blocks safely
- `actor.type=ai` rejected
- one JSONL line appended
- existing lines preserved
- known_facts not mutated
- projection stale indicator shown
- no `net_connection_confirmed` created
- no `component_created`/`pin_defined` created
- widget test: manual value/unit/target required
- integration test: append `measurement_recorded` to local project folder
