# V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS

## MODEL_ROUTING_CHECK

PASS. GPT Pro architecture-first review completed in `V2_EVENT_WRITING_ARCHITECTURE_PROPOSAL_PATCH_PASS`. Claude Code / Opus re-audit completed in `V2_EVENT_WRITING_ARCHITECTURE_PROPOSAL_RE_AUDIT_PASS` and returned `ACCEPT_READY_FOR_CODEX_SCOPE_LOCK`. Codex role in this pass is docs-only scope-lock capture. No implementation is allowed.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `bd38ff7 docs: record post-smoke V2 route review`.
- Tracked working tree was clean before this docs-only scope-lock record.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`, next `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only. It does not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Architecture acceptance summary

- V2 event-writing architecture is accepted for docs-only scope-lock capture.
- Implementation remains blocked.
- Future implementation work must be split into later individually scoped and audited passes.
- Future implementation passes bind to this captured audit document, not chat memory.

## Full accepted patched architecture text

`	ext
V2_EVENT_WRITING_ARCHITECTURE_PROPOSAL_PATCH_PASS
MODEL_ROUTING_CHECK

Route: GPT_PRO / ARCHITECTURE_PATCH.

Mode: Architecture patch only. No code. No repo edits. No patches. No schema files. No tests. No implementation.

Patch basis: This patched architecture incorporates the supplied Claude Code / Opus audit findings P1–P10 into the prior V2 event-writing architecture proposal. It preserves the current TraceBench / BoardFact governance posture: repo governance docs are authoritative; the uploaded Source Guide remains orientation-only and explicitly says repo governance docs win over the guide.

Protected surface: V2 event writing remains a protected surface. This pass defines architecture for future human-authored canonical writes only.

Next required step: Claude Code / Opus re-audit, audit-only.

Architecture verdict

ACCEPT_READY_FOR_CLAUDE_RE_AUDIT

The patched architecture resolves the audit findings without widening implementation scope. It chooses canonical event names, adds fail-closed schema compatibility, strengthens value provenance, reconciles Koht/pin targeting with existing dotted labels and from/to style measurement contexts, defines conflict handling for divergent human measurements, clarifies event_invalidated, requires a future writer lock/single-writer mechanism, and states the durable capture requirement before implementation.

Executive summary

V2 introduces a narrow canonical write model for three future human-confirmed operations:

Save Measurement
Add Component
Edit Component

The model remains:

Human-confirmed event -> events.jsonl -> materializer -> known_facts.json -> read-only UI

Canonical write authority is restricted to explicit user confirmation through a scoped event-writing path.

Area	Patched decision
Canonical truth	events.jsonl
Projection/cache	known_facts.json
Canonical event names	measurement_recorded, component_created, component_updated, event_invalidated
Event naming convention	Past-tense; one canonical event name per operation; no schema aliases
Supersession event	No standalone event_superseded in V2 initial scope; use supersedes_event_id inside replacement/correction events
Schema compatibility	V2 canonical write events require a bumped schema version and fail-closed handling
Measurement provenance	Human-entered or explicitly human-confirmed measured value; helper/reference/candidate values do not auto-populate canonical measured fields
Koht model	V2 initial scope uses stable target composite, not a separate first-class Koht entity
Measurement conflicts	Divergent un-superseded human measurements for same target/mode are surfaced as conflict, not silently latest-wins
Activity Timeline	Read-only derived compact/toggleable display, not canonical log, not debug log
Writer concurrency	Future writer service must enforce project write lock or single-writer assumption before write UI ships
Durable capture	Codex docs scope-lock must capture the full accepted patched architecture text, not a summary

The central rule remains:

A fact is canonical only after a human explicitly confirms a scoped write operation that appends a valid V2 event to events.jsonl.
Core invariants

Canonical data invariants

events.jsonl = canonical truth
known_facts.json = materialized projection/cache
UI state = non-canonical
helper suggestions = non-canonical
Reference Images = local sidecar only
Board Canvas = read-only projection unless separately scoped
Activity Timeline = read-only derived display, not a canonical log

Human/AI invariant

Human is the sensor.
AI is the graph engine.
AI/helper never authors canonical events or canonical facts.

AI/helper may:

suggest next steps
organize visible gaps
surface candidate/reference/context values
summarize existing accepted facts
help the user navigate

AI/helper must not:

write canonical events
auto-confirm a measurement
auto-create a component
auto-edit a component
auto-invalidate an event
promote candidate/reference/helper/note values into facts
infer fault, probability, net identity, pin mapping, or component identity

Evidence-boundary invariants

The following are never proof by themselves:

visual_trace
photo pixels
photo alignment
damage marker
suspect marker
source/research/reference value
candidate value
note/comment value
template_id
footprint family
Reference Image
helper suggestion
AI/OCR/CV output

Specific prohibitions:

visual_trace is not a net.
template_id / footprint family is not electrical identity.
Photo pixels are not facts.
Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
Damage is not fault proof.
Suspect is not probability.
Reference Images are not evidence.
Guided Measurement Helper is read-only and must not author events.
Renderer/view writes nothing unless explicitly scoped.
board_graph.json is forbidden.
view_state.json is forbidden.

Canonical write boundary

A V2 canonical write occurs only when all conditions hold:

A scoped V2 write operation is active.
The user performs an explicit confirmation action.
The user has entered or explicitly verified the value/fields being saved.
The event declares a supported V2 schema_version.
The event validates against the V2 schema and source-boundary rules.
The event is appended durably to events.jsonl.
The materializer later regenerates known_facts.json from events.jsonl.

The UI may report “saved” only after append success. Full success may require projection refresh as a second staged step.

Actor/source invariants

Canonical events require:

{
  "actor": {
    "type": "human"
  },
  "source": {
    "type": "explicit_user_confirmation"
  },
  "confirmation": {
    "confirmed": true
  }
}

Forbidden canonical event actors/sources include:

ai
helper
ocr
cv
renderer
import_inference
activity_timeline
debug_log
reference_image
photo_alignment
visual_trace
local_storage_demo
telemetry
cloud_sync

Event naming invariants

V2 initial canonical event names are fixed:

measurement_recorded
component_created
component_updated
event_invalidated

No slash alternatives are accepted. No aliases are accepted in schema. Event names are past-tense and describe what the human confirmed happened.

Confirmation & value provenance

V2 measurement integrity depends on separating the measured value from any helper, reference, candidate, or note context.

Required rule

The human must either:

manually enter the measured value, or
explicitly verify a visible value as their own measured reading through the scoped Save Measurement confirmation path.

The measured value stored in measurement_recorded.payload.reading must represent a human-confirmed reading, not an AI/helper/reference/candidate value.

Auto-population prohibition

Helper/reference/candidate values must not auto-populate the confirmable measured field.

Forbidden behavior:

Reference value appears in measured value input automatically.
Candidate value appears in measured value input automatically.
Helper suggestion fills the measured value field.
One-tap confirm promotes a suggested/reference/candidate value as a canonical measurement.
AI/helper creates measurement_recorded from a visible candidate value.

Allowed behavior:

Reference/candidate/helper values may be displayed nearby as context.
The measured value field starts empty or retains only user-entered draft text.
The user may manually type a value after consulting context.
The user may explicitly choose “Kasuta viiteväärtust mõõdetud väärtusena” only if the UI requires a second explicit confirmation that this is their observed reading.

One-tap confirm restriction

A one-tap confirmation must not promote an AI/helper/reference/candidate value into a canonical measurement.

Acceptable one-tap save exists only when the measured field already contains a human-entered or previously explicitly human-verified value. A UI must not make “Confirm suggested value” equivalent to “I measured this.”

Reference/candidate value use

If a reference or candidate value is used, the human must explicitly confirm it as their own reading.

Recommended UI language:

Kinnitan, et see on minu mõõdetud näit.

Not acceptable:

Kasuta soovitatud väärtust faktina

Event provenance requirements

measurement_recorded must record value provenance so projection never conflates these categories:

human-entered measured value,
human-confirmed-from-reference value,
helper suggestion context,
reference/candidate/note context.

Recommended measurement value provenance shape:

"value_provenance": {
  "measured_value_source": "human_entered",
  "entry_method": "typed",
  "human_verified_as_own_reading": true,
  "context_values_visible": [
    {
      "context_type": "reference_value",
      "context_id": "ref_u12_pin3_expected_voltage",
      "display_value": "3.3 V",
      "used_as_measured_value": false
    }
  ]
}

Allowed measured_value_source values for V2 initial scope:

human_entered
human_confirmed_from_reference
human_confirmed_from_candidate

Explicitly non-canonical context source values:

helper_suggestion
reference_value
candidate_value
note_value
source_research_value

These context values may appear only under provenance/context fields. They must not become reading.value unless the human explicitly confirms the value as their own measured reading.

Projection rule

The materializer must project:

the human-confirmed measured value as the measurement
the value provenance as provenance/context
reference/candidate/helper/note values as non-canonical context only

The materializer must not project:

a reference value as a measured value
a candidate value as a measured value
a helper suggestion as a measured value
a note value as a measured value

unless the event explicitly records human confirmation that the value is the user’s measured reading.

AI/helper boundary

AI/helper still never authors canonical events. Even when a human confirms a value after seeing helper context, the canonical source remains:

explicit_user_confirmation

not:

ai_suggestion
helper_suggestion
reference_value
candidate_value
Schema versioning & fail-closed forward compatibility

V2 canonical write event types require a schema version bump.

Required schema version rule

Every canonical event in events.jsonl must declare:

schema_version

V2 canonical write events must use a V2 schema version distinct from V1/V1.1 read-only-era event versions.

Recommended draft label until schema/spec pass:

2.0-draft

Final exact schema version naming is deferred to schema/spec pass, but the bump itself is not optional.

Fail-closed reader rule

Readers encountering unknown canonical event types must fail closed.

Forbidden behavior:

silently ignore unknown canonical write events
silently project known_facts as if complete
load newer-schema project as normal when canonical writes are unsupported
drop unknown canonical events during import

Required behavior:

surface unsupported-version state
block projection that would look complete but is partial
block import/load if canonical event version is unsupported
preserve project data without mutation

Older build behavior

Older builds must not silently ignore unknown V2 canonical write events.

If an older build encounters:

schema_version > supported_schema_version
unknown canonical event_type
known event_type with unsupported schema_version

then it must fail closed or show a clearly unsupported project/version state.

It must not:

load partial known_facts as if current
display stale projection as complete
rewrite events.jsonl
rewrite known_facts.json as if old schema were sufficient

Import behavior

Import of newer-schema projects into older builds must:

fail closed
or surface unsupported-version state

Import must not create a partial accepted project that looks valid.

Re-materialization rule

On import, known_facts.json is projection/cache, not truth.

Required import sequence:

validate events.jsonl
verify supported schema versions and event types
regenerate known_facts.json from events.jsonl
compare or replace imported projection according to accepted spec

Imported known_facts.json must not be trusted over events.jsonl.

Unknown non-canonical sidecar data

Unknown non-canonical sidecar data may be ignored only if it is explicitly outside the canonical project contract.

Examples:

local UI cache outside Project ZIP contract
local Reference Images sidecar outside Project ZIP
non-canonical debug data outside imported canonical package

Unknown files inside the canonical Project ZIP contract must not be silently ignored unless a future spec explicitly classifies them as ignorable non-canonical extensions.

Proposed event model

Canonical V2 event names

V2 initial scope accepts exactly these canonical event names:

measurement_recorded
component_created
component_updated
event_invalidated

Aliases are not accepted:

measurement_saved
component_edited
event_superseded
replaces_event

These names may appear in prose historically but must not be accepted as V2 canonical schema names.

Common event envelope

Required common fields:

Field	Required	Meaning
schema_version	Yes	Supported V2 event schema
event_id	Yes	Globally unique event identity
event_type	Yes	One of the accepted canonical event names
created_at	Yes	Event creation timestamp
project_id	Yes, if project has ID	Project identity
client_operation_id	Yes	Idempotency key for user confirmation attempt
actor	Yes	Human actor metadata
source	Yes	Explicit user confirmation source
confirmation	Yes	Human confirmation record
payload	Yes	Event-specific payload

Allowed common relation fields:

origin_event_id
corrects_event_id
supersedes_event_id
invalidates_event_id

No other relation variants are locked for V2 initial scope.

Not locked:

replacement_event_id
replaces_event_id
parent_event_id
ancestor_event_id
event_superseded

Principle:

minimal distinct relations; no redundant relation variants locked.

Common actor/source rules

Required:

{
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measure_sheet",
    "action": "save_measurement"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:15:32.120Z",
    "label": "Salvesta mõõtmine"
  }
}

Rejected:

{
  "actor": {
    "type": "ai"
  }
}
{
  "source": {
    "type": "guided_measurement_helper_suggestion"
  }
}

Common prohibited fields

Canonical events must not include fields that imply unsafe promotion:

ai_confidence
probability
diagnosis
fault_probability
auto_detected
ocr_text_as_fact
cv_component_match
photo_proof
visual_trace_net
template_identity
board_graph_ref
view_state_ref
reference_image_evidence
local_storage_source
damage_proves_fault
suspect_probability

Event: measurement_recorded

Purpose: record a human-confirmed measurement reading at a target context.

Required payload fields:

Field	Meaning
measurement_id	Stable measurement record ID
measured_at	Measurement time, human-entered or save time
target	Koht/pin/component/from-to target context
reading	Value/unit/mode
value_provenance	Provenance of the measured value
conditions	Board/meter context, minimal
instrument	Meter context or "unspecified"

Allowed reading.mode values:

voltage
resistance
diode
continuity
current

Allowed units:

V
Ω
diode
beep
A

A/current is allowed but advanced by default under:

Lisainfo / Tehnilised detailid

Required value_provenance semantics:

reading.value must be human-entered or explicitly human-confirmed as the user’s own measured value.
reference/candidate/helper values stay context unless explicitly human-confirmed as measured value.

Materializer may derive:

measurement history
active measurement entry
target-linked measurement summary
conflict markers
provenance display

Materializer must not derive:

component health
fault diagnosis
fault probability
confirmed net
confirmed pin map
component identity
visual trace connectivity

Event: component_created

Purpose: record a human-created component entity.

Required payload fields:

Field	Meaning
component_id	Stable component identity
label	Human label
component_kind	Broad kind or unknown
created_context	Human-created context

Allowed payload fields:

reference_designator
component_kind
pin_count
package_hint
footprint_hint
template_id_hint
side
rough_location
rotation_hint
human_note

The component existence is canonical. Hints remain hints.

Materializer may derive:

component entity
current human label/reference designator
human-confirmed broad component kind
display/navigation hints
component history pointer

Materializer must not derive:

electrical identity from template_id
electrical identity from footprint family
net identity
pin mapping from photo alignment
fault status
probability
AI component match

Event: component_updated

Purpose: append a human-confirmed field-level update to an existing component.

Required payload fields:

Field	Meaning
component_id	Existing component
changes	Non-empty field-level change list
edit_reason	Human reason or unspecified

Each change must include:

field
old_value_observed
new_value
change_kind

Allowed change_kind:

set
replace
clear
mark_unknown
correct_typo

Materializer may derive:

latest component projection
component history
previous values in audit/history
field provenance

Materializer must not mutate the prior component_created event.

Event: event_invalidated

Purpose: append a human-authored event that marks a prior event invalid for current projection without deleting or mutating it.

Required payload fields:

Field	Meaning
invalidates_event_id	Prior event being invalidated
target_entity_id	Measurement/component/entity if applicable
reason	Human reason
human_note	Optional human explanation

Allowed reasons:

wrong_component
wrong_pin
wrong_unit
mistyped_value
accidental_save
duplicate
obsolete_entry
other_human_reason

Materializer may derive:

invalidated event marker
current projection exclusion
audit/history entry

Materializer must not:

delete the invalidated event
mutate the invalidated event
hide invalidation history
allow AI/helper invalidation

Supersession strategy

V2 initial scope does not introduce a standalone event_superseded event type.

Instead, a replacement event may include:

supersedes_event_id
corrects_event_id

Example:

A corrected measurement_recorded may include supersedes_event_id pointing to the previous measurement_recorded.

A later schema/spec pass may revisit standalone event_superseded, but V2 initial scope uses embedded relation fields only.

Event examples

Example 1 — measurement_recorded, human-entered voltage

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
  "event_type": "measurement_recorded",
  "created_at": "2026-06-06T10:15:32.410Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8K1PZV3F9C9S4Q2X8M7T5H",
  "actor": {
    "type": "human",
    "actor_id": "local_user",
    "display_name": "Technician"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measure_sheet",
    "action": "save_measurement"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:15:32.120Z",
    "label": "Salvesta mõõtmine"
  },
  "payload": {
    "measurement_id": "meas_01JZ8K1QW3PBKPH5J6Y8D7EM8V",
    "measured_at": "2026-06-06T10:15:00.000Z",
    "target": {
      "target_kind": "component_pin",
      "target_key": "cmp_01JZ7NQWGH8PRY3J9D9T0VQ1SA.pin.3",
      "display_label": "U12.3",
      "component_id": "cmp_01JZ7NQWGH8PRY3J9D9T0VQ1SA",
      "pin_id": "pin_cmp_01JZ7NQWGH8PRY3J9D9T0VQ1SA_3",
      "pin_display_label": "3"
    },
    "reading": {
      "mode": "voltage",
      "value": "3.29",
      "unit": "V",
      "display_value": "3.29 V",
      "polarity": "red_to_pin_black_to_gnd"
    },
    "value_provenance": {
      "measured_value_source": "human_entered",
      "entry_method": "typed",
      "human_verified_as_own_reading": true,
      "context_values_visible": [
        {
          "context_type": "reference_value",
          "context_id": "ref_u12_pin3_expected_voltage",
          "display_value": "3.3 V",
          "used_as_measured_value": false,
          "canonical": false
        }
      ]
    },
    "conditions": {
      "board_power_state": "powered",
      "reference_node": "GND"
    },
    "instrument": {
      "kind": "multimeter",
      "model": "unspecified"
    },
    "human_note": "Stabiilne näit."
  }
}

May project:

{
  "measurement_id": "meas_01JZ8K1QW3PBKPH5J6Y8D7EM8V",
  "source_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
  "target_key": "cmp_01JZ7NQWGH8PRY3J9D9T0VQ1SA.pin.3",
  "display_label": "U12.3",
  "mode": "voltage",
  "value": "3.29",
  "unit": "V",
  "value_provenance": "human_entered",
  "status": "active"
}

Must not project:

U12 is healthy.
U12.3 is confirmed 3V3 net.
The board fault probability decreased.
The visual trace confirms connectivity.

Example 2 — measurement_recorded, point-to-point continuity using existing style labels

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8K7ZTAEXK4MHTGFCG6M1HQ",
  "event_type": "measurement_recorded",
  "created_at": "2026-06-06T10:21:12.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8K7YV1T8D35M94RYN0KBSQ",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measure_sheet",
    "action": "save_measurement"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:21:11.700Z",
    "label": "Salvesta mõõtmine"
  },
  "payload": {
    "measurement_id": "meas_01JZ8K7ZTA3PRDADZ9HHEWHBMG",
    "measured_at": "2026-06-06T10:21:00.000Z",
    "target": {
      "target_kind": "point_to_point",
      "target_key": "Q2.1->R17.1",
      "display_label": "Q2.1 → R17.1",
      "from": {
        "display_label": "Q2.1",
        "component_id": "cmp_q2",
        "pin_id": "pin_cmp_q2_1"
      },
      "to": {
        "display_label": "R17.1",
        "component_id": "cmp_r17",
        "pin_id": "pin_cmp_r17_1"
      }
    },
    "reading": {
      "mode": "continuity",
      "value": "beep",
      "unit": "beep",
      "display_value": "Beep"
    },
    "value_provenance": {
      "measured_value_source": "human_entered",
      "entry_method": "selected_beep_state",
      "human_verified_as_own_reading": true,
      "context_values_visible": []
    },
    "conditions": {
      "board_power_state": "unpowered"
    },
    "instrument": {
      "kind": "multimeter",
      "model": "unspecified"
    }
  }
}

May project:

A human-confirmed continuity reading exists for Q2.1 → R17.1.

Must not project:

Q2.1 and R17.1 are confirmed same net.
The visual trace is a net.
The pin map is proven.

Example 3 — measurement_recorded, human-confirmed from reference

This is allowed only with explicit human verification that the value is their own measured reading.

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8KV1M6ZSPQ0JJM9328XDG9",
  "event_type": "measurement_recorded",
  "created_at": "2026-06-06T10:33:12.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8KV0Z0R3Y14R8VXN81ZVKR",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measure_sheet",
    "action": "save_measurement"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:33:11.600Z",
    "label": "Kinnitan, et see on minu mõõdetud näit"
  },
  "payload": {
    "measurement_id": "meas_01JZ8KV1M68B6DT2BBA1N8S1AA",
    "measured_at": "2026-06-06T10:33:00.000Z",
    "target": {
      "target_kind": "component_pin",
      "target_key": "cmp_u12.pin.3",
      "display_label": "U12.3",
      "component_id": "cmp_u12",
      "pin_id": "pin_cmp_u12_3"
    },
    "reading": {
      "mode": "voltage",
      "value": "3.30",
      "unit": "V",
      "display_value": "3.30 V"
    },
    "value_provenance": {
      "measured_value_source": "human_confirmed_from_reference",
      "entry_method": "explicit_confirm_reference_as_own_reading",
      "human_verified_as_own_reading": true,
      "context_values_visible": [
        {
          "context_type": "reference_value",
          "context_id": "ref_expected_3v3",
          "display_value": "3.30 V",
          "used_as_measured_value": true,
          "canonical": false
        }
      ]
    },
    "conditions": {
      "board_power_state": "powered",
      "reference_node": "GND"
    },
    "instrument": {
      "kind": "multimeter",
      "model": "unspecified"
    }
  }
}

The projection may show the measured value as human-confirmed-from-reference. It must not collapse the reference value into a measurement without the explicit confirmation metadata.

Example 4 — measurement_recorded, current as advanced

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8KAZ7AGJ2ANMKJXK97W7ND",
  "event_type": "measurement_recorded",
  "created_at": "2026-06-06T10:23:30.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8KAYG61XHW58XJXEQE4V69",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measure_sheet",
    "action": "save_measurement",
    "advanced_section": "Lisainfo / Tehnilised detailid"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:23:29.500Z",
    "label": "Salvesta mõõtmine"
  },
  "payload": {
    "measurement_id": "meas_01JZ8KAZ7A9KX8GNDH07RWZB0P",
    "measured_at": "2026-06-06T10:23:00.000Z",
    "target": {
      "target_kind": "supply_input",
      "target_key": "supply_input.current",
      "display_label": "Sisendvool"
    },
    "reading": {
      "mode": "current",
      "value": "0.42",
      "unit": "A",
      "display_value": "0.42 A"
    },
    "value_provenance": {
      "measured_value_source": "human_entered",
      "entry_method": "typed",
      "human_verified_as_own_reading": true,
      "context_values_visible": []
    },
    "conditions": {
      "board_power_state": "powered"
    },
    "instrument": {
      "kind": "multimeter",
      "model": "unspecified"
    }
  }
}

Example 5 — component_created

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8KCZ3P5SZDMM0D9EY0ZT6B",
  "event_type": "component_created",
  "created_at": "2026-06-06T10:25:00.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8KCYTYS4TCZJ4PR28S6YZH",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "component_panel",
    "action": "add_component"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:24:59.700Z",
    "label": "Lisa komponent"
  },
  "payload": {
    "component_id": "cmp_01JZ8KCZ3P4WVEA0BX45RPS3HE",
    "label": "U12",
    "reference_designator": "U12",
    "component_kind": "ic",
    "pin_count": 8,
    "created_context": {
      "method": "human_entry"
    },
    "side": "top",
    "rough_location": {
      "zone": "upper_left",
      "x_hint": 0.31,
      "y_hint": 0.42,
      "coordinate_basis": "ui_hint_not_evidence"
    },
    "footprint_hint": "SOIC-8",
    "template_id_hint": "tpl_soic8_display_hint",
    "human_note": "Lisatud skeemi järgi, mitte foto põhjal."
  }
}

Must not project:

SOIC-8 proves electrical identity.
template_id_hint proves component identity.
rough_location proves physical placement.
photo context proves anything.

Example 6 — component_updated

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8KFHJXG4ZWHQTG1DRZHB3N",
  "event_type": "component_updated",
  "created_at": "2026-06-06T10:27:45.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8KFGYSE2XZB8YKP7CN8YNE",
  "origin_event_id": "evt_01JZ8KCZ3P5SZDMM0D9EY0ZT6B",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "component_panel",
    "action": "edit_component"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:27:44.500Z",
    "label": "Salvesta muudatus"
  },
  "payload": {
    "component_id": "cmp_01JZ8KCZ3P4WVEA0BX45RPS3HE",
    "edit_reason": "Corrected reference designator from board marking.",
    "changes": [
      {
        "field": "reference_designator",
        "old_value_observed": "U12",
        "new_value": "U13",
        "change_kind": "replace"
      }
    ],
    "human_note": "Märgistus luubiga üle kontrollitud."
  }
}

Example 7 — corrected measurement using supersedes_event_id

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8M2V9F21QWM4BQ8D6E6M0N",
  "event_type": "measurement_recorded",
  "created_at": "2026-06-06T11:02:00.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8M2TQVCN4RM48J1JY0HX2B",
  "origin_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
  "corrects_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
  "supersedes_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measurement_history",
    "action": "save_measurement_correction"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T11:01:59.500Z",
    "label": "Salvesta parandus"
  },
  "payload": {
    "measurement_id": "meas_01JZ8M2V9F0QE1DZV19YKJ81AK",
    "measured_at": "2026-06-06T11:01:00.000Z",
    "target": {
      "target_kind": "component_pin",
      "target_key": "cmp_u12.pin.4",
      "display_label": "U12.4",
      "component_id": "cmp_u12",
      "pin_id": "pin_cmp_u12_4"
    },
    "reading": {
      "mode": "voltage",
      "value": "3.29",
      "unit": "V",
      "display_value": "3.29 V"
    },
    "value_provenance": {
      "measured_value_source": "human_entered",
      "entry_method": "typed",
      "human_verified_as_own_reading": true,
      "context_values_visible": []
    },
    "conditions": {
      "board_power_state": "powered",
      "reference_node": "GND"
    },
    "instrument": {
      "kind": "multimeter",
      "model": "unspecified"
    },
    "correction_reason": "Original measurement was saved against U12.3 but was actually taken at U12.4."
  }
}

Example 8 — event_invalidated

{
  "schema_version": "2.0-draft",
  "event_id": "evt_01JZ8KJNESJ3GC9V6PR01R9KT0",
  "event_type": "event_invalidated",
  "created_at": "2026-06-06T10:30:00.000Z",
  "project_id": "prj_01JZ8JY6N2K9B4P5W6R7T8Y9AZ",
  "client_operation_id": "op_01JZ8KJMVDY1CSCTC1KHSZ4YTV",
  "actor": {
    "type": "human",
    "actor_id": "local_user"
  },
  "source": {
    "type": "explicit_user_confirmation",
    "surface": "measurement_history",
    "action": "invalidate_event"
  },
  "confirmation": {
    "confirmed": true,
    "confirmed_at": "2026-06-06T10:29:59.800Z",
    "label": "Märgi kehtetuks"
  },
  "payload": {
    "invalidates_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN",
    "target_entity_id": "meas_01JZ8K1QW3PBKPH5J6Y8D7EM8V",
    "reason": "wrong_pin",
    "human_note": "Mõõtsin tegelikult pin 4, mitte pin 3."
  }
}
Append-only / correction model

events.jsonl is an append-only canonical ledger.

Allowed operation:

append valid new event

Forbidden operations:

edit prior event line
delete prior event line
reorder prior event line
rewrite prior event payload
rewrite events.jsonl from UI correction
directly edit known_facts.json as truth

Corrections are represented by new events.

Scenario	V2 event strategy
Mistyped measurement value	New measurement_recorded with corrects_event_id and supersedes_event_id, or event_invalidated plus new measurement
Wrong pin/component selected	event_invalidated, then optional new measurement_recorded
Component label typo	component_updated
Component hint correction	component_updated
Duplicate accidental save	Idempotency prevents duplicate; if already saved, human may append event_invalidated reason duplicate
Undo component edit	New component_updated restoring previous value
Undo invalidation	New event correcting/superseding the invalidation; no deletion

Silent overwrite prevention

Silent overwrite is prevented by:

no direct mutation API for accepted events
field-level component_updated events
explicit relation fields for corrections
event_id/source_event_id provenance in projection
history/audit view retaining previous values
tests that verify event count increases on edit/correction
tests that verify original event bytes remain unchanged

UI representation

The UI should distinguish:

View	Purpose
Current projection	Compact current technician view
History/audit drawer	Prior values, invalidated events, corrections, provenance
Conflict marker	Divergent active human evidence requiring human resolution

Corrected history may be hidden by default, but not destroyed.

event_invalidated semantics

event_invalidated is a canonical human-authored event.

Required semantics:

event_invalidated is human-authored only.
event_invalidated is append-only.
event_invalidated never deletes the invalidated event.
event_invalidated never mutates the invalidated event.
event_invalidated excludes or marks the invalidated event for current projection according to materializer rules.
event_invalidated remains visible in audit/history.

Reversal / un-invalidation

An invalidation cannot be removed.

Reversal is possible only through a new event.

Allowed reversal strategy:

append a later event that corrects or supersedes the event_invalidated

For V2 initial scope, this uses the same minimal relation fields:

corrects_event_id = <event_invalidated event_id>
supersedes_event_id = <event_invalidated event_id>

No physical deletion occurs.

Invalidation of invalidation

An invalidation can itself be superseded/corrected by a later human event. The materializer must process this relation chain deterministically.

Example:

evt_A = measurement_recorded
evt_B = event_invalidated invalidates evt_A
evt_C = event_invalidated or corrective event corrects/supersedes evt_B

The schema/spec pass must define exact allowed chain shapes, but the architectural rule is fixed: reversal is append-only and human-authored.

Validator rule

Validator must reject event_invalidated if authored by:

AI
helper
renderer
import inference
OCR/CV
activity timeline
debug log
reference image
visual trace

It must also reject invalidation when:

invalidates_event_id does not exist
invalidates_event_id creates an invalid cycle
the event attempts to mutate/delete the invalidated event
the actor/source is not explicit human confirmation
ID / origin / idempotency strategy

ID forms

Recommended ID strategy:

ULID-style or UUIDv7-style sortable unique IDs with type prefixes

Exact UUIDv7 vs ULID choice is deferred to schema/spec pass, but the architecture requires globally collision-resistant, import-safe IDs.

Defined IDs

ID	Required meaning	Recommended form
event_id	Unique canonical event identity	evt_<ULID_or_UUIDv7>
client_operation_id	User confirmation/idempotency attempt key	op_<ULID_or_UUIDv7>
component_id	Stable component identity	cmp_<ULID_or_UUIDv7>
measurement_id	Stable measurement record identity	meas_<ULID_or_UUIDv7>
pin_id	Stable pin target identity when known	pin_<component_id>_<pin_key> initially
target_key	Stable target composite key for measurement grouping	deterministic composite string
project_id	Project identity if present	existing project ID model or prj_<...>

Stable component identity

component_id is identity.

reference_designator is a mutable label.

component_id != U12
component_id remains stable when U12 changes to U13

Pin ID initial strategy

For V2 initial scope:

pin_id = component-derived stable target ID when component and pin are known

Recommended form:

pin_<component_id>_<pin_key>

Example:

pin_cmp_u12_3

This does not prove pin mapping. It is only a target identifier.

If later passes support uncertain package remapping or independent pin entities, the schema/spec pass may move to independent pin_<ULID> entities. V2 initial architecture does not require that.

Target key

For measurement history and conflict grouping, each measurement target requires a stable target_key.

Examples:

cmp_u12.pin.3
Q2.1->R17.1
tp_3.to.gnd
supply_input.current

The target_key is a grouping key. It must not imply net identity.

Minimal relation fields

V2 initial scope defines exactly these relation fields:

Field	Meaning
origin_event_id	Root event in an entity/correction chain
corrects_event_id	This event corrects a specific previous event
supersedes_event_id	This event replaces a previous event for current projection
invalidates_event_id	This event marks a previous event invalid for projection

No redundant relation variants are locked.

Deferred relation variants:

replacement_event_id
replaces_event_id
parent_event_id
ancestor_event_id
event_superseded as standalone event

Principle:

minimal distinct relations; no redundant relation variants locked.

Relation use

Case	Recommended relation
Component created then edited	origin_event_id on component_updated
Measurement corrected with replacement	corrects_event_id + supersedes_event_id on replacement measurement_recorded
Measurement invalidated without replacement	event_invalidated.payload.invalidates_event_id
Invalidation corrected/reversed	Later human event with corrects_event_id and/or supersedes_event_id pointing to invalidation event

Idempotency

Every explicit user-confirmed write attempt must have client_operation_id.

Double-submit handling:

Case	Behavior
Same client_operation_id, byte-equivalent payload	Return existing event/no-op
Same client_operation_id, different payload	Reject as idempotency conflict
Rapid double-click	One event only
Append failed before durable write	Retry may use same client_operation_id
Append succeeded but UI missed response	Retry returns existing event

This aligns with the project’s existing double-submit guard posture while moving canonical protection into the future writer service.

Import/export collision avoidance

On import:

duplicate event_id with byte-identical event = duplicate import/no-op candidate
duplicate event_id with different payload = hard failure
duplicate component_id creation with different event = conflict/failure
duplicate measurement_id with different event = conflict/failure
same client_operation_id with different payload = hard failure
unsupported schema_version = fail closed
Koht / pin targeting model

Existing V1.x measurement/reference data uses from/to style labels such as:

Q2.1 → R17.1

and dotted pin identifiers such as:

Q2.1
R17.1
U12.3

V2 must not diverge from this style without a migration/spec decision.

V2 initial decision

For V2 initial scope, Koht is not a separate first-class persisted entity.

Koht is represented as a stable target context composite in measurement_recorded.payload.target.

Required target fields:

Field	Meaning
target_kind	component_pin, point_to_point, test_point, supply_input, etc.
target_key	Stable grouping key for measurement history/import/export
display_label	Technician-facing label such as Q2.1 → R17.1
component_id	Included when known
pin_id	Included when known
from / to	Included for point-to-point readings

This preserves existing label style while providing stable IDs where known.

Target examples

Component pin:

{
  "target_kind": "component_pin",
  "target_key": "cmp_q2.pin.1",
  "display_label": "Q2.1",
  "component_id": "cmp_q2",
  "pin_id": "pin_cmp_q2_1",
  "pin_display_label": "1"
}

Point-to-point:

{
  "target_kind": "point_to_point",
  "target_key": "Q2.1->R17.1",
  "display_label": "Q2.1 → R17.1",
  "from": {
    "display_label": "Q2.1",
    "component_id": "cmp_q2",
    "pin_id": "pin_cmp_q2_1"
  },
  "to": {
    "display_label": "R17.1",
    "component_id": "cmp_r17",
    "pin_id": "pin_cmp_r17_1"
  }
}

Stability principle

Koht identity must remain stable enough for measurement history and import/export, but must not imply net identity.

Pin identity boundary

pin_id must not imply confirmed pin mapping unless the human has explicitly confirmed that mapping through a future scoped workflow.

In V2 initial scope:

pin_id identifies the selected measurement target.
pin_id does not prove schematic pin map.
pin_id does not prove package orientation.
pin_id does not prove net connectivity.
pin_id does not prove visual/photo alignment.

Future migration

If a later pass introduces first-class Koht entities, it must include:

migration/spec decision
import/export compatibility
projection update
validator rules
explicit no-net-identity boundary
Claude/Opus audit
Save Measurement architecture

User action

A measurement_recorded event is created only when the user explicitly confirms Save Measurement.

Allowed confirmation surfaces:

Measure Sheet save button
focused confirmation dialog
clear keyboard shortcut bound to visible save action

Forbidden:

auto-save on field blur
auto-save from helper suggestion
auto-save from selected reference value
auto-save on navigation
auto-save from renderer/view
background write
one-tap confirm of AI/helper/reference/candidate value as measurement

Required confirmation

The user must confirm:

target/context
measurement mode
measured value
unit
conditions when required
value provenance

Value representation

Recommended canonical reading shape:

{
  "mode": "voltage",
  "value": "3.29",
  "unit": "V",
  "display_value": "3.29 V"
}

Use decimal strings for numeric values until schema/spec pass decides exact numeric encoding. This avoids floating point ambiguity.

Supported edge states:

OL
over_range
under_range
unstable
not_measured

These are reading states, not diagnoses.

Unit representation

Primary units:

V
Ω
diode
beep

Advanced unit:

A

UI display:

Canonical unit	UI label
V	V
Ω	Ω
diode	Diood
beep	Piiks / Beep
A	A / vool under Lisainfo / Tehnilised detailid

Target representation

The selected Koht/component/pin/context is represented through target composite:

target_kind
target_key
display_label
component_id when known
pin_id when known
from/to when point-to-point

It must preserve existing labels like:

Q2.1
R17.1
Q2.1 → R17.1

Evidence limitations

A saved measurement proves:

A human recorded this reading for this target context at this time under these stated conditions.

It does not prove:

component health
fault
probability
net identity
pin mapping
component identity
photo alignment
visual trace connectivity
schematic correctness

After-save momentum

Allowed after successful append:

show “Mõõtmine salvestatud”
keep selected Koht/context
keep mode/unit when useful
suggest next pin/point as workflow aid
show incomplete adjacent targets

Forbidden:

diagnosis
fault probability
confidence score
automatic fact creation
automatic event creation
helper-authored measurement
net inference from sequence

Recommended UI copy:

Mõõtmine salvestatud. Koht jäi valituks.
Soovitus järgmise mõõtmise jaoks ei ole fakt enne salvestamist.
Add Component architecture

User action

A component_created event is created only when the user explicitly confirms Add Component.

Allowed confirmation surface:

Lisa komponent

Required fields

Minimum payload:

component_id
label
component_kind or unknown
created_context

Allowed fields

reference_designator
component_kind
pin_count
package_hint
footprint_hint
template_id_hint
side
rough_location
rotation_hint
human_note

Unconfirmed fields

The following remain hints/context:

package_hint
footprint_hint
template_id_hint
side
rough_location
rotation_hint
photo_context
visual placement

They must not prove:

electrical identity
pin map
net connectivity
physical placement
fault
probability

Template / footprint boundary

Use defensive field names:

template_id_hint
footprint_hint
package_hint

Avoid canonical field names implying proof:

confirmed_template_identity
electrical_identity_from_template
confirmed_footprint

Visual/photo boundary

rough_location is only navigation/display context.

It must not become:

pin mapping
net identity
component identity proof
measurement target proof
fault proof

Duplicate/conflict handling

Duplicate detection may assist but not write.

Allowed:

“See võib dubleerida U12. Kontrolli enne salvestamist.”

Forbidden:

AI merges components automatically.
AI rejects duplicate without user decision.
AI invalidates duplicate component.
AI writes correction event.

Materializer behavior:

Case	Projection
Same component_id create twice	Validator rejects
Same reference designator on different components	Conflict marker
User intentionally keeps duplicate labels	Allowed only if schema/spec supports ambiguous labels
User resolves duplicate	New human-authored component_updated or event_invalidated
Edit Component architecture

User action

A component_updated event is created only when the user explicitly confirms Edit Component.

Allowed confirmation surface:

Salvesta muudatus

No mutation

Editing never changes the original component_created event.

Allowed:

append component_updated
append event_invalidated
append later correction event

Forbidden:

modify component_created payload
delete previous event
rewrite component history
directly edit known_facts.json

Field-level changes

Each edit records field-level changes:

{
  "field": "reference_designator",
  "old_value_observed": "U12",
  "new_value": "U13",
  "change_kind": "replace"
}

old_value_observed is a review aid. The materializer computes actual prior value from event history.

Allowed initial edit fields

label
reference_designator
component_kind
pin_count
package_hint
footprint_hint
template_id_hint
side
rough_location
rotation_hint
human_note
status

Dangerous fields deferred

These require future scope locks:

net assignment
pin map
fault status
component electrical identity from source
photo-derived identity
AI-derived identity
visual-trace-derived connectivity

Latest projection selection

For mutable component label/hint fields:

component_created -> apply valid component_updated events in event order -> current projection

If conflict appears, projection must surface conflict rather than silently choosing unsafe data.

Undo

Undo is a new component_updated event restoring a previous value. It does not remove the earlier edit.

Materializer / projection model

Regeneration principle

known_facts.json is fully regenerable from events.jsonl.

Pipeline:

read events.jsonl
validate schema versions and event types
validate actor/source/provenance
build event index
resolve invalidation/correction/supersession chains
project components
project measurements
project conflicts
write known_facts.json as projection/cache

Projection provenance

Every projected fact/value should preserve enough provenance to show:

source_event_id
event_type
schema_version
value_provenance where applicable
invalidated/superseded status where applicable
conflicting source event IDs where applicable

Components

Project from:

component_created
component_updated
event_invalidated where relevant

Projection may include:

{
  "component_id": "cmp_...",
  "current": {
    "reference_designator": "U13",
    "component_kind": "ic",
    "pin_count": 8
  },
  "hints": {
    "footprint_hint": "SOIC-8",
    "template_id_hint": "tpl_soic8_display_hint"
  },
  "history": {
    "created_by_event_id": "evt_...",
    "updated_by_event_ids": ["evt_..."],
    "invalidated_event_ids": []
  }
}

Measurements

Project from:

measurement_recorded
event_invalidated
supersedes_event_id/corrects_event_id relation chains

Projection must preserve measurement history. It may provide current summaries only when conflict rules allow it.

Reference/candidate/note separation

Projection must keep these separate:

canonical facts
reference values
candidate values
notes
helper suggestions
activity status

Only canonical event payload values confirmed through explicit human event-writing flow may become facts.

AI/helper suggestions

AI/helper suggestions may be displayed as UI guidance. They must not appear in known_facts.json as facts unless a human creates a valid canonical event. Even then, the event must preserve value provenance and explicit confirmation.

Conflict handling rules

Core conflict invariant

Explicit supersession/correction chains may resolve deterministically.

Un-superseded divergent human measurements for the same Koht/target/mode must be surfaced as conflict.

The materializer must not silently auto-resolve divergent measurements by:

latest timestamp wins
latest event wins
highest confidence wins
helper recommendation wins
reference value wins

Conflict grouping

For measurement conflicts, grouping key should include at minimum:

target_key
reading.mode
conditions that materially affect reading

The schema/spec pass must define exact condition grouping, but V2 architecture requires that materially different conditions not be collapsed.

Example:

U12.3 voltage powered vs U12.3 voltage unpowered are different contexts.
Q2.1 → R17.1 continuity unpowered repeated readings are same conflict group unless superseded/resolved.

Divergent active measurements

If two valid active measurement_recorded events exist for:

same target_key
same mode
same materially equivalent conditions
different value/display_value
no supersession/correction/invalidation relation resolving them

projection must surface a conflict.

Example projection:

{
  "target_key": "cmp_u12.pin.3",
  "display_label": "U12.3",
  "mode": "voltage",
  "status": "conflict",
  "conflicting_values": [
    {
      "value": "3.29",
      "unit": "V",
      "source_event_id": "evt_01JZ8K1QW3Z7S9K6M2T4A8V0BN"
    },
    {
      "value": "0.12",
      "unit": "V",
      "source_event_id": "evt_01JZ8M9999AAAAAABBBBBCCCC"
    }
  ]
}

Human resolution

Human resolution requires a new canonical event:

event_invalidated
measurement_recorded with supersedes_event_id
measurement_recorded with corrects_event_id + supersedes_event_id

The materializer must not resolve the conflict on its own.

Component conflicts

Component conflicts such as duplicate active reference designators must be surfaced with source event IDs.

Example:

{
  "reference_designator": {
    "status": "conflict",
    "values": [
      {
        "value": "U12",
        "component_id": "cmp_a",
        "source_event_id": "evt_a"
      },
      {
        "value": "U12",
        "component_id": "cmp_b",
        "source_event_id": "evt_b"
      }
    ]
  }
}
Validator / schema model

Validator responsibilities:

Validate event JSON structure.
Validate schema_version.
Fail closed on unsupported canonical event types.
Validate common envelope fields.
Validate event-specific payload fields.
Validate actor/source/confirmation.
Validate value provenance.
Validate reference integrity.
Validate ID uniqueness.
Validate idempotency behavior.
Validate relation fields and correction chains.
Reject prohibited fields and unsafe source promotion.
Reject forbidden artifacts.

Common checks

schema_version present and supported
event_id valid and unique
event_type is one of measurement_recorded/component_created/component_updated/event_invalidated
created_at valid timestamp
actor.type == human
source.type == explicit_user_confirmation
confirmation.confirmed == true
client_operation_id present
payload valid for event_type

Measurement checks

measurement_id present and unique
target.target_kind present
target.target_key present and stable
target.display_label present
from/to present for point_to_point
reading.mode allowed
reading.unit compatible with mode
reading.value compatible with mode
value_provenance present
value_provenance.human_verified_as_own_reading == true
helper/reference/candidate context not stored as measured value without explicit human confirmation
A/current allowed but marked advanced-capable

Component checks

component_id unique on component_created
component_id exists on component_updated
changes non-empty
changed fields allowed
old/new values compatible
template_id appears only as template_id_hint or equivalent hint field
footprint appears only as hint unless later scoped

Invalidation checks

event_invalidated actor/source must be human explicit confirmation
invalidates_event_id exists
invalidates_event_id does not create invalid cycle
invalidated event is not deleted or mutated
AI/helper/renderer/import-inference invalidation rejected

Schema forward-compat checks

unsupported schema_version fails closed
unknown canonical event_type fails closed
known event_type with unsupported version fails closed
older builds must not silently project partial known_facts

Prohibited source checks

Reject canonical events that use:

AI/helper as actor
OCR/CV as source
renderer as source
activity timeline as source
debug log as source
Reference Image as evidence/source
visual_trace as net
photo alignment as pin map
template_id as electrical identity
damage as fault proof
suspect as probability
reference/candidate value as measurement without human confirmation provenance

Forbidden artifact checks

Project validation must reject:

board_graph.json
view_state.json

unless a future protected scope lock explicitly changes that.

Project ZIP / import-export / back-compat model

Export behavior

Project ZIP exports canonical project contract files only.

Expected:

events.jsonl
known_facts.json as projection/cache
accepted project metadata/assets under current ZIP contract

Excluded:

.tracebench_local
Reference Images sidecar
local UI state
debug logs
activity timeline cache
board_graph.json
view_state.json
localStorage/demo artifacts

Import validation

Import sequence:

unpack to staging
reject forbidden files
validate events.jsonl
validate schema versions and event types
fail closed on unsupported canonical writes
validate event IDs/references/relations
validate actor/source/provenance
regenerate known_facts.json from events.jsonl
compare imported projection if present
load only after validation/materialization succeeds

Re-materialization

On import:

events.jsonl is truth after validation
known_facts.json is projection/cache
imported known_facts.json must be regenerated

If imported known_facts.json differs from regenerated projection:

prefer regenerated projection
surface stale projection warning if useful
fail only when mismatch indicates invalid canonical data or unsupported schema

Backwards compatibility

Project type	Behavior
V1 project	Load under accepted V1 semantics
V1.1 project	Load read-only technician layer
V2 project	Load only if V2 schema versions/event types are supported
Newer-than-supported project	Fail closed / unsupported-version state
Mixed project	Validate all known events; fail closed on unsupported canonical writes

Older builds

Older builds must not silently ignore V2 canonical write events. They must not project stale or partial known_facts.json as complete.

Unknown non-canonical sidecars

Can be ignored only when explicitly outside canonical Project ZIP contract. Otherwise, import must fail or require spec-defined extension handling.

Reference Images

Reference Images remain:

local sidecar only
outside Project ZIP
outside events.jsonl
outside known_facts.json
outside materializer
outside AI/OCR/CV
not evidence
Activity Timeline separation

Activity Timeline is a read-only derived display.

It is not:

events.jsonl
debug log
canonical event table
spreadsheet-style event editor
second persisted writable log
canonical storage

It may derive from:

canonical events
optional ephemeral UI status
validator/import status

The display must clearly distinguish:

Timeline item	Canonical?	Source
Measurement saved	Yes, derived from measurement_recorded	
Component added	Yes, derived from component_created	
Component edited	Yes, derived from component_updated	
Event invalidated	Yes, derived from event_invalidated	
Helper suggestion shown	No	Ephemeral UI
Import warning	No, unless event-backed	Tool/UI status
Validation warning	No	Validator status

Activity Timeline must not allow editing canonical events.

Allowed interaction:

open related record
open history/audit view
filter visible activity items
collapse/expand display

Forbidden interaction:

edit event JSON
delete event
rewrite event
invalidate event directly from timeline unless separately scoped as a human-confirmed event-writing flow
drag/reorder canonical history

UI posture:

compact
toggleable
bottom bar / drawer / non-dominant side region
latest few items by default
expandable history if scoped

Sequencing:

Activity Timeline should be scoped with or after V2 writes.
It must not precede canonical write architecture.
It must not become the canonical implementation vehicle.
Measure Momentum rules

Measure Momentum is a post-save workflow aid, not a canonical writer.

Allowed after successful measurement_recorded append:

show confirmation
keep selected Koht/context
keep selected mode/unit when useful
suggest next pin/point
surface incomplete adjacent target as suggestion

Forbidden:

diagnosis
fault probability
confidence score
AI-created facts
helper-authored events
automatic measurement creation
automatic component creation
automatic invalidation
net inference
pin map inference

Momentum copy should preserve boundary:

Soovitus järgmise mõõtmise jaoks ei ole fakt enne salvestamist.

Future Measure Momentum pass must define:

allowed suggestion sources
exact UI copy
non-canonical labeling
tests proving no event is written by helper
tests proving no diagnosis/probability language
tests proving selected context retention
Error / rollback / crash safety

Append failure

If append fails:

do not show saved
keep draft in UI memory
show error
allow retry with same client_operation_id
do not materialize
do not mutate known_facts.json

UI copy:

Salvestamine ebaõnnestus. Mõõtmist ei lisatud.

Materialization failure after append

If append succeeds but materialization fails:

event remains canonical
known_facts.json may be stale
UI must not pretend projection is refreshed
recovery should regenerate projection from events.jsonl

UI copy:

Sündmus salvestatud, kuid vaade vajab taastamist.

Staged commit model

Architecture uses staged durability:

validate event
acquire project write lock / single-writer guard
append event durably
verify append/readback
materialize projection to temp file
atomic rename projection
refresh UI

events.jsonl append is the canonical commit. known_facts.json is replaceable projection/cache.

False saved-state prevention

State	Meaning
Salvestan…	In progress
Salvestatud	Append and projection refresh succeeded
Sündmus salvestatud, vaade vajab värskendust	Append succeeded, projection failed
Ei salvestatud	Append failed

Never show Salvestatud before append success.

Single-writer / project-lock requirement

V2 writer needs either:

project write lock
or enforced single-writer assumption

Concurrent app instances appending to the same events.jsonl are a corruption risk.

Exact locking mechanism is deferred to V2_EVENT_WRITER_SERVICE_PASS, but the architecture requires that the writer service handles this before any write UI ships.

No Save Measurement / Add Component / Edit Component UI may ship until the writer service has a defined and tested project write lock or single-writer guard.

Corruption protection

Future writer service should provide:

single-writer/project lock
line-delimited JSON validation before append
append staging discipline
post-append readback
fsync or platform-appropriate durable write where available
projection temp file + atomic rename
stale projection detection
malformed import quarantine
Security / trust boundary

Trusted boundary

The trusted canonical actor is the human using an explicit scoped write flow.

Canonical events cannot come from:

AI
helper
OCR/CV
renderer
Reference Images
visual trace
photo alignment
activity timeline
debug log
import inference
telemetry/cloud sync
localStorage demo cache

No hidden writes

Forbidden write paths:

renderer paint/update
Board Canvas interaction
Reference Images interaction
Guided Measurement Helper suggestion
Activity Timeline render
background helper
OCR/CV analyzer
URL/source search
telemetry/cloud sync
localStorage/demo cache

No remote dependency

Production core write path must not require:

Google Fonts
remote CSS/JS
cloud service
license server
AI service
external search
remote resource pack

Core desktop workflow must remain local-first and usable offline.

Prototype localStorage boundary

Prototype localStorage is demo-only.

Forbidden production use:

canonical event store
evidence source
durable projection
import/export source of truth
measurement draft persistence that looks canonical
Future implementation pass split
Order	Pass	Purpose	Owner/model
1	V2_EVENT_WRITING_ARCHITECTURE_PROPOSAL_RE_AUDIT_PASS	Re-audit patched architecture	Claude Code / Opus, AUDIT_ONLY
2	V2_EVENT_WRITING_DOCS_SCOPE_LOCK_PASS	Capture full accepted patched architecture text in docs	Codex docs-only
3	V2_EVENT_SCHEMA_SPEC_PASS	Draft event spec/schema docs	Codex
4	V2_EVENT_SCHEMA_AUDIT_PASS	Audit schema/version/provenance/fail-closed behavior	Claude Code / Opus
5	V2_VALIDATOR_EXTENSION_PASS	Add V2 validator support	Codex
6	V2_VALIDATOR_EXTENSION_AUDIT_PASS	Audit validator and negative guards	Claude Code / Opus
7	V2_MATERIALIZER_PROJECTION_PASS	Project V2 events into known_facts.json	Codex
8	V2_MATERIALIZER_AUDIT_PASS	Audit projection/evidence/conflict behavior	Claude Code / Opus
9	V2_EVENT_WRITER_SERVICE_PASS	Implement append/idempotency/locking service	Codex
10	V2_EVENT_WRITER_SERVICE_AUDIT_PASS	Audit writer safety and crash behavior	Claude Code / Opus
11	V2_SAVE_MEASUREMENT_IMPLEMENTATION_PASS	Wire Save Measurement to writer	Codex
12	V2_SAVE_MEASUREMENT_AUDIT_PASS	Audit value provenance/no helper writes	Claude Code / Opus
13	V2_ADD_COMPONENT_IMPLEMENTATION_PASS	Implement Add Component event flow	Codex
14	V2_ADD_COMPONENT_AUDIT_PASS	Audit identity/evidence boundaries	Claude Code / Opus
15	V2_EDIT_COMPONENT_IMPLEMENTATION_PASS	Implement field-level component edits	Codex
16	V2_EDIT_COMPONENT_AUDIT_PASS	Audit correction/history behavior	Claude Code / Opus
17	V2_PROJECT_ZIP_IMPORT_EXPORT_PASS	Extend import/export if required	Codex
18	V2_PROJECT_ZIP_AUDIT_PASS	Audit back-compat/fail-closed behavior	Claude Code / Opus
19	V2_ACTIVITY_TIMELINE_SCOPE_LOCK_PASS	Scope compact derived timeline	GPT Pro or Claude
20	V2_ACTIVITY_TIMELINE_IMPLEMENTATION_PASS	Implement read-only derived display	Codex
21	V2_MEASURE_MOMENTUM_SCOPE_LOCK_PASS	Scope non-canonical post-save momentum	GPT Pro
22	V2_MEASURE_MOMENTUM_IMPLEMENTATION_PASS	Implement only after guards	Codex
23	V2_CONSOLIDATED_SMOKE_QA_PASS	End-to-end smoke/regression	Codex + Claude audit

Do not combine schema, validator, materializer, writer, UI, ZIP, Activity Timeline, and Measure Momentum into one implementation pass.

File / surface risk map
Surface	Risk	Owning future pass
schemas/**	High	V2_EVENT_SCHEMA_SPEC_PASS
validators/tools	High	V2_VALIDATOR_EXTENSION_PASS
materializer	High	V2_MATERIALIZER_PROJECTION_PASS
Project ZIP import/export	High	V2_PROJECT_ZIP_IMPORT_EXPORT_PASS
event writer/service library	Critical	V2_EVENT_WRITER_SERVICE_PASS
Measure Sheet UI	High	V2_SAVE_MEASUREMENT_IMPLEMENTATION_PASS
component UI/model	High	V2_ADD_COMPONENT_IMPLEMENTATION_PASS, V2_EDIT_COMPONENT_IMPLEMENTATION_PASS
tests	Medium-high	Each implementation pass owns focused tests
docs/governance	Medium-high	V2_EVENT_WRITING_DOCS_SCOPE_LOCK_PASS
known_facts.json projection shape	High	V2_MATERIALIZER_PROJECTION_PASS
import migration fixtures	High	V2_PROJECT_ZIP_IMPORT_EXPORT_PASS
Activity Timeline UI	Medium-high	V2_ACTIVITY_TIMELINE_SCOPE_LOCK_PASS and implementation
Measure Momentum UI/helper	High	V2_MEASURE_MOMENTUM_SCOPE_LOCK_PASS and implementation

Surfaces forbidden unless separately scoped:

Board Canvas write/edit behavior
Reference Images runtime
AI/OCR/CV
URL/source search
platform folders
generated artifacts
tags/releases
commercial/licensing/cloud sync
remote resource dependency
board_graph.json
view_state.json
Required tests

Event schema validation tests

valid measurement_recorded
valid component_created
valid component_updated
valid event_invalidated
reject measurement_saved alias
reject component_edited alias
reject event_superseded as canonical V2 initial event
missing schema_version rejected
unsupported schema_version fails closed
unknown canonical event_type fails closed
invalid timestamp rejected
invalid unit/mode pair rejected
prohibited field rejected

Confirmation & value provenance tests

measurement requires value_provenance
human_entered value accepted
human_confirmed_from_reference accepted only with explicit human verification
reference value visible as context does not become reading.value
candidate value visible as context does not become reading.value
helper suggestion visible as context does not become reading.value
one-tap helper/reference/candidate confirm rejected
AI/helper cannot author measured value event
projection preserves value provenance

Event append tests

append valid event
reject invalid event before append
append preserves existing event lines
no mutation of prior event
post-append readback succeeds
append failure leaves events.jsonl unchanged
write lock/single-writer behavior enforced before UI write ships

Idempotency / double-submit tests

same client_operation_id same payload returns same event/no-op
same client_operation_id different payload rejected
rapid double click creates one event
retry after append success does not duplicate
retry after append failure can succeed with same operation ID

Correction / invalidation tests

event_invalidated excludes target from current projection
event_invalidated does not delete/mutate invalidated event
event_invalidated is rejected from AI/helper/renderer/import-inference
invalidation reversal requires new event
invalidation can be corrected/superseded by later event
corrected measurement remains in history
component_updated applies field-level latest value
undo creates new update event
circular correction chain rejected
missing relation target rejected

Conflict handling tests

un-superseded divergent same target/mode measurements surface conflict
latest timestamp does not silently resolve divergent measurements
explicit supersedes_event_id resolves deterministically
event_invalidated resolves active conflict only when human-authored
known_facts projection includes conflicting source_event_ids
component duplicate reference designator surfaces conflict

Koht / pin targeting tests

component_pin target accepts dotted display label such as Q2.1
point_to_point target accepts Q2.1 → R17.1 style
target_key stable across import/export
pin_id does not imply net identity
pin_id does not imply confirmed pin mapping
target composite groups measurement history

Materializer projection tests

projects component_created
projects component_updated latest value
preserves component history
projects measurement history
projects measurement provenance
excludes invalidated events from active projection
represents conflicts safely
does not project AI/helper suggestions
does not project reference/candidate/note values as facts
does not latest-wins divergent measurements

Validator negative guards

reject AI-authored canonical event
reject helper-authored canonical event
reject renderer-authored canonical event
reject import-inference-authored invalidation
reject Reference Image as evidence source
reject visual_trace-to-net
reject template_id-to-electrical-identity
reject photo-alignment-to-pin-map
reject damage-to-fault-proof
reject suspect-to-probability
reject board_graph.json
reject view_state.json

Project ZIP/import-export tests

V2 project exports events.jsonl
V2 project exports regenerated known_facts.json or accepted projection/cache
Reference Images excluded
.tracebench_local excluded
board_graph.json rejected
view_state.json rejected
import validates events before load
import regenerates projection
import newer schema into unsupported build fails closed
unknown canonical event type fails closed
older builds do not silently ignore V2 canonical events
duplicate event ID with conflict rejected
V1 project remains loadable
V1.1 project remains loadable

UI widget tests

Save Measurement disabled until valid human-entered/verified fields
Save Measurement requires explicit user action
helper/reference/candidate values do not auto-populate measured field
one-tap confirm of suggested value rejected
double click creates one write request
success shown only after append success
append failure shows not saved
materialization failure shows partial recovery state
A/current hidden under Lisainfo / Tehnilised detailid by default
Guided Measurement Helper does not write events
Activity Timeline does not write or edit events

Analyzer baseline guard

existing analyzer/read-only tests remain green
no AI/OCR/CV promotion added
no Board Canvas write path added
no Reference Images evidence path added

validate_all.py integration

validate_all.py runs V2 event validation
validate_all.py checks schema_version fail-closed behavior
validate_all.py checks forbidden artifacts
validate_all.py catches prohibited source promotion
validate_all.py catches unsafe value provenance
validate_all.py remains compatible with V1/V1.1 fixtures
Hard forbidden surfaces

This architecture patch pass does not authorize:

code changes
repo file edits
implementation patches
schema files
tests
event writer implementation
UI implementation
materializer changes
validator changes
Project ZIP behavior changes
Board Canvas changes
Reference Images runtime changes
AI/OCR/CV changes
URL/source search changes
platform folder changes
generated artifact changes
tags/releases
commercial/licensing/cloud implementation

V2 implementation remains blocked until re-audit and durable docs scope-lock acceptance.

Open questions

Real decisions still needed before implementation:

Final schema version label
Exact naming such as 2.0, 2.0.0, or 2.0-draft belongs to schema/spec pass.
UUIDv7 vs ULID
Architecture requires sortable collision-resistant IDs; exact helper/library choice is deferred.
Exact numeric encoding
Decimal string is recommended; schema/spec pass must decide final decimal/range/edge-state encoding.
Material condition grouping
Conflict rules require condition-aware grouping; schema/spec pass must define exact equivalence rules.
Independent pin entities
V2 initial scope uses component-derived pin_id; future pin map/remap support may require independent pin entities.
First-class Koht entities
V2 initial scope uses target composite. First-class Koht entity requires migration/spec decision.
Invalidation reversal event shape
Architecture requires append-only reversal via later event; schema/spec pass must define exact allowed event shape.
Component invalidation
Decide later whether generic event_invalidated is sufficient or a dedicated component status event is needed.
User notes
user_note_added is deferred; notes must not become Activity Timeline or facts.
No-project / invalid-project behavior
Writer UI must define behavior when no valid project is loaded.
Exact project write lock mechanism
Required before write UI ships; implementation details belong to event writer service pass.
Activity Timeline persistence
Timeline should be derived and read-only. Any cached timeline data must remain non-canonical and non-writable.
Architecture patch checklist

P1 — Confirmation and value provenance: RESOLVED

Resolved by adding Confirmation & value provenance section and integrating value_provenance into measurement_recorded.

Specific resolution:

human must enter or explicitly verify measured value
helper/reference/candidate values must not auto-populate measured field
one-tap promotion of helper/reference/candidate values is forbidden
reference/candidate value can be used only after explicit human confirmation as own reading
event records measured value provenance
projection must distinguish human-entered, human-confirmed-from-reference, helper context, reference/candidate/note context
AI/helper never authors canonical events

P2 — Schema versioning and fail-closed forward compatibility: RESOLVED

Resolved by adding Schema versioning & fail-closed forward compatibility section.

Specific resolution:

V2 canonical write event types require schema_version bump
each canonical event declares schema_version
unknown canonical event types fail closed
older builds must not silently ignore unknown canonical writes
older builds must not project partial known_facts as complete
newer-schema imports fail closed or unsupported-version state
import regenerates known_facts from events
known_facts is projection/cache, not truth
unknown non-canonical sidecar ignored only if outside canonical contract

P3 — Materializer conflict rule: RESOLVED

Resolved in Materializer / projection model and Conflict handling rules.

Specific resolution:

explicit supersession/correction chains may resolve deterministically
un-superseded divergent same target/mode measurements surface conflict
latest timestamp wins is forbidden for divergent measurements
human resolution requires correction/supersession/invalidation event
known_facts projection preserves conflicting source_event_ids

P4 — event_invalidated semantics: RESOLVED

Resolved by adding event_invalidated semantics section.

Specific resolution:

event_invalidated is human-authored only
append-only
never deletes or mutates invalidated event
reversal/un-invalidation requires new event
invalidation can itself be corrected/superseded later
validator rejects AI/helper/renderer/import-inference invalidation

P5 — Event naming decisions: RESOLVED

Resolved in Proposed event model.

Canonical event names selected:

measurement_recorded
component_created
component_updated
event_invalidated

Specific resolution:

event names are past-tense
one canonical event name per operation
aliases are not accepted in schema
measurement_saved and component_edited are rejected aliases
event_superseded is not V2 initial canonical event type
supersedes_event_id inside replacement/correction events is used for V2 initial scope

P6 — ID/relation taxonomy: RESOLVED

Resolved in ID / origin / idempotency strategy.

Specific resolution:

event_id defined
client_operation_id defined
component_id defined
measurement_id defined
pin_id defined
target_key defined
minimal relation fields defined:
origin_event_id
corrects_event_id
supersedes_event_id
invalidates_event_id

Deferred relation variants follow the explicit principle:

minimal distinct relations; no redundant relation variants locked.

P7 — Koht / pin model reconciled with current data: RESOLVED

Resolved by adding Koht / pin targeting model.

Specific resolution:

existing v1.x Q2.1 → R17.1 and dotted pin labels are preserved
V2 must not diverge without migration/spec decision
V2 initial Koht is target context composite, not first-class persisted entity
target includes component_id when known, pin_id when known, display label, optional from/to
Koht identity stable enough for history/import/export but not net identity
pin_id does not imply confirmed pin mapping unless human-confirmed in future scoped workflow

P8 — Activity Timeline derivation: RESOLVED

Resolved in Activity Timeline separation.

Specific resolution:

Activity Timeline is read-only derived display
may derive from canonical events and optional ephemeral UI status
must not become second persisted writable log
must not be events.jsonl
must not be debug log
must not allow editing canonical events
must remain compact/toggleable
should be scoped with/after V2 writes

P9 — Single-writer / project-lock assumption: RESOLVED

Resolved in Error / rollback / crash safety.

Specific resolution:

V2 writer needs project write lock or single-writer assumption
concurrent app instances appending to same events.jsonl are corruption risk
exact locking mechanism deferred to event writer service pass
writer service must handle lock/single-writer guard before any write UI ships

P10 — Durable architecture capture: RESOLVED

Resolved in Recommended next pass and Final gate statement.

Specific resolution:

Codex docs scope-lock must capture full accepted patched architecture text, not summary/highlights
future implementation passes bind to accepted architecture doc, not chat memory
no implementation starts until Claude/Opus re-audits this patched architecture, Codex captures it in docs-only scope-lock, and that scope-lock is accepted
Recommended next pass

V2_EVENT_WRITING_ARCHITECTURE_PROPOSAL_RE_AUDIT_PASS

Best helper/model for next pass

Claude Code / Opus, AUDIT_ONLY

Final gate statement

No implementation should start before Claude Code / Opus re-audits this patched architecture and Codex captures the accepted architecture in a docs-only scope lock.

The later Codex docs scope-lock must capture the full accepted patched architecture text, not a summary or highlights. Future implementation passes must bind to that accepted architecture document, not chat memory.
```

## Claude re-audit resolution summary

Claude Code / Opus confirmed the prior P1-P10 findings are resolved:

- P1 confirmation/value provenance resolved.
- P2 schema versioning/fail-closed resolved.
- P3 conflict handling resolved.
- P4 `event_invalidated` semantics resolved.
- P5 event naming resolved.
- P6 ID/relation taxonomy resolved.
- P7 Koht/pin targeting resolved.
- P8 Activity Timeline derivation resolved.
- P9 single-writer/project-lock acknowledged.
- P10 durable full-text capture requirement resolved by this pass.

## Captured open items L1-L4

These are deferred to schema/spec/materializer passes and are not blockers for this docs-only scope-lock record:

- L1: define `corrects_event_id` vs `supersedes_event_id` precisely or collapse.
- L2: document measurement correction path: `measurement_recorded` + `supersedes_event_id`; no `measurement_updated`.
- L3: component-invalidation orphan handling must surface dependent measurements, never silently cascade-drop.
- L4: legacy events without per-event `schema_version` are treated as v1 baseline; mixed-version stream validation must be defined.

## Hard implementation block

No implementation may start from this pass.

This pass authorizes no code/schema/validator/materializer/writer/UI/ZIP changes. The next implementation-adjacent pass must be schema/spec docs only, followed later by separately scoped validator, materializer, writer, UI, ZIP, Activity Timeline, and Measure Momentum passes.

## Future pass split recorded

1. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`
2. `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS` or `V2_EVENT_SCHEMA_SPEC_PASS`
3. `V2_EVENT_SCHEMA_AUDIT_PASS`
4. `V2_VALIDATOR_EXTENSION_PASS`
5. `V2_VALIDATOR_EXTENSION_AUDIT_PASS`
6. `V2_MATERIALIZER_PROJECTION_PASS`
7. `V2_MATERIALIZER_AUDIT_PASS`
8. `V2_EVENT_WRITER_SERVICE_PASS`
9. `V2_EVENT_WRITER_SERVICE_AUDIT_PASS`
10. `V2_SAVE_MEASUREMENT_IMPLEMENTATION_PASS`
11. `V2_SAVE_MEASUREMENT_AUDIT_PASS`
12. `V2_ADD_COMPONENT_IMPLEMENTATION_PASS`
13. `V2_ADD_COMPONENT_AUDIT_PASS`
14. `V2_EDIT_COMPONENT_IMPLEMENTATION_PASS`
15. `V2_EDIT_COMPONENT_AUDIT_PASS`
16. `V2_PROJECT_ZIP_IMPORT_EXPORT_PASS` if required
17. `V2_ACTIVITY_TIMELINE_SCOPE_LOCK_PASS`
18. `V2_MEASURE_MOMENTUM_SCOPE_LOCK_PASS`
19. `V2_CONSOLIDATED_SMOKE_QA_PASS`

## Boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- AI/helper may suggest, organize, and surface gaps only.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` remains forbidden.
- `view_state.json` remains forbidden.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Reference Images remain local sidecar only and must not become evidence/canonical source.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Recommended next pass

`V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`