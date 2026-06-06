# TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only design review record. Claude Design / UX already completed the prototype review and returned `ACCEPT_WITH_NITS`. Claude Code / Opus is not required for this recording pass. GPT Pro, Gemini Pro Deep Research, CodeRabbit, and runtime implementation are not needed.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `46aac14 docs: add measure sheet prototype bundle`.
- No tracked diffs existed before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.

## Scope drift check

PASS. This pass is docs-only and records design-review outcome. It does not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects. Prototype HTML/CSS/JS files were read but not modified.

## Verdict

PASS. Claude Design / UX review is recorded as `ACCEPT_WITH_NITS`, with implementation deferred.

## Design review recorded

- The technician-first flow, hierarchy, and evidence posture are directionally right.
- The prototype supports the bench workflow better than spreadsheet-style UI.
- The prototype should be used as visual + workflow direction only.
- Interactions may be reviewed as UX intent, but behavior must not be preserved as production logic.
- Do not copy localStorage, Save behavior, event-writing, schema assumptions, or runtime implementation patterns.
- No prototype files were touched by the design review.
- No code or implementation was produced.
- Full design artifact was not committed; this pass records the user-provided review summary.

## README behavior note update

The README behavior note was updated to:

`Use the prototype as visual + workflow direction only. Interactions may be reviewed as UX intent, but behavior must not be preserved as production logic. Do not copy localStorage, Save behavior, event-writing, schema assumptions, or runtime implementation patterns.`

## Key UX nits recorded

- Green `paigutatud` status dot can read as verified/good and must be neutralized in future scope.
- Evidence-dot meaning must be `a reading was recorded here`, never `this pin is good`.
- `automaatne` near Koht implies AI/app detection and must be avoided.
- `Mõõdan...` relocates the sensor from technician to app; future copy must keep the human as sensor.
- Pin chips around 34px are below the 44px touch target minimum.
- Faint small labels risk readability/AA failure.
- Board drops entirely on narrow windows; future scope must define fallback behavior.
- Reference Values Panel ladder is design direction only: `Mõõdetud` dominant amber, `Viide / Allikas` calm steel-blue, `Kandidaat` tentative/dashed violet, `Märkus` faint italic.

## Evidence-boundary preservation summary

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Board Canvas remains read-only.
- Reference/source/candidate/note values remain non-canonical unless separately human-confirmed.
- Reference/candidate/note must never look measured.
- Photo pixels are not facts.
- Damage/suspect/source/research are not proof.
- No AI diagnosis, net inference, component identity confirmation, or probability-style claims.

## What must wait for V2 event-writing architecture

- Real Save Measurement runtime.
- Add Component runtime.
- Edit Component runtime.
- Event-writing.
- Canonical fact creation.
- `known_facts.json` mutation.
- Schema changes driven by the prototype.
- Any promotion of prototype Save behavior into actual evidence workflow.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS`

Purpose: lock the first implementation-safe, read-only/display-only scope based on the UX review before any code.

## Validation

Required validation:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
