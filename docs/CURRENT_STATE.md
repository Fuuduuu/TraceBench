# Current State

Current pass: BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS
Next recommended pass: BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

Docs-only build-lock for a minimal Board Canvas Workbench visual-alignment implementation.

No runtime or test implementation is performed in this pass.

Verified prerequisite state:

- Route before this pass was `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- No active implementation lock was armed.
- Tracked and cached diffs were clean.
- `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_POST_AUDIT_PASS` records the accepted/pushed measurement right-panel closeout.
- `docs/POHIKIRI.md` remains the first-read charter.

## Design input

`_incoming/ui_redesign/App visual/BenchBeep Workbench - Design Concept (standalone).html` is `DESIGN_INPUT_ONLY`.

It informs a restrained black/gold instrument tone, compact workbench hierarchy, dense right-panel presentation, technician-facing copy, and the boundary line:

`AI/foto/rada ei ole fakt enne kinnitamist.`

The HTML, its bundled JS/CSS/assets/fonts, and its proposed AI candidate/history/photo/trace workflows must not be imported, copied, or runtime-referenced.

## Armed implementation slice

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS` may:

- keep the existing Board Canvas as the central Workbench
- visually align existing Board Canvas shell/chrome, rail, canvas framing, and existing right-panel surfaces with the accepted BenchBeep Home dark/gold tone
- improve technician-facing copy only inside existing Board Canvas/right-panel surfaces
- add the non-canonical boundary line above where it fits the existing panel hierarchy
- update Board Canvas widget tests for the visual/copy contract while preserving existing behavior coverage

Existing component creation, metadata edit, visual placement, measurement, selection, pan/zoom, fit/recenter, and standalone route availability must remain behaviorally unchanged.

## Armed implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No Home file is armed. Live-code inspection found no need to edit `lib/features/home/screens/benchbeep_home_screen.dart` or its tests.

## Boundaries

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any other file.

Do not add AI candidate models/data, photo workflows, trace workflows, history workflows, fonts, assets, packages, router/pages, or shared theme infrastructure. Do not hide/delete standalone Add/Edit/Measure screens. Do not change writer/schema/validator/materializer/tool/model/event/fact/projection/Project ZIP behavior, `events.jsonl`, `known_facts.json`, or `projectState.knownFacts`.

No component identity, placement, coordinate, contact, pin, pad, net, trace, electrical, measurement, AI-fact, or repair semantics may change. Painter geometry and hit testing remain unchanged; color-only presentation changes must not alter selection or interaction behavior.

## Route

Current: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- UI workflow policy: `docs/UI_WORKFLOWS.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`
