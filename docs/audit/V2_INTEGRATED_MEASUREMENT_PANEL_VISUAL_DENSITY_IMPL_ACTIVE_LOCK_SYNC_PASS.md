# V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: protected-UI / Lane-B-adjacent.
- Type: `CODEX / DOCS_ACTIVE_LOCK_SYNC`.
- Scope: docs-only route/active-lock sync.
- Reason: this sync arms Board Canvas UI near accepted measurement write-flow boundaries, so the future implementation must stay local UI-only and non-writing unless a later separate writer scope explicitly authorizes Board Canvas write wiring.

## Baseline

- Git HEAD at pass start: `42c3594` (`docs: lock measurement panel visual density scope`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Latest accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS` at `42c3594`.
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25`.
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` at `80c9bff`.
- Live route docs from the accepted scope-lock state pointed next to `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` still described the completed docs-only visual-density scope-lock and did not yet name the implementation pass or exact runtime/test allowlist.

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `42c3594`, set this active-lock sync as current, and route next to the implementation pass.
- Updated `docs/PASS_QUEUE.md` to mark the visual-density scope-lock accepted/pushed, set this sync as current, and mark the future implementation pass as next after sync acceptance.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with the active implementation lock for `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`.
- Updated `docs/AUDIT_INDEX.md` with the accepted scope-lock hash and this audit artifact pointer.
- Added this audit artifact.

## Exact future implementation allowlist

Future implementation pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`

Allowed future implementation files:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Rationale:

- The accepted integrated Measure panel is owned by Board Canvas.
- Visual density, spacing, measured-value row readability, compact value/unit controls, quiet Advanced behavior, compact From -> To presentation, and related widget coverage can be handled inside the existing Board Canvas screen and its focused widget tests.
- Existing router, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, asset, sample, platform, and generated files do not need edits for this local UI-only visual-density polish slice.
- `v2_save_measurement_writer.dart` is intentionally excluded because Board Canvas write wiring is not authorized.

## Allowed future polish behavior

Future implementation may only:

- improve right-panel visual density;
- reduce vertical spacing and row height where safe;
- improve label hierarchy and technician-facing copy;
- improve measured-value row readability;
- make value/unit controls more compact;
- prevent awkward wrapping or overflow;
- make Continue in Measure Sheet visually secondary;
- keep Advanced technical details collapsed, quiet, and last;
- compact From -> To context presentation;
- add or update widget tests for UI structure and the non-writing boundary.

Future implementation must preserve the accepted hierarchy:

1. Compact header
2. Component visual
3. Measured values
4. From -> To context
5. Advanced technical details

## Forbidden protected behavior

- No runtime/test edits in this active-lock sync pass.
- No implementation accepted/pushed hash claim for `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`.
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
- From -> To context remains display/provenance-only and must not imply confirmed connectivity.
- Visual traces remain visual-only and never measured nets.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation

Validation commands/results are recorded from Codex local execution:

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF checkout warnings for edited Markdown files.
- `python tools/validate_all.py`: failed on this host because `python` is not available on PATH (`Python ei leitud; käivitage Microsoft Store kaudu installimiseks argumentideta...`).
- `py -3 tools\validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Safe staging set

If accepted, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
