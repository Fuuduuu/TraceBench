# TRUTH_INDEX.md

## Purpose

On-demand semantic invariant and canonical-owner index. It stores no current route, PASS_ID history, audit result, panel-specific implementation summary, envelope field list, or payload essay.

## Canonical owners

- `docs/POHIKIRI.md` owns the core human/AI product rule: AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.
- `docs/PROJECT_MEMORY.md` owns product identity, product promise, Visual First architecture, lifecycle, and durable non-negotiables.

## Semantic invariants

- `events.jsonl` is append-only canonical truth.
- `known_facts.json` is a materialized projection/cache, never a competing truth source.
- Canonical writes require an explicitly scoped human-confirmation path.
- Non-accepted events, candidates, references, helper output, and review material must not silently become current facts.
- Photo pixels are not facts.
- `visual_trace` is not an electrical net or measured connectivity.
- Candidate/reference/context values are hints, not measured evidence.
- UI-local drafts, selection, rendering, ghost/template state, and navigation state are non-canonical.
- AI proposals remain non-canonical until explicit human confirmation through an accepted event path.
- Reference Images and source/design inputs remain sidecar/provenance unless separately scoped.
- Visual placement is separate from component identity, contact/pin/pad layout, electrical connectivity, measurement, fault evidence, and repair conclusions.
- Visual contact layout is separate from visual placement and is not electrical confirmation.
- Template/family metadata describes visual/package geometry; it does not prove identity or electrical function.
- Visual/Layout Graph remains separate from Electrical Net Graph.
- Rendering/painter code does not create canonical truth; explicit accepted actions may write only through their scoped owner.
- Flutter/UI code must not directly mutate `known_facts.json`.
- `board_graph.json` and `view_state.json` remain forbidden unless separately scoped.
- Do not add `sequence` to V2 events.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Owner routing

| Concern | Canonical owner |
|---|---|
| Human/AI product rule | `docs/POHIKIRI.md` |
| Product identity, promise, Visual First architecture | `docs/PROJECT_MEMORY.md` |
| Current route and handoff | `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md` |
| Current allowlist and stop conditions | `docs/ACTIVE_SCOPE_LOCK.md` |
| Protected surface catalogue | `docs/PROTECTED_SURFACES.md` |
| Event type/envelope/payload contract | exact relevant spec/schema/runtime owner; V2 requirements in `docs/spec/V2_EVENT_SCHEMA_SPEC.md` |
| Canonical append/write behavior | exact relevant writer/runtime owner and focused tests |
| Projection/materialization behavior | exact relevant materializer, `schemas/known_facts.schema.json`, and focused tests |
| Visual placement/footprint boundary | `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` and exact scoped runtime owner |
| UI workflow semantics | `docs/UI_WORKFLOWS.md` and exact target screen/test |
| Project ZIP contract | `docs/PROJECT_ZIP_SPEC.md` |
| Board Graph architecture | `docs/BOARD_GRAPH_SPEC.md` |
| Photo/evidence flow | `docs/PHOTO_FLOW_SPEC.md` |
| Completed pass evidence | `docs/AUDIT_INDEX.md` plus one exact `docs/audit/*.md` artifact |
| Documentation ownership/read routing | `docs/FILE_MAP.md`, `docs/MEMORY_PROTOCOL.md`, `docs/MEMORY_REGISTRY.yml` |

Detailed implementation truth belongs in the pointed spec/schema/runtime/test owner, not in this index.
