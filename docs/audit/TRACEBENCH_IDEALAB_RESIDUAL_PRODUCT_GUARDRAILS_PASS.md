# TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only product/governance capture. Claude Code / Opus is not required before editing because this pass only records user-provided guardrails and does not implement runtime behavior. GPT Pro, Gemini Pro Deep Research, Claude Design, CodeRabbit, runtime implementation, web research, AI/OCR/CV, source search, URL import, and protected-surface changes are not needed.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `af04eab docs: close out guided measurement helper`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Current route before this pass was `GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS` with next `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`.

## Scope drift check

PASS. This pass is docs-only and records product guardrails only. It does not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. Residual Ideelabor / technician-first product guardrails are captured without starting implementation and without expanding `CURRENT_STATE.md` into a long design ledger.

## Guardrails recorded

### 1. Activity log

- Future activity log must be compact/toggleable.
- Preferred UI placement may be bottom bar, drawer, or similarly non-dominant visible region.
- It must not interrupt the technician-first measurement flow.
- It must not become a spreadsheet-style event table.
- It must not become canonical facts by itself.

### 2. Activity log separation

- User-visible activity timeline is not `events.jsonl`.
- User-visible activity timeline is not debug log.
- `events.jsonl` remains canonical event truth.
- Debug logs are diagnostics/internal.
- Activity timeline is a user-facing narrative/status surface only unless later scoped otherwise.

### 3. Measure momentum

- After future real save is allowed by V2 event-writing architecture, UI should preserve measurement momentum:
  - show confirmation,
  - keep selected context / `Koht`,
  - suggest next pin/point only as workflow aid.
- Suggest-next remains helper guidance, not diagnosis, not fact creation, and not canonical mutation.
- This remains deferred until V2 event-writing architecture unlocks real save behavior.

### 4. Offline prototype caution

- Production core UI must not require Google Fonts or other mandatory external resource dependency.
- Prototype may include external fonts/resources as visual input only.
- Offline/local-first core behavior must remain intact.

### 5. Prototype persistence warning

- `localStorage` in HTML prototype is demo-only.
- Production save/persistence requires `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`.
- Do not copy prototype `localStorage` behavior into production evidence workflow.

### 6. Ampere / A unit handling

- V, Ω, Diode, and Beep remain primary quick unit chips by default.
- A / current measurement should remain behind `Lisainfo` / `Tehnilised detailid` / advanced affordance by default.
- Rationale: current measurement can be riskier and less common in basic board probing; do not make it the primary technician path unless later scoped.

### 7. Estonian user-facing copy direction

Preferred labels for future UI/copy passes:

- `Koht`
- `Väärtus`
- `Ühik`
- `Mõõdetud siin`
- `Võrdluseks`
- `Vihje`
- `Kinnitamata`
- `Ainult kandidaat`

Rules:

- Estonian copy should be technician-first and avoid schema/event/debug jargon.
- Avoid inference/diagnostic wording.
- Avoid words that imply confirmed/good/verified unless human-confirmed event-writing later supports that status.

### 8. CURRENT_STATE compactness

- Ideelabor detail should not grow `CURRENT_STATE.md` into a long design ledger.
- Full detail belongs in audit docs and durable product memory.
- `CURRENT_STATE.md` should contain compact live handoff only.

## Canonical ownership choices

- Durable product guardrails were added to `docs/PROJECT_MEMORY.md`.
- Route/current/next state was updated in `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md`.
- Deferred implementation surfaces were recorded in `docs/DEFERRED_FEATURES.md`.
- Intake row was added to `docs/WORK_INTAKE_INDEX.md`.
- Detailed evidence remains in this audit doc.

## Boundary preservation summary

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage, suspect, source, and research are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only.
- Guided Measurement helper remains read-only.
- V2 event-writing remains deferred until separately scoped.

## Route decision

Next recommended pass:

`V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`

This pass does not route to implementation, V2 implementation, activity log implementation, save behavior, or unit-chip implementation.
