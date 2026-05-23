# PROJECT_MEMORY.md

Canonical product truth for TraceBench AI.

## Product promise

Measurement-backed PCB repair documentation and AI-assisted schematic reconstruction.

## Core rule

Human is the sensor. AI is the graph engine.
AI never invents measurable values.

## V1.0 scope

`pildista → märgi → mõõda → kinnita → ekspordi`

V1.0 is a Known Facts Builder, not an AI repair agent.

## Non-negotiables

- local-first
- append-only event log
- Visual/Layout Graph separate from Electrical Net Graph
- evidence floor rule
- no hard onboarding gates
- project can start with unknown device/model/symptom and no photos
- `not_populated` is first-class
- `stale_after_repair` preserves old measurements
- Project ZIP must be self-contained

## Accepted recent state snapshot

- `BOARD_GRAPH_MATERIALIZER_PASS`:
  - component updates are materialized as in-place patch operations.
  - `component_marked_unknown` is materialized without creating or removing components.
  - `component_pin_index` is included as optional known-facts projection metadata.
  - graph invariant warnings are emitted at materialization time; they do not fail validation.
- `FLUTTER_GRAPH_VIEW_PASS`:
  - `/project/graph` is implemented as read-only board graph view.
  - graph is built in Dart memory from `known_facts.json` via `BoardGraphProjection`.
  - deterministic auto-layout (`graph_layout`) is memory-only and non-persistent.
  - no `board_graph.json` / `view_state.json` is introduced.
- `COMPONENT_EDIT_EVENT_MODEL_PASS`:
  - component removal uses `repair_action_recorded(action_type="remove_component")`.
  - no `component_removed` event type exists in V1.
  - removed components stay in `components[]`.
  - removed components get projection fields `installation_status="removed"` and `removed_by_event_id`.
  - `component.status` and identity fields are preserved.
  - direct component measurements become stale.
  - `connected_net_measurements` remains `no_change`.
