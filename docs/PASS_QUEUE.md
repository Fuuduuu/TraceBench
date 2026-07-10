# Pass Queue

## Current route

Current: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Queue status

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS` is a docs-only build-lock.

It arms the next narrow implementation pass:

- `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human.

## Prerequisite closeout recorded

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_POST_AUDIT_PASS` records:

- implementation commit `a68e924189627a3e780922c976829db440b51d82`
- Claude audit `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES`
- accepted Board Canvas measurement right-panel behavior remains available
- route release to `NEEDS_USER_DECISION`

Live code and the earlier accepted audit history retain the existing component creation, metadata edit, and visual placement flows.

## Next implementation intent

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS` is visual/copy alignment only:

- keep Board Canvas as the central Workbench
- align existing Board Canvas/right-panel presentation with the accepted BenchBeep Home dark/gold instrument tone
- keep existing workbench structure and workflows
- add or adjust technician-facing non-canonical boundary copy, including `AI/foto/rada ei ole fakt enne kinnitamist.`
- treat the standalone Claude Design HTML as input-only

No real AI candidate, photo, trace, or history workflow is authorized. No Home redesign is authorized.

## Exact implementation allowlist

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS` may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Scope gate rules

- Do not edit runtime or tests in this build-lock pass.
- Do not edit Home, router, pages, standalone Add/Edit/Measure screens, assets, fonts, packages, `pubspec.yaml`, writers, schemas, validators, materializers, tools, models, events, facts, known_facts, samples, or `_incoming` in the implementation pass.
- Do not import, copy, or runtime-reference the standalone HTML or its bundled resources.
- Do not add AI candidate data or candidate confirmation actions.
- Do not add photo, trace, or history workflows.
- Preserve existing component creation, metadata edit, placement, measurement, selection, pan/zoom, fit/recenter, and explicit-save behavior.
- If implementation needs a broader allowlist, stop with `BLOCKED_ALLOWLIST_MISMATCH`.
- Do not stage, commit, or push from this pass.
