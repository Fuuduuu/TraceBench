# V2 Event Schema Spec

Status: docs/spec requirements only. This is not a schema file, JSON schema, validator, materializer implementation, writer implementation, UI behavior, Project ZIP change, test file, or generated artifact.

Binding source: `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`.

## 1. Scope And Authority

V2 canonical writes are append-only human-confirmed events.

- `events.jsonl` is canonical truth.
- `known_facts.json` is a materialized projection/cache regenerated from `events.jsonl`.
- Human is the sensor. AI is the graph engine.
- AI/helper/OCR/CV/import inference/renderer surfaces never author canonical events or facts.
- Derived display surfaces, including Activity Timeline, Board Canvas, Reference Images, helper suggestions, and debug logs, are not canonical write sources.

This document defines requirements that later implementation passes must bind to. It intentionally does not define executable validation logic.

## 2. Canonical Event Types

V2 initial canonical event types are fixed.

| Event type | Status | Purpose |
|---|---|---|
| `measurement_recorded` | accepted | Record a human-confirmed measurement reading. |
| `component_created` | accepted | Record a human-created component entity. |
| `component_updated` | accepted | Record a human-confirmed field-level component edit. |
| `event_invalidated` | accepted | Mark a prior event invalid for current projection without deletion or mutation. |

Rejected aliases and non-initial event names:

- `measurement_saved`
- `component_edited`
- `event_superseded`
- `measurement_updated`
- `replaces_event`

Later validators must reject these as V2 initial canonical event types even if they appear in older prose.

## 3. Schema Versioning And Compatibility

Every canonical V2 event must declare `schema_version`.

Requirements:

- V2 requires a schema version bump distinct from the V1/V1.1 read-only-era event baseline.
- The final V2 schema version label is not fixed here; it remains an open item for the later executable schema/validator pass.
- Unsupported canonical event type or unsupported event `schema_version` must fail closed.
- A reader must not silently ignore unknown canonical write events and then project `known_facts.json` as if complete.
- On import, `events.jsonl` is validated first, then `known_facts.json` is regenerated or compared as projection/cache according to the accepted future import spec.
- Legacy V1/V1.1 events without per-event `schema_version` are treated as V1 baseline for compatibility.
- Mixed-version streams must be validated explicitly. Older loadable events may coexist with supported V2 events only when the validator can prove the stream is fully supported.
- Importing a newer unsupported canonical stream must surface an unsupported-version state and preserve data without mutation.

## 4. Common Event Envelope

All accepted V2 canonical events share this envelope.

| Field | Required | Type / shape | Purpose | Later validator/materializer notes |
|---|---:|---|---|---|
| `schema_version` | Yes | string | Declares the event schema version. | Missing, unknown, or unsupported values fail closed. |
| `event_id` | Yes | stable unique ID | Identifies the append-only event. | Must be unique in the stream; exact UUIDv7/ULID choice is open. |
| `event_type` | Yes | string enum | One accepted canonical event type. | Reject aliases and unknown canonical event types. |
| `created_at` | Yes | timestamp | Records append/create time. | Must be parseable and stable; exact timestamp format belongs to executable schema. |
| `project_id` | Yes when project has ID | string | Binds event to a project. | No-project/invalid-project behavior remains open. |
| `client_operation_id` | Yes | stable client operation ID | Idempotency key for explicit user confirmation. | Same operation and same payload should be idempotent in writer pass. |
| `actor` | Yes | object | Human actor metadata. | `actor.type` must be `human`. |
| `source` | Yes | object | Source of canonical write. | `source.type` must be `explicit_user_confirmation`. |
| `confirmation` | Yes | object | Human confirmation record. | `confirmation.confirmed` must be `true`. |
| `payload` | Yes | object | Event-specific data. | Validated according to event type. |

Optional relation fields are defined in section 10.

Forbidden envelope-level sources include AI/helper/OCR/CV/renderer/import-inference/activity timeline/debug log/reference image/photo alignment/visual trace/localStorage. These may appear only as non-canonical context where explicitly allowed and must never be canonical write authority.

## 5. Actor, Source, And Confirmation

Canonical V2 events require:

| Path | Required value |
|---|---|
| `actor.type` | `human` |
| `source.type` | `explicit_user_confirmation` |
| `confirmation.confirmed` | `true` |

Allowed supporting fields may include local actor ID, source surface, action label, and confirmation timestamp, but those fields do not weaken the required values.

Rejected canonical authors/sources:

- `ai`
- `helper`
- `ocr`
- `cv`
- `renderer`
- `import_inference`
- `activity_timeline`
- `debug_log`
- `reference_image`
- `photo_alignment`
- `visual_trace`
- `localStorage`
- `local_storage_demo`
- telemetry/cloud sync

## 6. `measurement_recorded`

Purpose: record a human-confirmed measurement reading at a target context.

Required payload fields:

| Field | Required | Type / shape | Purpose |
|---|---:|---|---|
| `measurement_id` | Yes | stable ID | Identifies the measurement record/history item. |
| `measured_at` | Yes | timestamp | Measurement time or explicit save time. |
| `target` | Yes | target composite | Records `Koht`, pin, component, board point, or point-to-point context. |
| `reading` | Yes | object | Measurement mode, value/state, unit, and display value. |
| `value_provenance` | Yes | object | Separates measured value from reference/candidate/helper context. |
| `conditions` | Conditional | object or `unspecified` | Board/meter/environment context when relevant. |
| `instrument` | Conditional | object or `unspecified` | Meter context when relevant. |

### Reading Shape

| Field | Required | Type / shape | Purpose |
|---|---:|---|---|
| `mode` | Yes | enum | Measurement mode. |
| `value` | Conditional | exact numeric/string encoding TBD | Human-confirmed measured value when a numeric/scalar value exists. |
| `unit` | Yes | enum | Unit matched to mode. |
| `display_value` | Yes | string | Technician-facing display text as confirmed. |
| `state` | Conditional | enum | Non-scalar/edge state such as `OL`, `over_range`, `under_range`, `unstable`, or `not_measured` if retained. |

Allowed initial mode/unit pairs:

| Mode | Unit | UI placement |
|---|---|---|
| `voltage` | `V` | Primary quick measurement. |
| `resistance` | `Ω` | Primary quick measurement. |
| `diode` | `diode` | Primary quick measurement. |
| `continuity` | `beep` | Primary quick measurement. |
| `current` | `A` | Advanced under `Lisainfo` / `Tehnilised detailid` by default. |

Edge states:

- `OL`, `over_range`, `under_range`, and `unstable` may represent observed meter states without a normal scalar value.
- `not_measured`, if retained, must not be projected as a measured fact.
- Exact numeric/range/decimal encoding remains open for the executable schema pass.

Materializer may derive:

- measurement history,
- active measurement projection when not invalidated or superseded,
- target-linked measurement summaries,
- conflict markers,
- source event IDs,
- value provenance display.

Materializer must not derive:

- component health,
- fault diagnosis,
- fault probability,
- confirmed net identity,
- confirmed pin mapping,
- component identity,
- visual trace connectivity.

## 7. Value Provenance

`value_provenance` is required for `measurement_recorded`.

Allowed measured value sources:

| Value | Meaning |
|---|---|
| `human_entered` | User typed or otherwise entered their observed reading. |
| `human_confirmed_from_reference` | User explicitly confirmed a visible reference value as their own measured reading. |
| `human_confirmed_from_candidate` | User explicitly confirmed a visible candidate value as their own measured reading. |

Allowed non-canonical context value types:

- `helper_suggestion`
- `reference_value`
- `candidate_value`
- `note_value`
- `source_research_value`

Rules:

- `reading.value` must represent a human-entered or explicitly human-confirmed measured reading.
- Helper/reference/candidate/note/source values may be displayed nearby as context only.
- Helper/reference/candidate values must not auto-populate the confirmable measured field.
- One-tap confirmation of a suggested/reference/candidate value as canonical measurement is forbidden.
- If a reference or candidate value is used as a measured reading, the user must separately confirm that it is their observed reading.
- Projection must preserve provenance and must not conflate measured values with context values.

## 8. Target / `Koht` / Pin Model

V2 initial scope uses a stable target composite, not a first-class persisted `Koht` entity.

Required target concepts:

| Field | Required | Purpose |
|---|---:|---|
| `target_kind` | Yes | Describes component, component pin, board point, point-to-point, or unknown context. |
| `target_key` | Yes | Stable grouping key across history/import/export. |
| `display_label` | Yes | Technician-facing `Koht` label. |
| `component_id` | When known | Links to a component entity without proving identity beyond that entity. |
| `pin_id` | When known | Links to a pin context without proving confirmed pin map or net identity. |
| `from_target` | For point-to-point | First endpoint target composite. |
| `to_target` | For point-to-point | Second endpoint target composite. |

Allowed display patterns include dotted labels such as `Q2.1` and point-to-point labels such as `Q2.1 -> R17.1`.

Rules:

- `Koht` is a target context, not net identity.
- `pin_id` is not proof of confirmed pin mapping.
- Point-to-point target labels do not prove an electrical net.
- First-class `Koht` entities and independent pin entities remain open future decisions.

## 9. Component Events

### `component_created`

Purpose: record a human-created component entity.

Required payload fields:

| Field | Required | Purpose |
|---|---:|---|
| `component_id` | Yes | Stable component entity ID. |
| `label` | Yes | Human-facing label. |
| `component_kind` | Yes | Broad kind or `unknown`. |
| `created_context` | Yes | Human-created context. |

Allowed payload fields:

- `reference_designator`
- `pin_count`
- `package_hint`
- `footprint_hint`
- `template_id_hint`
- `side`
- `rough_location`
- `rotation_hint`
- `human_note`

Rules:

- `component_id` is stable.
- `reference_designator` is a mutable label.
- Template, footprint, package, visual, photo, and rough-location values are hints only.
- Visual/photo context is not proof of identity, pin map, net, measurement, or fault.

### `component_updated`

Purpose: append a human-confirmed field-level update to an existing component.

Required payload fields:

| Field | Required | Purpose |
|---|---:|---|
| `component_id` | Yes | Existing component entity. |
| `changes` | Yes | Non-empty field-level change list. |
| `edit_reason` | Yes | Human reason or `unspecified`. |

Each change must include:

| Field | Required | Purpose |
|---|---:|---|
| `field` | Yes | Component field being changed. |
| `old_value_observed` | Yes | Value visible/known before the change, or `unknown`. |
| `new_value` | Yes | New value, clear marker, or unknown marker. |
| `change_kind` | Yes | Type of change. |

Allowed `change_kind` values:

- `set`
- `replace`
- `clear`
- `mark_unknown`
- `correct_typo`

Rules:

- Do not mutate the original `component_created` event.
- Do not introduce `measurement_updated`.
- Measurement correction uses a new `measurement_recorded` with `supersedes_event_id`.

## 10. Relation Fields

Allowed relation fields:

| Field | Scope | Materializer meaning |
|---|---|---|
| `origin_event_id` | Optional lineage | Points to an originating event for derived/user-flow context. It has no replacement effect by itself. |
| `corrects_event_id` | Optional audit intent | States that this event corrects a prior event. In V2 initial projection it is explanatory unless paired with a projection-effective relation. |
| `supersedes_event_id` | Replacement/correction | Makes the new event the current representative for the same assertion/history chain when valid. Used for measurement corrections. |
| `invalidates_event_id` | Invalidation | Marks a prior event invalid for current projection when carried by `event_invalidated`. |

L1 handling:

- V2 initial docs keep both `corrects_event_id` and `supersedes_event_id`.
- `supersedes_event_id` is the projection-effective replacement relation.
- `corrects_event_id` is audit intent and does not silently resolve projection conflicts unless a later executable schema intentionally collapses or binds it to `supersedes_event_id`.
- Later validator/materializer passes must either enforce this distinction or explicitly collapse the fields under an audited spec update.

## 11. Correction, Supersession, And Invalidation

L2 handling:

- Measurement correction is a new `measurement_recorded` event with `supersedes_event_id`.
- `measurement_updated` is rejected.
- Explicit supersession resolves the prior measurement for current projection while retaining history.
- Invalidation is separate from supersession and uses `event_invalidated`.

### `event_invalidated`

Purpose: append a human-authored event that marks a prior event invalid for current projection without deleting or mutating it.

Required payload fields:

| Field | Required | Purpose |
|---|---:|---|
| `invalidates_event_id` | Yes | Prior event being invalidated. |
| `target_entity_id` | Yes | Affected measurement/component/event target. |
| `reason` | Yes | Human reason or controlled reason. |
| `human_note` | Optional | Additional technician note. |

Rules:

- Human-only.
- Append-only.
- No deletion or mutation of the invalidated event.
- Reversal requires a new event.
- Invalidation can itself be corrected/superseded by a later event only through an explicit allowed relation.
- Reject AI/helper/renderer/import-inference invalidation.

L3 handling:

- Component invalidation or component-affecting invalidation must surface dependent measurements as potentially orphaned/affected.
- Materialization must never silently cascade-drop dependent measurements.
- Exact projection shape for dependent/orphan handling is deferred to the materializer pass.

## 12. Conflict Handling

Conflicts are evidence, not data-loss opportunities.

Rules:

- Unsuperseded divergent human measurements for the same target/mode/context must surface a conflict.
- Latest timestamp must not silently win for divergent measurements.
- `known_facts.json` must preserve conflicting `source_event_ids`.
- Human resolution requires a correction, supersession, or invalidation event.
- Context grouping must consider target, mode, relevant measurement conditions, and future schema-defined equivalence rules.

## 13. Legacy And Back Compatibility

L4 handling:

- V1/V1.1 events without per-event `schema_version` are treated as V1 baseline.
- Old projects must remain loadable when they contain only supported legacy events.
- Mixed-version streams must be validated before projection.
- Unsupported newer canonical events or versions fail closed.
- Imported `known_facts.json` must not be trusted over `events.jsonl`.
- Unknown non-canonical sidecar data may be ignored only if outside the canonical project contract.

## 14. Prohibited Fields And Promotions

Canonical events must not include fields that imply unsafe promotion:

- `ai_confidence`
- `probability`
- `diagnosis`
- `fault_probability`
- `auto_detected`
- `ocr_text_as_fact`
- `cv_component_match`
- `photo_proof`
- `visual_trace_net`
- `template_identity`
- `board_graph_ref`
- `view_state_ref`
- `reference_image_evidence`
- `local_storage_source`
- `damage_proves_fault`
- `suspect_probability`

Forbidden promotions:

- `ai_hint` to `measured`
- `visual_trace` to electrical net
- photo alignment to identity/pin map/net/measurement/fault proof
- damage marker to fault proof
- suspect marker to probability
- template/footprint hint to electrical identity
- reference/candidate/note/helper/source value to measured value without explicit human confirmation as observed reading

## 15. Later Validator Requirements

Future validator passes must cover these requirements:

- actor/source/confirmation enforcement,
- required `schema_version`,
- event type allowlist and alias rejection,
- fail-closed unknown version/event handling,
- value provenance separation,
- target/`Koht`/pin shape,
- relation-chain validity,
- circular correction/supersession rejection,
- missing relation target rejection,
- forbidden field/promotion rejection,
- AI/helper/renderer/import-inference author rejection,
- `board_graph.json` / `view_state.json` rejection when they appear as canonical references,
- legacy and mixed-version stream handling.

## 16. Later Materializer Requirements

Future materializer passes must preserve:

- regenerability of `known_facts.json` from `events.jsonl`,
- value provenance,
- `source_event_ids`,
- conflict source event IDs,
- invalidated event history,
- supersession history,
- component history,
- target history.

Future materializer passes must:

- exclude invalidated events from current projection while retaining history,
- surface conflicts instead of using latest-wins,
- surface component-invalidation-dependent measurements instead of cascade-dropping,
- keep reference/candidate/note/helper/source context non-canonical,
- avoid projecting visual/photo/template/damage/suspect context as electrical fact or probability.

## 17. Required Future Tests

Later implementation passes must add focused tests for:

- schema validation for all accepted event types,
- rejected aliases and unknown canonical event types,
- required `schema_version`,
- fail-closed unsupported version,
- value provenance separation,
- one-tap helper/reference/candidate promotion rejection,
- no AI/helper/renderer/import-inference authored event,
- target/`Koht`/pin and point-to-point handling,
- `measurement_recorded` correction with `supersedes_event_id`,
- `event_invalidated` append-only behavior,
- conflict surfacing and no latest-wins,
- invalidation/orphan dependent-measurement behavior,
- mixed-version stream validation,
- import/export compatibility,
- forbidden artifact/reference rejection for `board_graph.json` and `view_state.json`,
- no Reference Images canonical evidence promotion,
- no visual trace to electrical net promotion.

## 18. Open Items

Open implementation/spec decisions for later passes:

- final schema version label,
- UUIDv7 vs ULID,
- exact numeric and edge-state encoding,
- measurement condition grouping and equivalence,
- whether `corrects_event_id` remains separate from or collapses into `supersedes_event_id`,
- independent pin entities,
- first-class `Koht` entities,
- invalidation reversal event shape,
- component invalidation projection shape,
- user notes and whether a separate note event is needed,
- no-project/invalid-project writer behavior,
- exact write lock mechanism.
