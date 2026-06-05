# TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. Claude Code / Opus should post-audit afterward because this locks durable evidence/product boundaries before any implementation. GPT Pro, Gemini Pro Deep Research, and Claude Design are not needed for this scope lock; Claude Design is deferred to the later measurement-sheet UX design pass.

## Startup state

- Branch: `main`.
- HEAD is synced with `origin/main` at the accepted Ideelabor anchor commit.
- Latest accepted anchor: `1c26a0a docs: anchor technician-first workflow direction`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remain `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags include `v1.0.0-rc1` and `v1.1.0-rc1`.

## Scope drift check

PASS. This pass is docs-only and does not implement runtime code, tests, Flutter runtime, schemas, validators, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The non-canonical sourced values / research sidecar scope is locked for future work only.

## Scope lock summary

The stale `V1_1_FULL_APP_MANUAL_SMOKE_CLOSEOUT_PASS` active lock was replaced with `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`.

The replacement lock defines allowed docs, forbidden runtime surfaces, sidecar boundaries, AI/helper boundaries, BoardFact Measure Sheet prototype handling, and the future pass split.

## Sourced values / research sidecar boundaries locked

Allowed future conceptual content:

- local research notes,
- user-entered source values,
- datasheet-derived reference values,
- service-note values,
- board marking notes,
- technician prior-knowledge notes,
- candidate values to help decide what to measure next,
- possible future reference-values panel that visually distinguishes measured, reference, candidate, and note values.

Mandatory boundaries:

- Research/source/reference/candidate values are non-canonical.
- They are not measurements.
- They are not confirmed component facts.
- They are not nets.
- They are not fault diagnoses.
- They are not probability claims.
- They must visually rank below local human measurements.
- They must not look measured.
- They may guide the technician, but must not mutate `events.jsonl`.
- They must not mutate `known_facts.json`.
- They must not affect materializer output.
- They must not become Board Canvas evidence rendering.
- They must not change Project ZIP contract.
- They must not be used by AI/OCR/CV.
- Any future promotion path requires a separately scoped human-confirmed measurement/event-writing workflow.

## WORK_INTAKE / DEFERRED alignment

- WI-006 remains queued for technician-first measure sheet direction.
- WI-007 is aligned as scope-locked for sourced/reference/research values as non-canonical and visually below human measurements.
- WI-008 remains queued for guided measurement helper boundaries.
- Deferred features continue to include OCR/CV automation, AI integration, fault probability engine, next-best-measurement engine, source search, cloud sync, event-writing implementation before V2 architecture, prototype-to-production shortcuts, and reference/research/candidate promotion into canonical facts without human measurement/confirmation.

## Deferred implementation passes preserved

1. `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` - display distinction between measured, reference, candidate, and note values.
2. `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` - Claude Design / UX critique; requires full prototype bundle first.
3. `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS` - safe helper suggestions, missing measurements, and conflicts; no diagnosis or fact creation.
4. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` - required before real Save Measurement / Add Component / Edit Component behavior.
5. `QUICK_MEASUREMENT_SHEET_IMPLEMENTATION_PASS` - only after V2 event-writing architecture and UX design are accepted.

## Technician-first and prototype rules preserved

- TraceBench remains technician-first, not spreadsheet-first.
- Short UI rule remains `Koht -> Väärtus -> Ühik -> Salvesta`.
- Repair technicians should not need to understand canonical schemas, event IDs, projection state, sidecar semantics, or internal graph rules during normal use.
- The BoardFact Measure Sheet prototype is visual/product workflow input only, not production source.
- Before reproducing the prototype in UX design or implementation, request HTML, CSS, JS, screenshots or screen recording if available, and whether behavior should be preserved or only visual direction.

## Safe for Claude Code / Opus post-audit

Yes. The pass is docs-only, boundary-focused, and ready for independent repo-local post-audit before any implementation or follow-on scope split.

## Next recommended pass

`TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_POST_AUDIT_PASS`
