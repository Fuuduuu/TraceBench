# Current State

Current pass: NEEDS_USER_DECISION
Next recommended pass: NEEDS_USER_DECISION

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS` is closed out.

Implementation commit recorded:

- `c2a8d85b84169df8bf7728c02943be46f3c2d5bd` — `style: align board canvas workbench visuals`

Prior build-lock commit recorded:

- `e16b4f8a2ec24a99a67ac93c65d6465e9e313033` — `docs: lock board canvas workbench visual alignment`

Claude audit result recorded:

- `AUDIT_VERDICT: ACCEPT_WITH_NITS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closed implementation result

- Board Canvas remains the central Workbench.
- Local Board Canvas and measure-panel tokens align the existing dark UI with the BenchBeep black/gold/cream tone.
- Green ready/status remains visually distinct from gold active/selected emphasis.
- Existing context-panel content is behaviorally unchanged and receives only a presentational frame.
- Exact non-canonical boundary copy is present: `AI/foto/rada ei ole fakt enne kinnitamist.`
- Existing component creation, metadata edit, placement, measurement, and standalone route behavior remains unchanged.
- Measurement still requires explicit `Salvesta`.

## Manual smoke recorded

- Human visual acceptance: PASS.
- Wide smoke: `1918 x 1078`, seven screenshots reviewed across Safety, Placements, Inspector, Draft/metadata edit, Component creation, Measurement, and canvas without a context panel.
- Wide result: no clipping or RenderFlex overflow observed; Board Canvas remained dominant; rail, context panel, scrolling, controls, hierarchy, contrast, boundary copy, and measurement save gating were accepted.
- Medium smoke: human observations and acceptance supplied; no clipping or overflow; panel usable and scrollable; controls reachable; measurement usable; hierarchy and contrast accepted.

## Validation recorded

- `dart format`: PASS.
- `flutter test test/widget/board_canvas_screen_test.dart`: 122/122 PASS.
- `flutter test`: 388/388 PASS.
- `python tools/validate_all.py`: 285/285 PASS.
- `git diff --check`: PASS.
- Exact two-file implementation allowlist: PASS.
- Claude force-unwrap review: `contextPanelSlot!` is safe because it is reached only when `showContextPanel` is true, which requires `contextPanel != null`.

## Known non-blocking documentation nit

- Actual medium viewport dimensions were not recorded.
- The medium screenshot attachment was not preserved in the audit packet.
- No missing dimensions or attachment provenance are inferred.

## Boundaries

- No shared theme, Home, asset, font, package, `pubspec`, router, page, or `_incoming` runtime changes.
- No AI candidate model/data/actions and no photo, trace, or history workflow.
- No painter geometry, hit-testing, selection, pan/zoom, or fit/recenter behavior changes.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- No new implementation pass is armed.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- UI workflow policy: `docs/UI_WORKFLOWS.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`
