# TRUTH_INDEX.md

| Fact type | Canonical owner | Update trigger | Obsolete handling | Secondary pointer allowed? |
|---|---|---|---|---|
| Product promise | PROJECT_MEMORY.md | V1 scope or architecture acceptance | update stable promise text; delete duplicates in secondary files | CURRENT_STATE short pointer |
| Core rule | PROJECT_MEMORY.md / AGENTS.md | Core-rule change in protected pass | replace in canonical owner; keep old details only in audit if relevant | Prompt fragment |
| Current pass | PASS_QUEUE.md | every accepted pass | replace current pass; move old pass to completed history | CURRENT_STATE.md only |
| Next recommended pass | PASS_QUEUE.md | pass acceptance or queue audit | replace old next recommendation | CURRENT_STATE.md only |
| Drift countdown | PASS_QUEUE.md | docs drift updates | replace current countdown value only | no duplicate |
| Stable architecture invariant | PROJECT_MEMORY.md (and relevant spec docs) | accepted architecture/spec pass | update spec and compact pointer; remove stale duplicates | PROJECT_MEMORY compact pointer |
| Visual placement event boundary (`component_visual_placement_confirmed`) | schemas/events.schema.json + tools/validate_events_jsonl.py + PROJECT_MEMORY.md | accepted schema/validator pass | update schema/validator and stable-boundary pointer; remove stale contradictory wording from docs | CURRENT_STATE short summary |
| Visual placement projection (`component_visual_placements`) | schemas/known_facts.schema.json + tools/materialize_known_facts.py + PROJECT_MEMORY.md | accepted projection/materializer pass | update projection owner files and stable-boundary pointer; keep history in audit docs | CURRENT_STATE short summary |
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
