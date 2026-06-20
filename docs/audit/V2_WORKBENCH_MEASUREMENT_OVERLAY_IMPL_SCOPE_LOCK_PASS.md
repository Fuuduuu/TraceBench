# V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS

Date: 2026-06-20
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a docs-only implementation-lock activation. Codex is updating scoped route/governance docs so the next active implementation pass can legally touch only the narrow Board Canvas runtime/test surfaces required for read-only measurement overlay rendering.

No runtime code, tests, schemas, writer, validator, materializer, projection, Project ZIP, generated/platform/dependency files, samples, app routing, or protected surfaces are changed in this pass.

## VERDICT

ACCEPT_READY_FOR_REAUDIT.

## CHANGED_FILES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS.md`

## WHY_PREVIOUS_IMPL_STOPPED

The previous implementation attempt correctly stopped because `docs/ACTIVE_SCOPE_LOCK.md` still authorized only `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS`, a docs-only post-audit closeout. Runtime and test files were therefore outside the active allowlist.

## ROUTE_UPDATES

- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS` is recorded as accepted/pushed at `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`).
- Current route is advanced to `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS`.
- Next expected route is `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS`.
- `docs/AUDIT_INDEX.md` now includes this implementation-lock activation record.

## ACTIVE_SCOPE_LOCK_UPDATE

`docs/ACTIVE_SCOPE_LOCK.md` now authorizes only the narrow implementation pass for read-only Workbench measurement overlays.

The lock does not pre-authorize protected surfaces, write-flow work, Measure Sheet route changes, Add Component, schema/tool changes, projection changes, Project ZIP changes, or persistence of overlay visibility.

## IMPLEMENTATION_ALLOWLIST

The implementation pass may touch only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No additional helper/model/painter/runtime/test file is pre-authorized. If the implementation requires another file, the next Codex pass must stop and request a new scope decision.

## LOCKED_IMPLEMENTATION_BOUNDARIES

- Existing projected measurements only.
- Existing `knownFacts.measurements` / `MeasurementFact` data only.
- Existing explicit component association only.
- Existing `measurementEndpointMatchesComponent(endpoint, componentId)` association path only.
- Existing `board_normalized` component visual anchors only.
- Selected-component individual measurement visibility on/off.
- Global Show/Hide All.
- One scalar value plus unit per badge.
- Volatile UI-only visibility state.
- No persistence.
- No canonical visibility events.
- No canonical writes.
- `renderer writes: none` preserved.
- Measure Sheet unchanged.
- Add Component deferred.

## MULTI_MEASUREMENT_RULE

- Single eligible measurement may show one scalar value plus unit.
- Multiple eligible measurements must not aggregate, average, normalize, convert, or compute derived values.
- Prefer deterministic stacked badges.
- Existing projected values must be surfaced verbatim.

## VALIDITY_STATUS_RULE

Existing `validityStatus` may be consumed only as UI metadata.

The implementation must not recompute validity and must not present stale, invalid, or suspect readings as fresh authoritative values.

## FORBIDDEN_SURFACES

- Value entry, unit editing, Save, correction/delete, inline measurement entry, or measurement authoring.
- New event type, writer calls, writer changes, schema changes, validator changes, materializer changes, projection contract changes, or Project ZIP changes.
- `events.jsonl`, `known_facts.json`, `view_state.json`, preferences, or persisted overlay state.
- Canonical visibility events.
- New coordinate, target, measurement association, pin, net, trace, path, probe, pad, OCR/CV/photo-derived, proximity, inference, or automatic matching semantics.
- Measure Sheet removal, redirect, consolidation, or `/project/measure-sheet` deletion.
- Board Canvas renderer write behavior.
- Add Component button/list/drag/rotate/pin/Confirm or `component_created` work.
- Generated/platform/dependency/sample/scratch artifact changes.

## VALIDATION_REQUIRED

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `py -3 tools/validate_all.py`

## FINAL_GIT_STATUS

Expected after this docs-only pass: only the allowed route/governance docs and this audit file are modified, no files are staged, and known untracked scratch artifacts remain untouched.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
