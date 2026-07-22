# Active Scope Lock

## Route

Current: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`
Next: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`

## Current executable authority

PASS_ID: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`

Lane: `B`

Mode: `DOCS_SYNC`

This current pass is docs-only. Its exact write allowlist is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS.md`

The audit artifact is the only allowed new file. This authority does not
implement an event, projection, writer, Project ZIP change, or wizard/UI
behavior. Staging, commit, and push are not authorized.

## Binding decision and owners

The human explicitly selected `board_outline_confirmed` as a project-level
Visual/Layout fact and never electrical truth. The future implementation must
remain compatible with:

- `docs/POHIKIRI.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/PROJECT_MEMORY.md`
- `docs/UI_WORKFLOWS.md`
- the current executable V2 validator/materializer/writer/ZIP boundaries

The approved `_incoming/ui_redesign/TraceBench_new_project_wizard.zip` is
inspect-only future visual/product input. Its verified SHA-256 is
`78B998ED601E3E27629FEE8E1586CC8430CAF5089A179B3C9832080EA50A8EC7`.
It is not runtime truth and does not override
`docs/FLUTTER_NEW_PROJECT_WIZARD_SPEC.md`, which remains the accurate current V1
blank-project contract.

## Reserved protected implementation

PASS_ID: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`

Lane: `B`

Mode: `TOOLS_PASS`

The future authority is reserved, not active. It becomes executable only when:

1. independent Claude Code audits this actual five-file scope-lock diff;
2. the verdict accepts the lock and reports `SAFE_FOR_STAGING: YES`;
3. the human stages, commits, and pushes exactly the accepted scope-lock set;
4. the implementation gate confirms no baseline, route, or scope drift.

No active-lock-sync pass is allowed or required. A deficient or drifted lock
must stop for a new explicit human decision; it may not be widened implicitly.

### Exact future write allowlist

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/PROJECT_MEMORY.md`
- `docs/UI_WORKFLOWS.md`
- `tools/validate_events_jsonl.py`
- `tests/test_validate_events_jsonl.py`
- `schemas/known_facts.schema.json`
- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_event_writer_service.py`
- `tests/test_project_zip.py`

No wildcard or eleventh path is authorized.

### Future inspect-only surfaces

- `schemas/events.schema.json`
- `tools/event_writer_service.py`
- `tools/validate_project_zip.py`
- `docs/FLUTTER_NEW_PROJECT_WIZARD_SPEC.md`
- `_incoming/ui_redesign/TraceBench_new_project_wizard.zip`
- all current Dart models and writers
- all project-creation, wizard, router, Board Canvas, component, pin, marker,
  and placement surfaces

`schemas/events.schema.json` remains the V1-envelope schema. The generic writer
and Project ZIP validator remain unchanged because they already delegate to the
event validator and materializer.

## Locked future event contract

### Meaning

- Canonical event type: `board_outline_confirmed`.
- Scope: one project-level Visual/Layout board-geometry fact.
- It is never electrical truth and never proves identity, connectivity,
  measurement, diagnosis, fault, or probability.
- Only explicit human confirmation may author the canonical event.

### Envelope

The event uses the existing strict V2 envelope:

- `schema_version`: exactly `2.0-draft`
- `event_type`: exactly `board_outline_confirmed`
- required `event_id`, `created_at`, `project_id`, and
  `client_operation_id`
- `actor.type`: exactly `human`
- `source.type`: exactly `explicit_user_confirmation`
- `confirmation.confirmed`: exactly `true`
- required `payload`
- no `sequence`
- no `status`

Existing V2 top-level allowlisting and fail-closed behavior remain in force.

### Payload

The payload permits exactly:

- `coordinate_space`: required and exactly `board_normalized`
- `outer_polygon`: required ordered array of vertex objects containing exactly
  `{x, y}`
- `physical_width_mm`: optional only as a paired dimension
- `physical_height_mm`: optional only as a paired dimension

No additional payload or vertex fields are allowed.

### Geometry

- Origin is top-left; `+x` points right and `+y` points down.
- Every `x` and `y` is a finite JSON number in the inclusive range `0..1`.
- Booleans are rejected as numbers; non-finite values are rejected explicitly.
- The polygon has at least three distinct vertices.
- Closure is implicit from the final vertex to the first.
- The first vertex must not be repeated as the final array item.
- Duplicate vertices, zero-area/all-collinear shapes, self-intersections, and
  overlapping non-adjacent edges are rejected.
- Concave polygons are accepted.
- Clockwise and counter-clockwise winding are both accepted.
- Holes and cutouts are unsupported.

### Physical size

- `physical_width_mm` and `physical_height_mm` are both present or both absent.
- Each is a finite number greater than zero; booleans are rejected.
- `physical_width_mm` describes the physical width corresponding to the
  `outer_polygon` axis-aligned bounding-box extent `max(x) - min(x)`.
- `physical_height_mm` describes the physical height corresponding to the
  `outer_polygon` axis-aligned bounding-box extent `max(y) - min(y)`.
- These dimensions do not map to unused padding in the full normalized `0..1`
  frame. They are not oriented-bounding-box dimensions or polygon edge lengths.
- Dimensions are human-confirmed visual board-geometry metadata only, never
  electrical or diagnostic evidence.

### Supersession

- The first outline may omit top-level `supersedes_event_id`.
- An ordinary edit appends a new `board_outline_confirmed` with top-level
  `supersedes_event_id`; it never mutates the old event.
- The target must be an earlier `board_outline_confirmed` event in the same
  project.
- A new root without `supersedes_event_id` is valid and creates another active
  head, therefore an explicit conflict.
- Neither stream position nor `created_at` chooses a winner.
- `origin_event_id`, `corrects_event_id`, and `invalidates_event_id` are not
  outline-replacement mechanisms.
- The existing `event_invalidated` payload/envelope contract remains unchanged.

Validator enforcement is outline-specific and bidirectional:

- if any event's `supersedes_event_id` target is a
  `board_outline_confirmed`, the source event must also be a
  `board_outline_confirmed`, otherwise validation fails;
- validator enforcement resolves the prior target event's `event_type` and
  `project_id`, rather than proving only that its `event_id` was seen;
- this does not create a global rule requiring every V2 event family to
  supersede only its own type.

### Forbidden meanings and fields

The foundation defines no:

- `outline_id`
- component ID, board side, pin, pad, contact, placement, marker, trace, or net
- measurement, diagnosis, fault, probability, or AI-confidence meaning
- photo or template identity, reference, or proof
- AI/helper/OCR/CV-authored canonical event
- candidate persistence contract

## Locked future projection contract

### Head calculation

Materialization builds a separate outline supersession graph per project. It
uses only edges whose later/source event is `board_outline_confirmed`, whose
`supersedes_event_id` target is an earlier `board_outline_confirmed`, and whose
source and target belong to the same project. A cross-type supersession edge
never retires, hides, or otherwise affects a board outline, including when the
materializer receives unvalidated input.

Within that outline-only immutable graph, supersession ancestry remains
transitive through invalidated intermediate events:

- a non-invalidated `board_outline_confirmed` event is an active head only when
  no non-invalidated `board_outline_confirmed` descendant is reachable through
  one or more outline-only graph edges;
- invalidating the current superseding head may reveal the nearest prior valid
  ancestor;
- invalidating an older or intermediate event never invalidates a still-valid
  descendant and must not spuriously reveal an ancestor while that descendant
  remains active.

Thus `A <- B`, with `B` invalidated, may reveal `A`; `A <- B <- C`, with only
`B` invalidated, leaves `C` as the sole head. Forks and independent roots may
produce multiple heads. Canonical raw stream position supplies deterministic
ordering; timestamps and event IDs never rank candidates.

### Output states

- Zero heads: omit both `known_facts.board_outline` and
  `known_facts.board_outline_conflicts`.
- Exactly one head: emit `known_facts.board_outline` only, containing
  `coordinate_space`, `outer_polygon`, optional paired physical dimensions,
  and `source_event_id`.
- More than one head: omit `known_facts.board_outline` and emit
  `known_facts.board_outline_conflicts` as an array with one project-level
  conflict object:
  - `conflict_type`: exactly `board_outline_divergence`
  - `source_event_ids`: every head ID in canonical stream order
  - `candidates`: matching geometry objects in the same order, each containing
    exactly `coordinate_space`, `outer_polygon`, optional paired
    `physical_width_mm` / `physical_height_mm`, and `source_event_id`

The two output keys are mutually exclusive when any head exists. Independent
heads conflict even when their geometry values are identical. No latest-wins
or silent conflict resolution is allowed. No `board_outline_history`
projection is introduced; `events.jsonl` retains the complete history.

## Atomic validator/materializer foundation

`tools/event_writer_service.py` validates the existing stream plus candidate
through `tools/validate_events_jsonl.py` before appending. Once the validator
accepts `board_outline_confirmed`, the unchanged generic writer can append it.
Validator-only support would therefore admit canonical history that the old
materializer silently omits.

The future pass must land validator acceptance, known-facts schema support,
materialization, and their tests atomically. It must not leave a state where
the event is writable but absent from projection. The unchanged writer and
Project ZIP validator are proven through their allowlisted test files, not by
editing their source.

## Future acceptance and test floor

The future implementation must prove at minimum:

- strict V2 envelope and payload allowlists, human-only confirmation, and
  rejection of forbidden meanings;
- finite/non-boolean normalized coordinates and paired positive finite sizes;
- minimum distinct vertices, implicit closure, duplicate/closing-duplicate,
  zero-area/collinear, crossing, and overlap rejection;
- concave polygons and both winding directions accepted;
- same-project, same-type, earlier-event supersession targets only;
- non-outline -> outline supersession is rejected;
- outline -> non-outline supersession is rejected;
- cross-project outline -> outline supersession is rejected;
- an unrelated cross-type edge cannot hide an outline during materialization,
  including for unvalidated input;
- zero, one, and multiple active-head projection states;
- ordinary chains, forks, independent and identical roots, invalidated roots,
  invalidated current heads, and invalidated middle/older events;
- branched outline heads still emit `board_outline_divergence`;
- the chain `A <- B(invalidated) <- C(valid)` remains graph-connected and emits
  `C` as the only active head;
- transitive ancestry for `A <- B <- C` and deterministic raw-stream ordering;
- complete event history and no latest-wins behavior;
- a valid outline passes the unchanged generic writer, with invalid outlines
  rejected before append and idempotency preserved;
- Project ZIP validation accepts regenerated outline projection and rejects a
  stale or missing outline projection without changing the ZIP contract;
- V1 and existing supported V2 behavior remains green.

## Explicitly deferred and unarmed

- Dart `KnownFacts` model/parsing
- a Dart board-outline writer
- atomic wizard project creation plus event append/materialization
- Flutter wizard implementation
- Board Canvas outline editing or rendering
- component/marker creation and placement persistence
- pin semantics
- AI/photo/template candidate persistence
- Project ZIP contract or packaging changes
- sample or asset changes

The approved design ZIP remains inspect-only. It may inform a later separately
locked product/UI pass but cannot authorize or supply runtime code.

## Validation contracts

Current scope-lock validation:

- `py -3 tools\validate_all.py`
- `git diff --check`
- exact changed-file, cached-file, route, ledger-row, and scratch checks

Reserved implementation validation:

- `py -3 tests\test_validate_events_jsonl.py`
- `py -3 tests\test_materialize_known_facts.py`
- `py -3 tests\test_event_writer_service.py`
- `py -3 tests\test_project_zip.py`
- `py -3 tools\validate_all.py`
- `git diff --check`
- exact changed-file and staged-file checks

## Stops

Stop on any baseline, remote, branch, route, tracked/cached state, ZIP hash, or
scratch-inventory drift; allowlist expansion; canonical-owner conflict outside
the reserved ten files; inability to implement validator and materializer
atomically; or any need to edit inspect-only Dart, Flutter, wizard,
ProjectCreator, router, Board Canvas, generic writer, ZIP validator, V1 event
schema, sample, asset, or `_incoming` surfaces.

Stop before staging, commit, push, reset, clean, pull, rebase, or force-push.
