# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS`

## Lane

`CODEX / DOCS_SYNC_SCOPE_LOCK`

## Mode

Docs-only scope lock. Do not implement runtime code. Do not modify Flutter runtime, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Goal

Lock the first implementation-safe technician-first Measure Sheet scope after the accepted UX design review, without starting implementation.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_POST_AUDIT_PASS`

Claude Code / Opus must audit this scope lock before any implementation route. Do not route directly to implementation.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- Runtime code
- Flutter runtime
- Tests
- Schemas or validators
- Tools or materializer
- Project ZIP logic or contract
- Board Canvas runtime
- Reference Images runtime
- AI/OCR/CV
- Source search, URL import, datasheet parser, or web scrape
- Event-writing
- Generated artifacts
- Assets or samples
- Platform folders
- Tags or release objects
- Prototype HTML/CSS/JS/screenshots

## Accepted UX review input

- The prototype supports technician-first bench workflow better than spreadsheet-style UI.
- Use the prototype as visual + workflow direction only.
- Do not preserve prototype behavior as production logic.
- Do not copy HTML/CSS/JS directly into Flutter.
- Do not copy localStorage behavior.
- Do not copy Save behavior.
- Do not infer schema assumptions from the prototype.
- Do not copy runtime implementation patterns.

## Future implementation slice locked

Future pass: `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`.

Allowed future slice only:

- read-only/display shell for the Measure Sheet concept,
- technician-first layout structure,
- safe copy and labels,
- non-writing visual hierarchy,
- disabled/non-functional save affordance only if needed for visual context,
- neutral status-dot / recorded-reading semantics,
- measured/reference/candidate/note visual hierarchy,
- accessibility minimums,
- narrow-window fallback behavior,
- tests that verify no writing/editing/canonical mutation affordance exists.

Forbidden future slice:

- real Save Measurement,
- Add Component,
- Edit Component,
- event-writing,
- canonical fact creation,
- schema changes,
- `known_facts.json` mutation,
- materializer changes,
- Project ZIP behavior changes,
- Board Canvas write/edit behavior,
- AI/OCR/CV,
- source search,
- URL import,
- datasheet parser,
- localStorage behavior,
- copied prototype implementation patterns.

## Technician-first UI rules locked

- Default workflow remains `Koht -> Väärtus -> Ühik -> Salvesta`.
- Normal use must not require canonical schema/event/projection/sidecar knowledge.
- Visible default fields should stay minimal.
- Advanced/internal details belong behind progressive disclosure: `Lisainfo`, `Tehnilised detailid`, inspector/details panels.
- UI must not become spreadsheet-style mandatory field entry.

## Evidence-language and status-dot rules locked

- Human is the sensor. AI is the graph engine.
- Copy must keep the human as actor/sensor.
- The app may display context; it must not imply it measured, inferred, verified, diagnosed, or confirmed.
- Avoid inference-tinted wording such as `automaatne`, `tuvastatud`, `kinnitatud`, `korras`, `verified`, `good`, `AI found`, and `app detected`.
- Prefer neutral wording such as `valitud`, `kasutaja valik`, `mõõtmine käsil`, `sisesta mõõdetud väärtus`, `salvestatud lugem`, `lugem olemas`, and `recorded reading`.
- A dot, chip, marker, or status indicator may mean only that a reading exists / a reading was recorded here.
- It must not mean pin is good, value is verified, component is identified, net is confirmed, fault is diagnosed, AI confirmed this, or measurement is correct.
- Green status should be avoided or neutralized if it can imply good/verified.

## Reference Values Panel integration rules locked

- First Measure Sheet scope may reference the accepted ladder but must not implement runtime behavior unless separately scoped.
- `Mõõdetud`: visually dominant.
- `Viide / Allikas`: visibly secondary.
- `Kandidaat`: tentative.
- `Märkus`: contextual/subordinate.
- Reference/source/candidate/note must never look measured.
- Reference/source/candidate/note remain non-canonical.
- Reference/source/candidate/note may guide measurement but are not proof.
- No automatic promotion to measured/canonical.

## Accessibility and narrow-window rules locked

- Interactive targets should be at least 44px where touch/click interaction is expected.
- Small/faint labels must be readable and contrast-safe.
- Dark UI readability must be preserved.
- Keyboard/focus order should follow the technician flow.
- Narrow windows must not silently drop board/context.
- If board/context cannot fit, provide a compact context card, collapsed board preview, or explicit `Board context hidden on narrow width` state.
- The user must not lose the selected `Koht` context.
- Overflow and long labels must be handled safely.

## Must wait for V2 event-writing architecture

- Real Save Measurement runtime
- Add Component runtime
- Edit Component runtime
- Event-writing
- Canonical fact creation
- `known_facts.json` mutation
- Schema changes driven by prototype
- Promotion of prototype Save behavior into evidence workflow
- Confirmed component identity
- Net confirmation
- Fault diagnosis
- Probability claims

## Core hard boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect/source/research are not proof.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only.
