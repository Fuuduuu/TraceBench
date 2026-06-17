# Active Scope Lock

## Current pass

`PROJECT_SOURCE_GUIDE_REFRESH_PASS`

## Type

`DOCS_SYNC / SOURCE_ORIENTATION_REFRESH`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Repo-local docs/source-orientation refresh. Do not modify runtime code, tests, tooling, schemas, samples, generated/platform files, stage, commit, or push.

## Current goal

- Refresh repo-local assistant/source orientation after the Project Overview / Workbench layout-density route was closed out.
- Record that the current accepted route is `NEEDS_USER_DECISION`.
- Record latest accepted pushed work as `19fc1c9` (`docs: close out project overview layout density`).
- Preserve accepted Project Overview / Workbench density and Board Canvas manual-smoke PASS state.
- Keep external source-guide material orientation-only and non-canonical.

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Latest pushed closeout: `19fc1c9` (`docs: close out project overview layout density`)
- Implementation commit: `bd929ca` (`feat(project-overview): polish layout density`)
- Independent audit verdict: `ACCEPT_AS_IS`
- Focused Flutter validation before implementation push: `flutter test test/widget/project_overview_screen_test.dart` PASS (`17/17`)
- Repo validation before implementation push: `py -3 tools/validate_all.py` PASS (`273`)
- Board Canvas manual smoke: PASS with user wording "kõik on passed. ja töötab"

## File allowlist for this docs-only pass

Governance/source-orientation docs only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/PROJECT_SOURCE_GUIDE_REFRESH_PASS.md`

## Accepted Project Overview density state to preserve

- Responsive read-only board/workbench preview enlarged and made dominant.
- Wide right action rail compacted from 300px to 252px.
- Rail spacing/status chips/helper copy tightened.
- Future tools collapsed by default via restorable `ExpansionTile`.
- Expanded Future tools remain disabled/inert.
- Primary actions, existing routes, read-only preview behavior, and existing keys preserved.
- Board Canvas runtime/tests untouched.
- writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces untouched.

## Accepted Board Canvas state to preserve

- Board Canvas is accepted/pushed/manual-smoke PASS.
- Renderer remains read-only with `renderer writes: none`.
- Accepted state includes board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety/Evidence controls, canvas status overlay, and volatile inspector hide/show.

## Strict non-goals / forbidden changes

- Runtime code
- Tests
- Board Canvas runtime/tests
- Save Measurement behavior
- Add Component behavior
- Edit Component behavior
- Reference Images behavior
- writer service
- `MeasurementEventWriter`
- schema/model
- validator/materializer/projection
- Project ZIP import/export
- `known_facts` mutation
- `events.jsonl` write path
- facts/events/coordinates
- placement/measurement/marker editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- photo/layers/AI/OCR/CV
- `sequence`
- `Muu ühik`
- dependency/toolchain/generated/platform changes
- new duplicate orientation/source-guide files

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current pass: `PROJECT_SOURCE_GUIDE_REFRESH_PASS`

Current accepted route: `NEEDS_USER_DECISION`

Next: `NEEDS_USER_DECISION`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- This docs-only pass does not reopen Project Overview implementation.
- This docs-only pass does not change canonical fact/event/write behavior.
