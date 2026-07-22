# PROJECT_MEMORY.md

## Purpose and charter

On-demand durable product and architecture memory for TraceBench / BenchBeep. Operational routing, pass/commit evidence, audit results, test totals, and implementation sequences remain with their dedicated owners.

`docs/POHIKIRI.md` is the canonical product charter and owns the core human/AI rule. If any product or architecture proposal conflicts with it, stop and ask the human.

## Product identity

- `BenchBeep` is the user-facing app/product name.
- `TraceBench` is the repository/platform/project name.
- `BoardFact` is the data-fact/subsystem name.
- `BoardFact` is not the primary app wordmark unless a specific UI surface explicitly earns that subsystem label.

## Product promise and lifecycle

Measurement-backed PCB repair documentation and AI-assisted schematic reconstruction.

Core lifecycle: `pildista → märgi → mõõda → kinnita → ekspordi`.

TraceBench is a Known Facts Builder and technician workbench, not an autonomous repair agent. It must remain local-first and usable without cloud dependencies.

## Human and AI

Human is the sensor; AI is the graph engine and assistant.

AI may propose, organize, guide, surface uncertainty, find conflicts, and summarize confirmed context. Only explicit human confirmation may create canonical project truth. AI must not invent measurements, component identity, electrical connectivity, hidden-layer truth, or repair conclusions.

## Visual First Workbench

- Board Canvas and its contextual right-side panel/menu are the primary technician workflow surface.
- Technician-facing measurement flow is `Koht -> Väärtus -> Ühik -> Salvesta`.
- Normal work should stay in visual board context rather than defaulting to engineering tables or detached forms.
- Human local measurements must visually outrank reference, research, candidate, or helper values.
- Default quick measurement units remain V / Ω / Diode / Beep; A/current stays an advanced affordance unless separately scoped.
- Technician-facing vocabulary favors `Koht`, `Väärtus`, `Ühik`, `Mõõdetud siin`, `Võrdluseks`, `Vihje`, `Kinnitamata`, and `Ainult kandidaat` over schema/debug jargon.
- Standalone Add/Edit/Measure-style pages may remain transitional until scoped replacements exist, but they must not become a duplicate primary workflow.
- Rendering, selection, and draft state are not canonical writes; explicit scoped human actions own confirmation.

## Stable truth and projection boundaries

- `events.jsonl` is the append-only canonical truth.
- `known_facts.json` is a materialized projection/cache and must remain regenerable from accepted events.
- Only accepted human-confirmed events become current domain facts; non-accepted events remain evidence/history/review material.
- Visual/Layout Graph remains separate from Electrical Net Graph.
- A confirmed board outline is project-level Visual/Layout geometry only; physical dimensions are visual metadata and never electrical or diagnostic evidence.
- Visual placement documents where an existing component appears; it does not confirm identity, contacts, pins, pads, nets, traces, measurements, electrical function, or fault cause.
- UI-local drafts, imported/reference material, AI proposals, template metadata, and render/layout state remain non-canonical until an explicitly scoped human-confirmation path applies.
- Any user-facing activity timeline remains derived, non-canonical, compact/non-dominant, and separate from `events.jsonl` and debug logs.
- `not_populated` is first-class; `stale_after_repair` preserves historical measurements.
- The evidence floor rule remains in force: weaker visual/reference evidence cannot be promoted into stronger measured/electrical truth without the required human evidence path.

Detailed semantic invariants and canonical-owner routing live in `docs/TRUTH_INDEX.md`.

## Five canonical event meanings

- `component_created` creates component identity/existence.
- `component_updated` updates component metadata.
- `component_visual_placement_confirmed` confirms visual/documentation placement.
- `board_outline_confirmed` confirms one project-level Visual/Layout board outline.
- `measurement_recorded` records a human-confirmed measurement.

These meanings remain separate; one event must not silently promote into another semantic category.

The `board_outline_confirmed` Python schema/validator/materializer foundation is implemented. Its canonical writer and Project ZIP behavior reuse the existing generic validation and regeneration boundaries. No wizard, Board Canvas authoring flow, candidate persistence, or Dart/Flutter activation is implied; those remain separately scoped future work.

## Local-first and Project ZIP non-negotiables

- A project may start with an unknown device/model/symptom and no photos; onboarding must not impose hard evidence gates.
- Production core workflows remain local/offline-capable.
- Prototype external fonts and prototype `localStorage` are design/demo inputs, not required production dependencies or canonical persistence.
- Project ZIP is a self-contained local transport contract.
- Project ZIP, writer, validator, materializer, projection, repair, and evidence-status behavior are protected and change only through dedicated scope.
- Reference images and design/source material are sidecar/provenance unless separately confirmed through a canonical evidence path.

## Canonical pointers

- Product charter and human/AI rule: `docs/POHIKIRI.md`
- Semantic invariants and owner routing: `docs/TRUTH_INDEX.md`
- Protected boundaries: `docs/PROTECTED_SURFACES.md`
- Visual First workflow: `docs/UI_WORKFLOWS.md`
- Event envelope/payload details: `docs/spec/V2_EVENT_SCHEMA_SPEC.md` and exact runtime owners
- Board Canvas placement/footprint details: `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- Project ZIP contract: `docs/PROJECT_ZIP_SPEC.md`
- Board Graph architecture: `docs/BOARD_GRAPH_SPEC.md`
- Photo/evidence flow: `docs/PHOTO_FLOW_SPEC.md`
- Operational route and scope: the five-file default read set
- Historical implementation and audit evidence: `docs/AUDIT_INDEX.md`, one exact audit artifact, and git history
