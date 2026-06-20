# V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS

Date: 2026-06-20
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a docs-only pass. The lock is constrained to route/provenance docs plus this audit file and does not touch runtime code, tests, schemas, writer/materializer/validator/projection, Project ZIP, event persistence, routing behavior, or `sequence`.

## VERDICT

ACCEPT_READY_FOR_CODEX.

## CHANGED_FILES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS.md`

## SCOPE_LOCK_SUMMARY

- Current pass objective is docs-only route lock: projection-consuming measurement overlays only in Workbench.
- Overlay direction is read-only, projection-only, deterministic, and non-authoring.
- It uses existing projected `knownFacts.measurements` / `MeasurementFact` records only and existing explicit component association logic only.
- It may expose existing visual anchors only (`board_normalized` component placements) and no new coordinate, anchor, net, pin, or trace path semantics.
- It introduces deterministic visibility controls:
  - selected-component measurement visibility
  - global show/hide all overlay
- Overlay visibility state is local/volatile UI state only.
- No persistence of overlay visibility, placement, or visibility preference.

## ROUTE_UPDATES

- `docs/CURRENT_STATE.md`: `Current pass` -> `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS`; `Next` -> `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS`.
- `docs/PASS_QUEUE.md`: promoted `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`; set next to `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS` / post-audit route.
- `docs/ACTIVE_SCOPE_LOCK.md`: current/next route lock moved to the measurement overlay scope lock and governance allowlist narrowed to overlay lock surface files.
- `docs/AUDIT_INDEX.md`: promoted architecture-refresh status and added measurement-overlay scope-lock draft row.

## PREVIOUS_PASS_PROMOTION

- `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` promoted to:
  - `accepted/pushed as 94a1143` (`docs: refresh workbench architecture reference`)
- Before this pass the route pointer was `NEEDS_USER_DECISION`.

## ALLOWED_SURFACES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS.md`

## FORBIDDEN_SURFACES

- Runtime code, tests, tools, schemas, writer, validator, materializer, projection, and `Project ZIP`.
- `sequence` or new event schemas.
- Any value/unit editing, Save behavior, or canonical measurement persistence.
- View-state/projection persistence changes for overlay coordinates, visibility, or positions.
- Measure Sheet removal/rewrite/route consolidation.
- Add Component implementation surface.
- New inference/association/coordinate/trace/path/net/pad/probe/path heuristics.

## MEASURE_SHEET_PRESERVATION

- Measure Sheet remains unchanged and retains existing recording/write fallback behavior.
- No `/project/measure-sheet` deletion/redirect/merge behavior is introduced in this pass.

## ADD_COMPONENT_DEFERRAL

- Add Component remains explicitly deferred to separate future scope and is not part of this lock.
- This lock records a hard boundary that add-component controls, local placement creation, drag/rotate behavior, or confirm-write flow are outside scope.

## MULTI_MEASUREMENT_DISPLAY_RULE

Eligibility for an eligible measurement badge:

- scalar value exists
- unit exists
- explicit association to a component exists using existing association logic
- component has existing visual placement anchor

Display rule:

- Do not aggregate measurements or create new canonical-derived values.
- Surface existing projected measurements as-is.
- If one eligible measurement exists, show that one value + unit.
- If multiple eligible measurements exist, deterministic stacked badges are required (or a non-canonical summary affordance) with no derived arithmetic.
- Validity status must inform whether shown value is canonical-authoritative, stale, suspect, or invalid.

## VALIDITY_STATUS_HANDLING

- No new validity semantics are introduced.
- UI must treat existing `validityStatus` defensively:
  - stale/invalid/suspect readings are not presented as fresh authoritative values
  - stale_after_repair and related status are reflected in UI treatment only
- No re-computation or new facts are emitted from validity interpretation.

## VALIDATION_RESULTS

- `git status --short --branch`
  - `## main...origin/main`
  - modified: `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`
  - untracked scratch artifacts remain (`.idea/`, `.metadata`, `_incoming/`, `assets/samples/pelle_pv20_minimal/metadata/`, `audit_tmp*/`, `windows/`, etc.) and are intentionally non-staged.
- `git log --oneline --decorate -10`
  - `94a1143 (HEAD -> main, origin/main, origin/HEAD) docs: refresh workbench architecture reference`
  - `4af4ac6 docs: trim current-state into operational handoff`
  - `a56721d docs: centralize model-routing owner in MODEL_ROUTING`
- `git diff --name-status`
  - `M` `docs/ACTIVE_SCOPE_LOCK.md`
  - `M` `docs/AUDIT_INDEX.md`
  - `M` `docs/CURRENT_STATE.md`
  - `M` `docs/PASS_QUEUE.md`
  - `??` `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS.md`
- `git diff --cached --name-status`
  - (empty)
- `git diff --check`
  - PASS (no whitespace errors; LF→CRLF normalization warnings only on touched docs)
- `py -3 tools/validate_all.py`
  - PASS (`273 tests`, `OK`)
  - No PASS-blocking findings; optional warnings only for missing non-blocking optional photos in sample fixtures.

## FINAL_GIT_STATUS

- Modified tracked docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS.md`
- No tracked files staged.
- Untracked scratch artifacts remain.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
