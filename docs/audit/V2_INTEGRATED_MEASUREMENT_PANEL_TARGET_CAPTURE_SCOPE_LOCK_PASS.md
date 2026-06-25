# V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS

## Lane and type

- Lane: protected UI workflow.
- Type: `CODEX / DOCS_SCOPE_LOCK`.
- Scope: docs-only protected UI scope-lock.

## Baseline git state

- Git HEAD at pass start: `934a5a4` (`docs: record integrated measurement panel shell`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Live route docs still listed `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` as current and `NEEDS_USER_DECISION` as next; this transitional state was accepted by the pass prompt.

## Accepted baseline carried forward

- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` accepted/pushed at `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`).
- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` accepted/pushed at `934a5a4` (`docs: record integrated measurement panel shell`).
- Board Canvas Measure entry opens a right-side contextual panel in the workbench-shell UI.
- Canvas stays visible.
- The integrated panel is a non-writing shell.
- Measured values list is the main content.
- Quick local capture controls are inert/local UI-only placeholders.
- Advanced technical/provenance details are secondary.
- Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
- Existing Measure Sheet save behavior remains preserved in the accepted Measure Sheet path.

## Future protected workflow intent

The next UX slice should move the accepted integrated Measure panel toward a technician workflow:

```text
select component -> select pin/leg/target row -> enter local draft value/unit -> keep Canvas visible
```

Future implementation may allow local UI-only behavior:

- selected measurement target row;
- pin/leg target selection UI;
- local draft value;
- local draft unit;
- local validation and empty-state hints;
- Canvas focus/highlight/preview linked to the selected target;
- optional affordance to continue the existing Measure Sheet save flow.

## Protected risks

- Target selection can be mistaken for canonical pin mapping, identity, coordinate, net, or electrical confirmation.
- Local value/unit draft capture can drift into canonical measurement creation.
- A save-looking or continue affordance can drift into Board Canvas writer wiring.
- Visual focus/highlight/preview can be mistaken for electrical proof or connectivity.
- Board Canvas UI work sits near accepted Measure Sheet write behavior and must not bypass its human-authored save path.

## Scope locked by this pass

This pass locks only future direction and boundaries.

It does not implement:

- target selection runtime;
- local value/unit draft runtime;
- integrated Board Canvas save/write behavior;
- Measure Sheet UI changes;
- router or Project Overview changes;
- writer/service changes;
- canonical event/fact writes;
- schema/writer/materializer/validator/projection changes;
- Project ZIP changes;
- AI/OCR/CV fact creation;
- placement/coordinate/net/electrical/package/identity semantics;
- Confirm/write/Edit Layout behavior;
- command menu/context menu/audio/save beep/full redesign/canvas token migration.

## Future implementation gate

Runtime implementation may begin only after a later docs-only active-lock sync is accepted/pushed.

Required next pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

That future active-lock sync must:

- name the implementation pass explicitly;
- list exact runtime/test files;
- keep implementation narrow;
- preserve the non-writing Board Canvas boundary;
- preserve standalone Measure Sheet and `/project/measure-sheet` compatibility;
- preserve existing Measure Sheet save behavior;
- require manual smoke before Claude audit because the work is product/UI surface work;
- forbid new writer/schema/materializer/projection/event/fact semantics unless separately scoped.

## Required preservation for future implementation

- Future implementation remains non-writing unless a later separate writer scope explicitly authorizes Board Canvas write wiring.
- Functional Save remains in the accepted Measure Sheet path.
- Optional Board Canvas affordance may continue to the existing Measure Sheet save flow, but must not perform canonical save/write.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/highlight/preview/draft state.
- Board Canvas does not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements.
- Board Canvas does not import, call, route to, or otherwise wire `v2_save_measurement_writer.dart`.
- Visual traces remain visual-only and never measured nets.
- Component/pin/leg/target selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, Add Component local behavior, and existing Measure Sheet save behavior remain preserved.

## Work performed

- Updated `docs/CURRENT_STATE.md` to set this protected UI scope-lock as current and route next to the docs-only active-lock sync.
- Updated `docs/PASS_QUEUE.md` to record the accepted integrated panel shell closeout, current target-capture scope-lock, and next active-lock sync.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with this docs-only protected UI scope-lock and explicit runtime/write/protected-surface prohibitions.
- Updated `docs/AUDIT_INDEX.md` with this audit artifact pointer and the accepted/pushed closeout hash `934a5a4`.
- Added this audit artifact.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS.md`

## Validation

Validation commands/results are recorded from Codex local execution during this scope-lock:

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
