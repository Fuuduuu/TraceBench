# BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS

## Lane and mode

Lane A / `DOCS_SYNC` build-lock.

Docs-only. No runtime/test edits. No stage/commit/push.

## Charter guard

`docs/POHIKIRI.md` remains the tracked canonical product charter / first-read scope anchor.

The requested minimal visual/copy alignment supports the charter's Visual First workbench and human-confirmation boundary. If later implementation conflicts with the charter, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Gate result

Gate passed from live repository evidence before edits:

- Repository root: `C:/Users/Kasutaja/Desktop/TraceBench`.
- Branch: `main`.
- HEAD and `origin/main`: `2db8bcd0dbe9b0458a6366576d8667bbbd30bd8a` (`docs: close out board canvas measurement right-panel flow`).
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- No active implementation lock was armed.
- Tracked diff was clean.
- Cached diff was clean.
- `git diff --check` was clean.
- `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_POST_AUDIT_PASS` recorded the accepted/pushed measurement right-panel closeout.
- `docs/POHIKIRI.md` was read first as the canonical charter.

Known untracked scratch, including `_incoming`, remained unscoped and was not staged.

## Design input handling

Exact input inspected read-only:

- `_incoming/ui_redesign/App visual/BenchBeep Workbench - Design Concept (standalone).html`

Classification: `DESIGN_INPUT_ONLY`.

Useful visual/reference direction:

- same restrained black/gold technical-instrument tone as the accepted BenchBeep Home
- compact left rail, dominant center board canvas, and dense contextual right panel
- gold/cream active emphasis, dark inset panels, and a separate green ready/success signal
- technician-facing language rather than engine/schema jargon
- existing explicit-save boundary expressed as `AI/foto/rada ei ole fakt enne kinnitamist.`
- minimal-change framing: continue the current Workbench rather than create another product or page system

The following HTML proposals are explicitly non-binding and deferred:

- real AI candidate data, probability, confirmation, rejection, or persistence
- photo/reference-layer workflow
- trace workflow
- history/activity workflow
- Home redesign or Home copy changes
- component/pin data-model changes
- imported/captured assets, bundled fonts, CSS, JS, or dependencies

The HTML and bundled resources must not be copied, imported, staged, or runtime-referenced.

## Read-only live-code findings

Board Canvas ownership:

- `lib/features/board_canvas/screens/board_canvas_screen.dart` owns the current Workbench scaffold, compact app bar, 92 px tool rail, dominant canvas zone, 280/320 px contextual panel, existing panel modes, and local Board Canvas visual tokens.
- The same file owns the accepted right-panel component creation, metadata edit, placement, measurement, inspector, and safety/evidence presentation.
- The integrated measurement panel already owns `Koht -> Väärtus -> Ühik -> Salvesta`, explicit save enablement, `measurement_recorded` writer use, local event append, and projection-stale behavior.
- Existing creation/edit/placement/measurement writer services are imported/called from this file and do not need edits for visual/copy alignment.
- Painter geometry, placement hit testing, selection, pan/zoom, and fit/recenter behavior are already local to the Board Canvas surface and need no semantic change.

Board Canvas tests:

- `test/widget/board_canvas_screen_test.dart` already covers the shell, rail, context panel, wide/medium layouts, current color assertions, exact right-panel copy, creation/edit/placement/measurement guards, explicit writes, event types, local event append, and projection-stale behavior.
- This test file is sufficient for presentation/copy assertions and preserved-behavior regression coverage.

Accepted Home reference:

- `lib/features/home/screens/benchbeep_home_screen.dart` already owns the accepted black/gold launcher palette, including black background, dark warm panels, gold emphasis, cream text, and green ready state.
- `test/widget/benchbeep_home_screen_test.dart` covers the Home palette, assets, launcher callbacks, import/open/sample behavior, and Workbench navigation.
- No Home runtime or Home test edit is required to align Board Canvas locally.

Related Workbench route evidence:

- `lib/features/project/screens/project_overview_screen.dart` and `test/widget/project_overview_screen_test.dart` keep Board Canvas as the primary board/workbench surface and preserve standalone Add/Edit/Measure navigation.
- No router, overview, or page change is required for this slice.

## Scope lock summary

The future implementation is a minimal visual/copy alignment inside the existing Board Canvas Workbench.

Allowed outcomes:

1. Keep the current Board Canvas as the central/dominant Workbench surface.
2. Restyle existing Board Canvas shell/chrome, tool rail, canvas framing, contextual panel, current cards, fields, buttons, and active/selected/status presentation toward the accepted BenchBeep Home black/gold instrument tone.
3. Keep ready/success signaling visually distinct from gold active/selected emphasis.
4. Apply color-only treatment to existing selection emphasis only if selection, painter geometry, hit testing, pan/zoom, and interaction behavior remain unchanged.
5. Improve technician-facing copy inside existing Board Canvas/right-panel widgets without adding new sections or workflows.
6. Add the exact non-canonical boundary copy `AI/foto/rada ei ole fakt enne kinnitamist.` where appropriate.
7. Replace or simplify visible engine-oriented copy only when the truthful explicit-human-save and read-only-renderer boundaries remain intact.
8. Update Board Canvas widget tests for the new visual/copy contract and preserved behavior.

Existing behavior that must remain unchanged:

- all existing `_WorkbenchContextPanelMode` modes and rail actions
- selected component/placement context and local UI selection
- component creation through the existing accepted explicit save path
- component metadata edit through the existing accepted explicit save path
- visual placement draft/save through the existing accepted explicit save path
- measurement target/value/unit selection, validation, save enablement, writer call, event type, local event append, and projection-stale behavior
- unit option values and mapping
- standalone Add Component, Edit Component, and Measure Sheet availability
- canvas selection, empty-canvas clearing, pan/zoom, focus, fit, recenter, and measurement badges

No new AI candidate card, candidate styling/data, history block, photo block, trace block, panel mode, route, or page may be introduced.

## Armed implementation pass

`BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Exact implementation allowlist

The future implementation may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No optional Home file is armed. If any additional file is needed, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Future test requirements

The implementation test update must:

- assert the revised dark/gold Board Canvas shell/rail/right-panel presentation at existing wide and medium test sizes
- assert the exact boundary copy `AI/foto/rada ei ole fakt enne kinnitamist.`
- keep existing keys and semantic affordances where practical
- preserve rail mode, context-panel, creation, metadata edit, placement, and measurement behavior tests
- preserve explicit-save-only writer assertions and existing event-type assertions
- preserve no-write-on-render/draft/selection behavior
- preserve local event append and projection-stale assertions
- avoid real AI candidate data, photo/trace/history workflow fixtures, new routes, and filesystem-heavy image rendering

## Boundaries

The future implementation must not edit or change:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- Home tests, Project Overview, router, route definitions, or any standalone Add/Edit/Measure screen
- assets, fonts, packages, `pubspec.yaml`, or `pubspec.lock`
- `_incoming` or the standalone HTML
- writer services, schemas, validators, materializers, tools, models, samples, Project ZIP, events, facts, or projections
- `events.jsonl`, `known_facts.json`, or `projectState.knownFacts`
- canonical write behavior or accepted explicit-save behavior
- component identity, placement, coordinates, pins, contacts, pads, nets, paths, traces, electrical facts, measurements, AI facts, or repair conclusions
- painter geometry, footprint geometry, placement hit testing, selection semantics, pan/zoom, fit, or recenter behavior

Do not hide or delete standalone Add Component, Edit Component, or Measure Sheet.

Do not add real AI candidate data, candidate decisions, photos, traces, history, or probability language.

Do not claim that a photo, visual trace, candidate, or reference is a fact or electrical net.

Canonical invariants remain owned by `docs/TRUTH_INDEX.md`, including:

- `events.jsonl` is canonical truth; `known_facts.json` is projection/cache.
- AI/helper may not author canonical facts or canonical events.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Stop conditions

Stop and report instead of implementing if:

- the two-file allowlist is insufficient
- the standalone HTML or bundled resources would need to be copied/imported/runtime-referenced
- assets, fonts, packages, `pubspec`, Home, shared theme, router, page, or standalone-screen changes are required
- a new AI candidate model/data path or photo/trace/history workflow is required
- existing creation/edit/placement/measurement behavior cannot remain unchanged
- a protected surface or canonical semantic change is required
- visual alignment would require broad screen/file rewrite instead of narrow edits

## Future implementation validation

Run after the future implementation:

- `dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Manual smoke is required after the visual implementation and before Claude audits that implementation. The implementation audit packet must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

## Route after this pass

Current: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_IMPL_PASS`

## Safe staging set

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_WORKBENCH_VISUAL_ALIGNMENT_BUILD_LOCK_PASS.md`

## Review status

DRAFTED / PENDING CLAUDE AUDIT.
