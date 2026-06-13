# Current State

## Current pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS`

## Next recommended pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_POST_AUDIT_PASS`

- New implementation pass opened: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS`.
  The first implementation slice is a PCB-first Project Overview shell in presentation-only layout:
  `Lisa mõõtmine` is primary, Add/Edit are secondary, and board/status context remains read-only and projection-backed.
  Save/Add/Edit/event/projection runtime behavior remains unchanged in this pass.

- Save Measurement unit-control UX implementation is accepted and pushed in commit
  `8e93f46` (`fix(measure-sheet): remove inert unit display`).
- Accepted behavior: inert `_UnitDisplay` unit chip panel removed; `measure-sheet-unit-dropdown`
  remains the sole unit affordance; selected unit remains visibly reflected in the dropdown.
- Existing explicit target-selection behavior remains unchanged:
  no implicit target auto-selection, explicit `Koht` choice required, and Save remains
  disabled without value + selected unit + explicit target.
- Existing runtime boundaries remain preserved:
  - writer/request shape unchanged
  - no writer-service or event-model/schema/materializer/validator change
  - no `sequence`
  - no `Muu ühik` or custom-unit behavior
  - no AI/photo/context unit inference.

## Tooling baseline milestone

- Added `AGENTS.md` project-level Codex instructions.
- Added repo-local TraceBench guidance skills in `.agents/skills/`.
- Added `docs/CODEX_TOOLING_POLICY.md`.
- This pass is docs/agent-skills only: no runtime installs, dependency/tool changes, MCP/plugin enablement, or implementation surface changes.

## Latest accepted route

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS` recorded as `ACCEPT_AS_IS` with recheck `safe_to_commit: YES`.

Observed implementation context:

- `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` is implemented and routed as:
  - `/project/measurements/new` compatibility redirect → `/project/measure-sheet`.
  - Project Overview legacy CTA to accepted V2 `measure-sheet` flow.
- No sequence changes are made to V2 events in this pass.
- `MeasurementRecordScreen` is no longer part of normal Overview measurement flow.
- `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` accepted commit:
  `f49bd63 fix: retire legacy measurement write path`.
- Post-audit/recheck result:
  `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_RECHECK_PASS`
  accepted as `ACCEPT_AS_IS`, `safe_to_commit: YES`.
- Add Component framing and Save Measurement unit duplication remain out-of-scope.
- Manual smoke acceptance recorded:
  - Status: `PASS_WITH_ENVIRONMENT_LIMITATION`.
  - `Overview -> Lisa mõõtmine` opens V2 `measure-sheet`.
  - `/project/measurements/new` redirects to `/project/measure-sheet` via compatibility route.
  - `MeasurementRecordScreen` did not appear in normal Overview flow.
  - Save result was: `Not saved: project must be opened from a local folder.`
  - No legacy-sequence exception evidence was observed in this smoke run.
  - Full `events.jsonl` append/`known_facts.json` persistence evidence was not proven due the environment restriction.
- Accepted implementation recorded in:
  `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS` (commit `9a61cd0`)
- Behavior now enforced:
  - Measure Sheet does not auto-select `components.first` / first pin for Save target.
  - `_selectedTargetKey` defaults to `null` and requires explicit user selection.
  - `measure-sheet-target-dropdown` is required before Save can proceed.
  - Save remains disabled until value + unit + explicit target are present.
  - No-options/no-target state remains explicit and keeps Save disabled.
  - Writer request uses the explicitly selected target metadata.
- Guardrails preserved:
  - V2SaveMeasurementWriter semantics unchanged.
  - No sequence field was added to V2 event payload paths.
  - No event schema, validator/materializer, or writer-service behavioral changes.
  - Board Canvas / Reference Images runtime unchanged.

## Visual design capture status

Captured visual redesign from:

`_incoming/ui_redesign/TraceBench_UI_Redesign_Visual_Design_Pass_standalone.html`

Capture status:

- source available locally
- content captured as markdown in `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS.md`
- raw standalone HTML artifact is not committed as runtime/source code or source-of-truth data asset.

Directional points recorded:

- PCB-first Project Overview.
- Add / Edit / Save shells are independent and locality-scoped.
- Save Measurement uses single unit input (`chips + Muu ühik`).
- Edit supports existing-component selector and visible empty-state path.
- Candidate/reference/context fields are visual hints, not canonical evidence.
- Runtime write and sequence remediation remain out-of-scope and explicitly deferred.

## Boundaries confirmed

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI is not a source of canonical truth.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- Template/footprint/photo/candidate/helper context remains hint/context only.
- No runtime/test/writer/schema/materializer/validator/Project ZIP/Board Canvas write/edit/Reference Images runtime/AI/OCR/CV/photo-markup/repair-map/visual-trace-shape-assist changes in this pass.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Smoke-test run audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS.md`
- Smoke-test triage audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS.md`
- Legacy write-path retirement smoke closeout: `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_CLOSEOUT_PASS.md`
- Visual capture audit: `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS.md`
- Legacy write-path retirement scope lock: `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`
