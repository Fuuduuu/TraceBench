# PROJECT_MEMORY.md

Canonical product truth for TraceBench AI.

## Product promise

Measurement-backed PCB repair documentation and AI-assisted schematic reconstruction.

## Core rule

Human is the sensor. AI is the graph engine.
AI must never invent component identities, hidden-layer connections, measurements, or confirmed facts.

## V1.0 scope

`pildista → märgi → mõõda → kinnita → ekspordi`

V1.0 is a Known Facts Builder, not an AI repair agent.

## Stable architecture invariants

- `events.jsonl` is the only canonical truth.
- `known_facts.json` is a materialized projection used by read-only viewers.
- `board_graph.json` and `view_state.json` are forbidden in V1.
- Visual evidence is visual-only; `visual_trace` is never measured electrical evidence.
- `component_removed` event type is not in V1.
- `repair_action_recorded(action_type="remove_component")` is the V1 removal model.

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

## Accepted state pointer

Current accepted snapshot lives in [docs/CURRENT_STATE.md](CURRENT_STATE.md).

Full pass history and evidence live in [docs/PASS_QUEUE.md](PASS_QUEUE.md) and `docs/audit/**/*.md`.
