# Active Scope Lock

## Current pass

`V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`

## Type

`DOCS_SYNC / POST_AUDIT_RECORD`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Repo-local docs-only governance update. Do not modify runtime code, tests, tooling, schemas, samples, generated/platform files, stage, commit, or push.

## Current goal

- Record that `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` was independently post-audited by Claude Code and accepted as `ACCEPT_AS_IS`.
- Record that the implementation was committed and pushed as `bd929ca` (`feat(project-overview): polish layout density`).
- Preserve the accepted implementation summary and validation evidence.
- Route to `NEEDS_USER_DECISION` as the final bookkeeping step for this Project Overview / Workbench density slice.

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Scope-lock baseline: `c59d3ae` (`docs: lock project overview layout density`)
- Implementation commit: `bd929ca` (`feat(project-overview): polish layout density`)
- Independent audit verdict: `ACCEPT_AS_IS`
- Focused Flutter validation: `flutter test test/widget/project_overview_screen_test.dart` PASS (`17/17`)
- Repo validation: `py -3 tools/validate_all.py` PASS (`273`)
- Whitespace validation: `git diff --check` PASS; CRLF working-copy warnings only

## File allowlist for this docs-only pass

Governance only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS.md`

## Accepted implementation summary to preserve

- Project Overview / Workbench board preview is larger and more dominant.
- Wide right rail was compacted from 300px to 252px.
- Rail spacing/status chips/helper copy were tightened.
- Future tools are collapsed by default using a restorable `ExpansionTile`.
- Expanded Future tools remain disabled/inert.
- Primary actions, existing routes, read-only preview behavior, and existing keys were preserved.
- Board Canvas runtime/tests were not touched.
- writer/schema/materializer/validator/projection/Project ZIP/facts/events surfaces were not touched.

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
- broad app-wide theme/token migration

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`

Next: `NEEDS_USER_DECISION`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- This docs-only pass does not reopen Project Overview implementation.
- This docs-only pass does not change canonical fact/event/write behavior.
