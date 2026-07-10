# Active Scope Lock

## Current pass

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Lock state

Docs-only build-lock is active.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

No runtime/test implementation is authorized in this build-lock pass.

## Current docs pass write allowlist

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS` may write only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS.md`

## Design input lock

`_incoming/ui_redesign/App visual/BenchBeep Workbench - Design Concept (standalone).html` is `DESIGN_INPUT_ONLY`.

- Do not edit or stage it.
- Do not import, copy, or runtime-reference it or its bundled JS/CSS/assets/fonts.
- Use only its restrained black/gold tone, compact hierarchy, and technician-facing copy as visual/reference input.
- Its AI candidate, photo, trace, history, Home, asset, font, and dependency proposals are not implementation scope.

## Armed implementation pass

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Armed implementation write allowlist

The future implementation pass may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No optional Home surface is armed. Live-code inspection did not justify a Home edit.

## Locked implementation intent

- Keep the current Board Canvas as the central Workbench.
- Restyle only existing Board Canvas shell/chrome, tool rail, canvas framing, right-panel surfaces, current cards/fields/buttons, and existing selected/active/status presentation.
- Align those surfaces with the accepted BenchBeep Home dark/gold instrument tone without introducing shared-theme, asset, font, package, or Home changes.
- Keep ready/success state visually distinct from active/selected emphasis.
- Improve technician-facing copy only inside existing Board Canvas/right-panel surfaces.
- Include `AI/foto/rada ei ole fakt enne kinnitamist.` where appropriate as non-canonical boundary copy.
- Preserve all existing right-panel modes and creation, metadata edit, visual placement, and measurement behavior.
- Preserve existing selection, pan/zoom, fit/recenter, save enablement, writer calls, event types, local event append, and projection-stale behavior.
- Widget tests may change only to assert the revised presentation/copy and preserved behavior.

## Stop conditions

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside the two-file allowlist.

Stop if implementation would require:

- Home, asset, font, package, `pubspec`, router, page, or standalone-screen changes
- importing/copying/runtime-referencing `_incoming` or the standalone HTML
- a new panel mode, new route, new workflow section, or hidden/deleted Add/Edit/Measure screen
- real AI candidate data/actions or photo/trace/history workflows
- writer, schema, validator, materializer, tool, model, event, fact, projection, Project ZIP, sample, `events.jsonl`, `known_facts.json`, or `projectState.knownFacts` changes
- component identity, placement, coordinate, pin, contact, pad, net, path, trace, electrical, measurement, AI-fact, or repair semantic changes
- painter geometry, hit-testing, selection, pan/zoom, or fit/recenter behavior changes

## Protected boundaries still in force

- `events.jsonl` remains canonical truth; `known_facts.json` remains projection/cache.
- AI/helper may not author canonical facts or events.
- Photo pixels and visual traces are not facts or electrical nets.
- Board Canvas renderer/painter writes nothing.
- Existing explicit human save actions retain their separately accepted writer behavior.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics changes.

## Future implementation validation

- `dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Manual smoke is required after the future visual implementation and before its Claude audit.

## Route

Current: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`
