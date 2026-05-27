# GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only policy/scope lock

## Input audit verdict

- `GLOBAL_EVENT_STATUS_SEMANTICS_AUDIT_PASS`: `SPLIT_FIX_NEEDED`.

## Locked policy

1. Accepted events are canonical source for current domain facts.
2. Non-accepted events may remain in `events.jsonl` as audit/history/review data.
3. Non-accepted events must not silently create current domain facts in `known_facts.json`.
4. Domain references must resolve to prior accepted source events unless a specific audit/metadata family explicitly allows all-status references.
5. Reference semantics and projection semantics must be aligned.
6. Audit/metadata families may keep broader reference semantics only when explicitly documented and with no domain projection side effects.

## Known inconsistency recorded

- Validator indexes still include all-status sets for some families (`component_ids`, `photo_ids`, `measurement_event_ids`, `pin_ids`, `all_event_ids`).
- Materializer has no global accepted-only filter.
- `component_visual_placement_confirmed` is already stricter:
  - validator: accepted-only provenance refs
  - materializer: accepted + user-only

## Event-family classification (locked direction)

| Event family | Class | Locked status/reference direction |
|---|---|---|
| `project_created` | `audit_metadata_event` | no domain projection side effects |
| `project_metadata_updated` | `audit_metadata_event` | no domain projection side effects |
| `initial_intake_updated` | `audit_metadata_event` | no domain projection side effects |
| `photo_added` | `visual_evidence_event` | accepted-only materialization and accepted-only domain provenance references |
| `photo_reference_points_set` | `audit_metadata_event` | no domain projection side effects |
| `photo_layer_aligned` | `audit_metadata_event` | no domain projection side effects |
| `damage_region_marked` | `visual_evidence_event` | accepted-only materialization and accepted-only photo provenance references |
| `suspect_region_marked` | `visual_evidence_event` | accepted-only materialization and accepted-only photo provenance references |
| `component_created` | `domain_fact_event` | accepted-only materialization and accepted-only provenance source |
| `component_updated` | `domain_fact_event` | accepted-only side effects against accepted component provenance |
| `component_marked_unknown` | `domain_fact_event` | accepted-only side effects against accepted component provenance |
| `footprint_marked_not_populated` | `domain_fact_event` | accepted-only materialization |
| `pin_defined` | `domain_fact_event` | accepted-only materialization and accepted-only component provenance references |
| `visual_trace_added` | `visual_evidence_event` | accepted-only materialization and accepted-only photo provenance references |
| `measurement_recorded` | `domain_fact_event` | accepted-only materialization; accepted-only measurement provenance for dependent references |
| `net_connection_confirmed` | `domain_fact_event` | accepted-only materialization; accepted-only measurement provenance references |
| `repair_action_recorded` | `lifecycle/repair_event` | accepted-only side effects (`installation_status`, stale transitions) and accepted-only target provenance references |
| `claim_invalidated` | `audit_metadata_event` | may reference event ids for audit context; no direct domain projection side effects |
| `conflict_detected` | `audit_metadata_event` | may reference event ids for audit context; no direct domain projection side effects |
| `conflict_resolved` | `audit_metadata_event` | may reference event ids for audit context; no direct domain projection side effects |
| `export_created` | `export/transport_event` | metadata/audit only, no domain projection side effects |
| `component_visual_placement_confirmed` | `visual_evidence_event` | keep accepted-only + user-only projection semantics and accepted-only provenance references |

## Locked implementation sequence

1. `VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS`
   - normalize reference indexes/helpers to accepted-source semantics for domain/visual/lifecycle families
   - keep forward-reference rejection
   - keep placement-after-removal allowance where already scoped
2. `MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS`
   - apply accepted-only projection/side-effect behavior by locked event-family policy
3. `STATUS_SEMANTICS_REGRESSION_PASS` (only if impact requires)
   - adjust ZIP/regression expectations and fixture/samples only when required by measured output changes

## Explicit guardrails

- No global materializer status behavior change before `MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS`.
- No sample/fixture refresh before regression impact is measured and explicitly scoped.
- Preserve:
  - placement visual/documentation-only boundary
  - no `visual_trace` to measured-net promotion
  - no AI proposal to confirmed fact promotion
