# TRUTH_INDEX.md

## Core invariants ownership

`docs/TRUTH_INDEX.md` is the canonical owner of core, non-runtime-changing invariants.
Operational docs should reference this section instead of duplicating invariant essays.

Core invariants (semantics unchanged):

- `events.jsonl` is canonical truth; `known_facts.json` is projection/cache.
- AI/helper may not author canonical facts or canonical events.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- Candidate/reference/context fields are visual hints, not canonical evidence.
- Board Canvas remains read-only unless separately scoped.
- Reference Images remain sidecar / non-canonical unless separately scoped.
- Do not add `sequence` to V2 events.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- Placement editor architecture decision: Add Component creates identity/existence only; Board Canvas ghost/template placement remains UI-local draft only until a separately scoped placement editor/writer implementation.
- Future `component_visual_placement_confirmed` work must align to the V2 event regime before Dart writer or Confirm UI implementation.
- Visual contact layout is separate from visual placement and is not electrical confirmation.

Product identity owner:

- `docs/PROJECT_MEMORY.md` is the durable owner for BenchBeep / TraceBench / BoardFact naming.
- `BenchBeep` is the user-facing app/product name.
- `TraceBench` is the repository/platform/project name.
- `BoardFact` is the data-fact/subsystem name and is not the primary app wordmark unless a specific UI surface explicitly earns that subsystem label.

| Fact type | Canonical owner | Update trigger | Obsolete handling | Secondary pointer allowed? |
|---|---|---|---|---|
| Product identity naming | PROJECT_MEMORY.md | product identity naming acceptance | update durable identity section; replace stale duplicate wording in secondary files with compact pointers | CURRENT_STATE / README short pointer |
| Product promise | PROJECT_MEMORY.md | V1 scope or architecture acceptance | update stable promise text; delete duplicates in secondary files | CURRENT_STATE short pointer |
| Core rule | PROJECT_MEMORY.md / AGENTS.md | Core-rule change in protected pass | replace in canonical owner; keep old details only in audit if relevant | Prompt fragment |
| Current pass | PASS_QUEUE.md | every accepted pass | replace current pass; move old pass to completed history | CURRENT_STATE.md only |
| Next recommended pass | PASS_QUEUE.md | pass acceptance or queue audit | replace old next recommendation | CURRENT_STATE.md only |
| CURRENT_STATE compaction trigger | docs/MEMORY_MAINTENANCE.md | current-state line-count check during route reviews and closeouts | compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines; do not re-arm the old manual drift countdown as active truth | PASS_QUEUE pointer only |
| Stable architecture invariant | PROJECT_MEMORY.md (and relevant spec docs) | accepted architecture/spec pass | update spec and compact pointer; remove stale duplicates | PROJECT_MEMORY compact pointer |
| V2 event schema requirements | docs/spec/V2_EVENT_SCHEMA_SPEC.md | accepted V2 schema/spec requirements change | update spec owner; keep implementation summaries in audit docs | CURRENT_STATE short pointer |
| V2 event validation / validator V2 path | tools/validate_events_jsonl.py | accepted validator behavior change | update validator owner and focused tests in the scoped pass; preserve audit evidence in docs/audit | CURRENT_STATE short pointer |
| V2 materializer projection / known_facts V2 projection | tools/materialize_known_facts.py | accepted materializer behavior change | update materializer owner and focused tests in the scoped pass; preserve audit evidence in docs/audit | CURRENT_STATE short pointer |
| V2 canonical event writer / append service | tools/event_writer_service.py | accepted writer behavior change | update writer owner and focused tests in the scoped pass; preserve audit evidence in docs/audit | CURRENT_STATE short pointer |
| Global event status semantics policy (accepted-only domain fact direction) | PROJECT_MEMORY.md + ACTIVE_SCOPE_LOCK.md + docs/audit/GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS.md | accepted status-semantics scope lock pass | replace stale contradictory wording; keep implementation split routing in PASS_QUEUE and CURRENT_STATE | CURRENT_STATE short summary |
| Visual placement event boundary (`component_visual_placement_confirmed`) | schemas/events.schema.json + tools/validate_events_jsonl.py + PROJECT_MEMORY.md | accepted schema/validator pass | update schema/validator and stable-boundary pointer; remove stale contradictory wording from docs | CURRENT_STATE short summary |
| Visual placement projection (`component_visual_placements`) | schemas/known_facts.schema.json + tools/materialize_known_facts.py + PROJECT_MEMORY.md | accepted projection/materializer pass | update projection owner files and stable-boundary pointer; keep history in audit docs | CURRENT_STATE short summary |
| Placement editor architecture decision | PROJECT_MEMORY.md + docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md + docs/audit/BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS.md | accepted architecture decision scope-lock | preserve Add Component identity-only boundary, Board Canvas UI-local draft ownership, V2 placement envelope alignment requirement, and visual-contact separation | CURRENT_STATE / PASS_QUEUE short pointer |
| Footprint registry/template boundary (`template_id` is geometry metadata only) | docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md + docs/PROJECT_MEMORY.md | accepted footprint scope/spec pass | replace stale wording that implies identity/electrical proof from template metadata | CURRENT_STATE short summary |
| AI proposal non-canonical boundary (`unconfirmed_ai_proposal`) | PROJECT_MEMORY.md + docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md | accepted design/scope pass | replace stale wording that implies canonicalization | CURRENT_STATE short summary |
| Active allowed/forbidden surfaces | ACTIVE_SCOPE_LOCK.md | every active pass | replace old lock completely | audit closeout summary |
| Completed pass evidence | docs/audit/*.md | every pass closeout | never move into PROJECT_MEMORY; keep historical evidence here | AUDIT_INDEX row |
| Protected surfaces | docs/PROTECTED_SURFACES.md | protected-surface decision | preserve historical rationale; do not duplicate | ACTIVE_SCOPE_LOCK forbidden list |
| Board graph architecture | docs/BOARD_GRAPH_SPEC.md | board graph architecture acceptance | update spec; keep compact invariant pointer in PROJECT_MEMORY | PROJECT_MEMORY compact pointer |
| Photo flow architecture | PHOTO_FLOW_SPEC.md | photo architecture acceptance | update spec; keep compact invariant pointer in PROJECT_MEMORY | PROJECT_MEMORY compact pointer |
| Project ZIP contract | docs/PROJECT_ZIP_SPEC.md | ZIP contract change acceptance | update spec only; keep PROJECT_MEMORY compact reference | PROTECTED_SURFACES pointer |
| Flutter UI boundary | docs/FLUTTER_UI_SPEC.md | Flutter UI scope changes | update UI spec only | CURRENT_STATE short summary |
| Validation result | CURRENT_STATE.md | docs-only pass or after test run | update validation baseline/line; keep detailed test output in audit if useful | PASS audit result summary |
| Current accepted handoff | CURRENT_STATE.md | pass completion or queue update | replace snapshot; keep archived detail in audit only if needed | PASS_QUEUE history pointer |
| Validation baseline | CURRENT_STATE.md | baseline command changes | replace baseline command set if tooling changes | PASS_QUEUE / audit pass note |
| Deprecated/obsolete fact | original canonical owner until resolved | contradiction or superseding pass | delete, replace, or archive in audit note | no |
