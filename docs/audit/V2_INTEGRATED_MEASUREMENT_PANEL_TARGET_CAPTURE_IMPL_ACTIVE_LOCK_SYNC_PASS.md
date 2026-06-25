# V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: protected-UI / Lane-B-adjacent.
- Type: `CODEX / DOCS_ACTIVE_LOCK_SYNC`.
- Scope: docs-only route/active-lock sync.
- Reason: this sync arms Board Canvas UI near accepted measurement write-flow boundaries, so the future implementation must stay local UI-only and non-writing unless a later separate writer scope explicitly authorizes Board Canvas write wiring.

## Baseline

- Git HEAD at pass start: `375adbe` (`docs: lock measurement target capture scope`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Latest accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS` at `375adbe`.
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` at `934a5a4`.
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` at `0d015c9`.
- Live route docs from the accepted scope-lock state pointed next to `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` still described the completed docs-only target-capture scope-lock and did not yet name the implementation pass or exact runtime/test allowlist.

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `375adbe`, set this active-lock sync as current, route next to the implementation pass, and preserve accepted product-state bullets.
- Updated `docs/PASS_QUEUE.md` to mark the target-capture scope-lock accepted/pushed, set this sync as current, and mark the future implementation pass as next after sync acceptance.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with the active implementation lock for `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`.
- Updated `docs/AUDIT_INDEX.md` with the accepted scope-lock hash and this audit artifact pointer.
- Added this audit artifact.

## Chosen future implementation allowlist

Future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`

Allowed future implementation files:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Rationale:

- The accepted integrated Measure panel is owned by Board Canvas.
- Target selection, pin/leg selection UI, local draft value/unit state, validation hints, and Canvas focus/highlight/preview can be implemented as local UI state inside the existing Board Canvas surface.
- Existing router, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, asset, and sample files do not need to be edited for this local UI-only target-capture slice.
- `v2_save_measurement_writer.dart` is intentionally excluded because Board Canvas write wiring is not authorized.

## Allowed future behavior

Future implementation may allow only local UI-only behavior:

- selected measurement target row;
- pin/leg target selection UI;
- local draft value;
- local draft unit;
- local validation and empty-state hints;
- Canvas focus/highlight/preview linked to the selected target;
- optional affordance to continue the existing Measure Sheet save flow.

The technician workflow direction remains:

```text
select component -> select pin/leg/target row -> enter local draft value/unit -> keep Canvas visible
```

## Required preservation

- Future implementation remains non-writing unless a later writer scope explicitly authorizes Board Canvas write wiring.
- Functional Save remains in the accepted Measure Sheet path.
- Optional Board Canvas affordance may continue to the existing Measure Sheet save flow, but must not perform canonical save/write.
- Existing standalone Measure Sheet route and `/project/measure-sheet` direct/fallback compatibility remain preserved.
- Project Overview measurement entry remains preserved.
- Existing accepted Measure Sheet save behavior remains preserved.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/highlight/preview/draft state.
- Board Canvas does not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements.
- Board Canvas does not import, call, route to, or otherwise wire `v2_save_measurement_writer.dart`.
- Visual traces remain visual-only and never measured nets.
- Component/pin/leg/target selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, and Add Component local behavior remain preserved.

## Forbidden surfaces preserved

- No runtime/test edits in this active-lock sync pass.
- No implementation accepted/pushed hash claim for `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`.
- No edits to router, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files are authorized for the future implementation.
- No import, call, route to, or other wiring of `v2_save_measurement_writer.dart` from Board Canvas is authorized.
- No canonical event/fact writes from Board Canvas.
- No `events.jsonl` writes, `known_facts` mutation, canonical fact creation, or canonical measurement creation from Board Canvas.
- No new Board Canvas save/write behavior.
- No AI/OCR/CV fact creation.
- No placement, coordinate, net, electrical, package, pin-mapping, identity, fault-evidence, or electrical-proof semantics changes.
- No Confirm/write/Edit Layout behavior.
- No Add Component Confirm/write behavior.
- No command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation

Validation commands/results are recorded from Codex local execution:

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: failed on this host because `python` is not available on PATH (`Python was not found; run without arguments to install from the Microsoft Store...`).
- `py -3 tools\validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
