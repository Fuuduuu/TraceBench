# Active Scope Lock

## Current pass

`V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK / DESIGN_SOURCE_INTAKE / PROTECTED_UI_DIRECTION

## Goal

Record and scope the newly provided dark EDA Project Home / Board Canvas design source as `DESIGN_INPUT_ONLY`.

This pass is docs-only. It locks design-source boundaries only and does not implement runtime behavior, edit tests, arm Board Canvas save/write behavior, or arm a new implementation pass.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This pass must not claim Claude audit or output a Claude `AUDIT_VERDICT`.
- Scope-lock review status is `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Codex output must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline

- Latest pushed HEAD verified before this scope-lock: `2b17f68` (`docs: record Measure panel pin leg selector dedup`), aligned with `origin/main`.
- Accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS` at `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS` at `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`).
- Accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS` at `a2f59b0` (`docs: arm Measure panel pin leg selector dedup implementation`).
- Accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` at `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Prior accepted decision-state: current closeout `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS`, next recommended `NEEDS_USER_DECISION`.
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this scope-lock

This scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS.md`

If any runtime, test, design-source, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary for this scope-lock, stop and report the exact required file and rationale before editing it.

## Design inputs inspected

Prompt-listed paths were checked first and were not present:

- `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\BenchBeep Project Home (dark).html`
- `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\home-dark.css`

Matching repo scratch design files were inspected as design input only:

- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark).html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\home-dark.css`

These files are not runtime truth and must not be staged, edited, imported, bundled, copied into runtime assets, or depended on at runtime.

## Design source status

The inspected dark EDA HTML/CSS are `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, route behavior, or AI facts from these files.

## Future design direction locked as input only

Future implementation may later consider, only after a separate route decision and active-lock sync:

- dark EDA / bench-instrument visual language;
- dominant board/canvas working surface;
- compact left rail / project navigation direction;
- contextual right Measure panel direction;
- read-only/no-write status visibility;
- technical typography and restrained chrome;
- dark canvas with clear board/footprint contrast;
- user-facing BenchBeep identity preserved.

## Future / deferred unless separately scoped

- Project Home dark implementation.
- Global dark theme.
- Board Canvas dark EDA visual migration.
- Color-coded net rendering.
- Board-level legend implementation.
- Logo asset/runtime asset changes.
- Google Fonts/font asset changes.
- New route/navigation behavior.
- Runtime CSS/HTML reuse.

## Explicitly forbidden

- Runtime/test edits in this scope-lock.
- A new implementation pass armed by this scope-lock.
- Runtime asset dependencies from `_incoming`, screenshots, mockups, docs/sources, or source indexes.
- Dark Project Home implementation.
- Global dark theme.
- Board Canvas dark EDA visual migration.
- Color-coded nets or board-level legend implementation.
- Treating 5V/220V/GND/Signal prototype labels as confirmed nets.
- Board Canvas canonical save/write behavior.
- Claiming Board Canvas save/write or canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart` from Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation from Board Canvas.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual traces, From -> To context, prototype route labels, prototype net labels, or prototype legend labels into confirmed connectivity.
- Edits to router, Home, Project Overview, Measure Sheet screen, writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, or canvas token migration.

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.
- No implementation active lock is armed by this pass.
