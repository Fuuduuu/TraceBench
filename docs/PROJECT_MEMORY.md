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

## Technician-first workflow invariant

TraceBench should be a technician-first bench workflow, not an engineering spreadsheet.

- Default workflow: select place/component/pin -> measure -> enter value -> choose unit -> save -> show status / next step.
- Short form: `Koht -> Väärtus -> Ühik -> Salvesta`.
- Default UI must be measure-first, not form-first; keep ordinary visible fields small and put internal/provenance/schema details behind progressive disclosure.
- Repair technicians should not need to understand canonical schemas, event IDs, projection state, sidecar semantics, or internal graph rules during normal use.
- Human local measurements must visually outrank research/reference/candidate values; reference/research/candidate values must not look measured.
- AI/helper may suggest next measurements, organize accepted context, surface gaps/conflicts, and summarize confirmed facts, but must not create canonical facts, diagnose faults, infer nets, confirm identity, or make probability-style fault claims.
- User-visible activity timeline, if later implemented, must be compact/toggleable, non-dominant, non-canonical, and separate from both `events.jsonl` and debug logs.
- Future post-save momentum may show confirmation, retain selected `Koht`, and suggest a next pin/point only as workflow aid after V2 event-writing architecture unlocks real save behavior.
- Production core UI must remain local/offline-capable; prototype external resources such as Google Fonts are visual input only and must not become mandatory dependencies.
- Prototype `localStorage` persistence is demo-only; production persistence requires accepted event-writing architecture.
- Primary quick measurement units remain V / Ω / Diode / Beep by default; A/current measurement belongs behind `Lisainfo` / `Tehnilised detailid` / advanced affordance unless separately scoped.
- Preferred technician-facing Estonian labels include `Koht`, `Väärtus`, `Ühik`, `Mõõdetud siin`, `Võrdluseks`, `Vihje`, `Kinnitamata`, and `Ainult kandidaat`; avoid schema/event/debug jargon and inference/diagnostic wording.

## Stable architecture invariants

- `events.jsonl` is the only canonical truth.
- Accepted events are canonical source for current domain facts.
- Non-accepted events are audit/history/review evidence and must not silently become current domain facts.
- `known_facts.json` is a materialized projection used by read-only viewers.
- Footprint template registry is app/library metadata only and is not canonical project fact storage.
- `template_id` is package/geometry metadata only and is not component identity, electrical function, pin-mapping confirmation, measured-net proof, or fault evidence.
- `component_visual_placement_confirmed` is a canonical visual/documentation placement event and does not confirm identity, pin mapping, visual trace, electrical net, measurement, fault candidate, repair conclusion, or hidden-layer truth.
- `known_facts.json` may include top-level `component_visual_placements` as visual/documentation projection only.
- AI proposal objects (`unconfirmed_ai_proposal`) are non-canonical until explicit human confirmation through accepted event paths.
- `graph_layout` is non-canonical render state.
- `board_graph.json` and `view_state.json` are forbidden in V1.
- Board-canvas renderer is read-only and implemented with shell, `board_normalized` component placement rendering, read-only inspector, measurement summary metadata, visual_trace metadata summary, and photo-alignment readiness metadata panel. Visual/evidence canvas geometry overlay rendering remains deferred.
- Visual evidence is visual-only; `visual_trace` is never measured electrical evidence.
- `component_removed` event type is not in V1.
- `repair_action_recorded(action_type="remove_component")` is the V1 removal model.
- External AI Component Reading Simulation Lab is outside this repository and not part of TraceBench canonical truth surfaces.

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
