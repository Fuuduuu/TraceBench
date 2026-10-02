# TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_SCOPE_LOCK_PASS

```text
PASS_ID: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SCOPE_LOCK / PHASE_1
Reserved child: TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_IMPL_PASS
```

## Authority, verified entry and human decision

This scope reserves one behavior-preserving physical Measurement extraction.
Current writes are docs only. The human selected direct M1 and explicitly
rejected separate L1 shared-presentation extraction; two one-way host builders
preserve current Inspector/provenance and footprint rendering ownership.
No design-approval cycle or shared-widget/painter library is introduced.

Verified entry: `C:\dev\TraceBench`, branch `main`,
`HEAD == origin/main == ecc4bc316de311e98a451a9f0d74d29afb8c692e`,
subject `docs: maintain measurement m0 code map`, divergence `0 / 0`.

M0 characterization is committed at
`93514f92905b2ee027737c01611910913410751a`, with exactly
`test/widget/board_canvas_screen_test.dart` in that implementation commit.
Its accepted implementation evidence is attributed to the human in
`docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CODE_MAP_MAINTENANCE_PASS.md`:
22/22 M0, 231/231 Board Canvas and 756/756 full Flutter cases, and exactly
three deferred analyzer infos with zero warnings/errors. Those are predecessor
evidence, not tests rerun by this docs scope.
M0 map maintenance is committed at the entry baseline; its existing recorded
independent map/audit results and human final-six-path staging amendment remain
historical evidence. All earlier M0 write authorities are spent.

Binding owners: `docs/POHIKIRI.md`, the three operational route owners,
`docs/PROJECT_MEMORY.md`, `docs/UI_WORKFLOWS.md`, `docs/TRUTH_INDEX.md`,
`docs/PROTECTED_SURFACES.md`, `docs/AUDIT_CONTRACT.md`,
`docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md`,
`docs/PASS_LIFECYCLE.md`, the applicable maintained maps and committed
Measurement source/test zones. This Lane B reservation moves a protected
writer/session caller boundary while freezing all canonical semantics;
the explicit human decision supplies the architectural authorization.

## Exact current docs-only authority and route

Current write set, with no sixth path:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_SCOPE_LOCK_PASS.md`

Current: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_IMPL_PASS`

All lib/test/tests/tools/schema/asset/package/map/index/platform bytes,
historical artifacts, Windows residue, and scratch stay frozen. Only the
accepted historical M0 wording NIT may be corrected within the three already
allowed route owners: mark old reservations historical/spent, remove ambiguous
live authority, preserve factual content and unrelated history.
No staging, commit or push is authorized by this executor task.

## Exact future M1 allowlist and activation

Only `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_IMPL_PASS` is reserved:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `lib/features/board_canvas/widgets/integrated_measure_panel.dart` — NEW normal Dart library.
3. `test/widget/board_canvas_screen_test.dart`

No fourth implementation path. Independent scope acceptance, bounded
verdict recording, and exact human stage/commit/push of the accepted five-doc
scope material are required before implementation authority becomes active.
At implementation entry, verify the committed scope, matching live
current/next route, aligned HEAD/origin, empty staged/unmerged sets and residue.
This reservation grants no source/test writes during the docs scope.
No routine active-lock sync or separate characterization pass is reserved.

Explicitly exclude `measurement_projection.dart`, `board_canvas_palette.dart`,
ProjectSession, writer implementation/provider owner, `placement_geometry.dart`,
`component_navigator.part.dart`, `wizard_intake_overlay.part.dart`,
all other source/test files, Code Maps/index and pubspec/package changes.
Their imports/consumption may be inspected; their bytes must not change.

## Verified source ownership and bounded reading

The host map's zone 4 anchors `_IntegratedMeasurePanelState`,
`_saveMeasurement`, `_MeasureTargetRow` and `applyCanonicalEvent` bound the
Measurement workflow. Zone 1 `_BoardCanvasScreenState` / `_buildScaffold`
bounds its construction. The test map's zone 4 contains
`_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson` and
`M0 Measurement characterization`; zone 9 contains
`board canvas source keeps read-only data-path boundaries`.

Committed source verifies that panel ConsumerState owns draft maps, target,
in-flight/status/error state, form key, units/parsing/guards, V2 request/provider
call and captured-generation event application. The host constructs the panel
in the existing Measure context and owns routing/selection. Read only those
zones and their direct helper/presentation closure; expand one dependency hop
only for a failed anchor, map/source conflict, material mismatch, validation
conflict or concrete finding. No broad repository rediscovery.

## Module and host boundaries

The new normal Dart library owns the complete existing Measurement-local
widget/workflow: IntegratedMeasurePanel (public or appropriately library-visible),
ConsumerState, draft values/units, selected target, save state/status/errors,
target/context-row derivation, Measurement-only panel/row widgets, unit mapping,
parsing, save guards, form key, timestamped operation ID, exact V2 request,
`v2SaveMeasurementWriterProvider` call, ProjectSession generation capture and
returned-event application, six typed failures, generic failure and post-save
copy. The writer call physically moves with State; never replace it with
panel -> shell callback -> writer. The host loses its Measurement writer import
and invocation.

BoardCanvasScreen remains the shell/orchestrator: Measure mount/lifetime,
activation and auto-selection, Canvas selection, placement lookup, >=900
content-width branch, compact Measure Sheet route, focus/context visibility,
Inspector and Board rendering/painters.

Expected stable inputs:
`ProjectState projectState`, `String? selectedComponentId`,
`ComponentFact? selectedComponent`, `List<MeasurementFact> relatedMeasurements`,
`List<VisualTraceFact> relatedVisualTraces`,
`VoidCallback onContinueToMeasureSheet`, and the two host builders.
Minimal equivalent Dart typedef spelling may be chosen during M1.

No `part`, host import, placement-geometry import solely for rendering,
Board painter ownership, CanvasSelection or shell focus/mode knowledge.
No constructor writer, session, ProviderContainer, private placement entry or
painter object/type. No controller/Notifier/provider/repository/service,
DTO/view-model/module-interface abstraction or new shared helper library.

Dependency direction:
host constructs module and supplies closures; module reads the existing
ProjectSession and writer providers directly. No module -> host dependency.

## Advanced-details builder seam

Keep host-private `_MeasurementSummaryTile`, `_VisualTraceSummaryTile`,
`_SectionHeader`, `_EvidenceTag` and `_InspectorField`.
No shared extraction, duplication/fork of provenance tiles or evidence change.

Host supplies today's advanced-details CHILDREN through one function-typed
seam, preferably `List<Widget> Function(BuildContext context)`.
Equivalent minimal typing must preserve direction and the exact widget tree.
Use the panel's current BuildContext for Theme; introduce no wrapper.
Module retains the ExpansionTile frame, current location/order and state,
`board_canvas_measure_advanced_section`, `Tehnilised detailid` and
`kirjutuskaitstud päritolu`.

Preserve today's children and spacing:
empty `No advanced details for selected component.`; otherwise
`Visual trace provenance` + `READ` + visual trace tiles,
then `Existing measurement provenance` + `READ` + measurement tiles.
Visual traces remain before measurements. Inspector tile rendering is unchanged.

## Footprint-preview builder seam

Keep host-private `_FootprintPreviewPainter`,
`_componentPreviewSemanticsLabel`, `_BoardPlacementPainter`,
`_PlacementEntry`, `_KnownPinVisualRef`, footprint pin render plans/helpers,
contact visibility helpers, `_kFootprint*`,
`_kPreviewFootprintVerticalCenterOffset` and Board painter statics.
No painter movement, public Board painter statics or shared painter library.

Host builder returns the same Semantics -> CustomPaint subtree, with today's
semantics label, key `board_canvas_measure_component_footprint_preview` and
existing `_FootprintPreviewPainter(...)`. Its closure may capture the current
placement; that private type never crosses the module API.
Module supplies only minimal selected-target/display-visual-label/measured-count
render inputs.

Module keeps the preview section/stage, exact 82 px painter slot, left/right
gutters and center slot, target pads/selection callbacks, selected labels and
`Visual only; contacts not added.` / `Visual only; no connectivity proof.`.
Preserve pixels, semantics, keys, controls, dimensions and tree position.

## Placement replacement, pure helpers and visual tokens

Replace module uses of `_PlacementEntry` with nullable selectedComponentId and
ComponentFact. BOTH inputs MUST derive from the SAME currently resolved visible
placement entry that already gates today's Measurement eligibility.
Conceptual host wiring (retain the committed resolver and natural local naming):

```text
final selectedEntry = <today's resolved visible placement entry>;
IntegratedMeasurePanel(
  ...
  selectedComponentId: selectedEntry?.placement.componentId,
  selectedComponent: selectedEntry?.component,
  ...
)
```

Never derive Measurement inputs from the general host `_selectedComponentId`
getter, `ComponentSelection.componentId`, navigator-level component selection,
or any component identity not obtained through that resolved placement entry.
Do not replace the committed placement resolver/eligibility with general
component selection or a component lookup through that general getter.

With no resolved Measurement placement entry, BOTH selectedComponentId and
selectedComponent are null. Measurement remains unwritable even if Canvas or
navigator has a component-level selection; this is write safety, not presentation.
Nullability then preserves today's selected/not-selected checks.
Preferred label: trimmed nonempty designator, otherwise component ID.
Header: `<designator> (<componentId>)` when present, otherwise component ID.
Keep selection semantics; create no placement/view-model DTO.

Host retains `_displayDirectionLabel` and `_firstPresentText` for Inspector.
Private byte/behavior-equivalent Measurement-only copies in the module are
explicitly permitted; no projection edit or shared helper file.
Needed private `_kMeasurePanel*` tokens may move/copy with EXACT values.
Host retains colors its painter needs. No palette consolidation or redesign
of color, spacing, dimensions, typography or density.

## Attributed GPT/ChatGPT architecture and risk review

The human supplied this GPT/ChatGPT strategy and architecture/risk review after
Claude's pre-acceptance findings. This is attributed risk input, not Claude
audit acceptance or a new audit-verdict schema.

- Reviewed the M1 architecture after those findings.
- Selected-input write safety is acceptable ONLY when BOTH selectedComponentId
  and selectedComponent derive from the resolved placement entry, never
  `_selectedComponentId`.
- Direct-data-path negative guards must cover both host and extracted module.
- measurement_projection source stays frozen; its map is expected
  UPDATE_REQUIRED after the new consumer/ownership change.
- The exact three implementation paths remain sufficient.
- No new writer, session, event, schema, evidence, Project ZIP, painter,
  placement, routing or provider architecture is authorized.
- After these scope corrections, no additional GPT architecture/risk blocker
  is identified.

## Absolute behavior freeze

BEFORE behavior == AFTER behavior; preserve all M0-characterized behavior.

1. Same mount site and no new Key/provider lifetime. Drafts survive selection
   changes within current State and reset on existing unmount/remount.
   Preserve 935/936 viewport cutover and >=900 content-width rule.
2. Exact order: current project/session read -> generation capture BEFORE await
   -> writer save -> applyCanonicalEvent(event, generation) -> mounted guard
   -> local status. Never move application after the mounted check.
3. Keep `ref.read(projectStateProvider) ?? widget.projectState` or its exact
   behavior equivalent.
4. Ignore the current application bool. Stale generation remains a no-op
   against newer state; a result after panel unmount still reaches the session
   before the UI guard. No synthetic canonical row.
5. Writer/provider invocation moves with Measurement State, never through
   a host save callback; no host Measurement writer import/call remains.
6. Preserve every request field: value, valueText, displayValue, unitLabel,
   schemaUnit, mode, targetKey, displayLabel, componentId, pinId,
   valueProvenance and clientOperationId; no new/removed fields.
7. Exact timestamped Board Canvas operation ID and normalization
   `[^A-Za-z0-9_]+`; retain underscores and current subsequent normalization.
   No clock injection, UUID change or merge with Measure Sheet semantics.
8. Exact guard order/copy: selection, row where possible, existing value,
   empty value, empty unit, successful-form repeat, missing/blank directory.
   Do not manufacture unreachable states.
9. Byte-exact saving/appended/existing-result, six typed-failure and generic
   exception copy; same status and in-flight lifecycle.
10. Same target derivation/order, existing-value/default-unit behavior,
    Beep display normalization, numeric-versus-text parsing, visual traces,
    context rows, effective selected target and fallback row.
11. Same designator-present/absent preferred labels and header.
12. Same advanced ExpansionTile key/frame/location/state/copy/tags/empty
    children, trace-before-measurement ordering and Inspector tiles.
13. Same footprint Semantics/pixels/key/82 px slot/controls/gutters/labels
    and visual-only copy.
14. Same wide Measure context, compact Measure Sheet routing, auto-selection,
    tool/focus and shell behavior; no navigation change.
15. No event/schema/fact/materializer/writer/Project ZIP/evidence/electrical/
    repair/AI semantics change. Visual traces/contacts never prove electrical
    connectivity; rendering never establishes canonical truth.

## Characterization gate before production movement

Within the allowed Board Canvas test file, add focused assertions against
UNCHANGED production for:
1. Empty advanced details: `No advanced details for selected component.`.
2. Nonempty visual provenance + its `READ`, and existing measurement provenance
   + its `READ`.
3. Visual trace provenance/details before measurement provenance/details.
4. Component-selected/no-placement Measurement write safety. Use a project with
   at least one component, select its unplaced component through today's
   navigator/component-level UI, then enter/open Measure through today's UI.
   The fixture must leave no resolved Measurement placement entry and use a
   valid local project directory, so the selection guard is not masked by
   a missing-directory condition. Preserve today's eligible panel presentation
   and lifetime rather than manufacturing a different State.
   Assert header `Select a component on Canvas.`, save guard
   `Vali mõõtmise Koht plaadil.`, disabled save button and zero Measurement
   writer requests. This fourth case must PASS before production extraction and
   pass unchanged afterward; do not alter production to make baseline pass.

Keep these cases in the existing `M0 Measurement characterization` group so
its focused command selects all old and new Measurement evidence. Before any
production edit, run:
`flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "M0 Measurement characterization"`.
The new assertions must PASS baseline. This is characterization, not manufactured RED. Do not modify production to
make them pass. After extraction, pass the same assertions unchanged.
Retain all M0 evidence, existing tests and static checks. No separate pass.

## Static source-guard migration contract

Read both host and new module source. Retarget ONLY assertions whose physical
ownership moves; preserve their assertion strength, including negative
boundaries. Do not broadly rewrite the source-guard test or delete checks.

Module checks: Measurement widget/State and row/panel symbols, moved copy/keys,
`_reservedPinControlGutterWidth`, left/center/right gutter keys, the deferred
visual-editing comment, visual-only copy, V2 request and writer provider.

Host checks: footprint painter, private Board statics
`_drawFootprintBody`, `_drawFootprintSurfaceDetails`,
`_drawDecorativePackagePads`, contact helpers, footprint constants,
semantics helper and shell/composition controls.

The old `selectedEntry: widget.selectedEntry` assertion describes the removed
private-entry seam: replace only that ownership assertion with equivalent
stable component-input/builder boundary evidence, without weakening selection.

Keep every existing host negative assertion. Also assert the same relevant
direct-data-path negatives against the NEW Measurement module source, at minimum:

- `MeasurementEventWriter`
- `event_writer_service.py`
- `jsonDecode(`
- `known_facts.json`
- `events.jsonl`
- `board_graph.json`
- `view_state.json`

These are negative ownership/write-bypass guards on both source owners.
Do not remove, weaken or retarget away the host negatives when the caller moves.
The module uses only the existing `v2SaveMeasurementWriterProvider` /
`V2SaveMeasurementRequest` boundary and ProjectSession provider application;
no direct canonical-file access or legacy writer path.

Add useful explicit negatives: host contains no
`_IntegratedMeasurePanelState` declaration, V2SaveMeasurementRequest,
v2SaveMeasurementWriterProvider or Measurement writer import.
Module contains/imports no host, _PlacementEntry, _BoardPlacementPainter,
CanvasSelection, placement geometry/painter ownership or shell mode/focus state.
Existing Inspector/Wizard/geometry/painter/shell assertions remain on their
existing source owners; no unrelated static-check rewrite.

## Human-authorized multi-zone exception

The explicit human decision authorizes the smallest unavoidable combination
for ONE physical extraction under the Code Map Standard:
- host zone 4 Measurement ownership;
- host zone 1 only at panel construction and the two host builder seams;
- test zone 4 Measurement characterization;
- test zone 9 only static source-owner retargeting.

No other materially changed responsibility zone and no independent cleanup
are authorized. A required additional independent zone stops with
`DECOMPOSE_REQUIRED` / `BLOCKED_ALLOWLIST_MISMATCH`.
Inspector/painter declarations stay inspect-only; closure composition does not
authorize their movement or behavior change.

## Code-map preflight and later committed-source expectation

Index lookup resolves these three current `MAINTAINED` maps:
- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`;
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`;
- `docs/code_maps/lib/features/board_canvas/logic/measurement_projection.dart.md`.

No source responsibility changes in this docs scope; all three current
dispositions are `REVIEWED_NO_CHANGE`. Literal verification resolves 64 host,
56 test and 11 projection anchors. Host/test each have 12 zones; projection 5.
Committed source matches the inspected working source.

Inspect-only coupling: host selection/responsiveness (zones 2/11), Inspector
tiles (zone 9), painters/geometry (zone 8), session/provider and existing writer,
pure projection consumers. All independent source/test zones are excluded.
Direct dependencies remain Flutter/Riverpod, ProjectState/facts, existing
ProjectSession/provider, existing V2 writer/provider and pure projection.
Future blast radius: [D] physical ownership, import/composition and static
source evidence; [P] implementation must verify preserved lifetime/layout.
Future workflow write classes stay UI_LOCAL, CANONICAL_EVENT and
PROJECTION_STATE; this scope writes docs only.
Affected evidence is M0/the four pre-move cases and the source-owner
boundary test, plus required full suites.

After accepted committed M1:
- host map UPDATE_REQUIRED for ownership/writer/dependency/composition;
- test map UPDATE_REQUIRED for static owners and characterization;
- requalify the new library from committed source. State plus canonical-writer
  calling is expected to qualify, but no qualification/map is fabricated now;
- projection map UPDATE_REQUIRED expected, while measurement_projection.dart
  SOURCE remains byte-identical and excluded from implementation edits.
  The new integrated_measure_panel.dart becomes an additional direct helper
  consumer, including `measurementEndpointMatchesComponent`; the map's current
  excluded host-save consumer/ownership prose becomes structurally stale when
  Measurement State/save move out of the host. Classification:
  DEPENDENCY / CONSUMER / OWNERSHIP descriptive drift. Later committed-source
  maintenance decides exact body edits and restores lifecycle. No projection
  source/map/index edit or fourth M1 implementation path is authorized.

Maps/index remain frozen during implementation. Required maintenance is later,
separate, committed-source work selected by the human. No maintenance PASS_ID,
exact material set or other product/refactor pass after M1 is armed.
M2 performance, Components, Inspector and Placement remain future decisions.

## Future M1 automated acceptance and analyzer baseline

From repository root:
- Before production movement, all four focused characterization cases PASS.
- After extraction, `flutter test --no-pub test/widget/board_canvas_screen_test.dart --plain-name "M0 Measurement characterization"`
  includes all M0 cases and the four new characterization cases PASS, unchanged.
- `flutter test --no-pub test/widget/board_canvas_screen_test.dart` PASS.
- `flutter test --no-pub` full suite PASS.
- `flutter analyze --no-pub`: zero errors/warnings and no finding in the
  three changed paths. A nonzero exit is acceptable ONLY for exactly:
  `lib/shared/services/python_runner.dart` /
  `library_private_types_in_public_api` x1 and
  `test/widget/reference_images_screen_test.dart` / `overridden_fields` x2.
  No additional finding; no suppression/repair of debt. Any new/changed-file
  finding stops with `NEW_ANALYZER_REGRESSION`.
- `py -3 -X utf8 -B tools/doctor.py` PASS.
- Temporary-output validate_all below PASS.
- Both `git diff --check` and `git diff --cached --check` PASS.

The analyzer authority is committed
`docs/audit/TRACEBENCH_ANALYZER_LINT_DEBT_SCOPE_PASS.md`, corroborated by
accepted M0 predecessor evidence in the maintenance artifact.
Line drift alone does not turn an unchanged declaration/rule into new debt.

Verify exactly the three substantive implementation paths and the module as
the sole new implementation file; preserve unrelated test zones/production,
all maps/index, residue/scratch and packages. Baseline remains aligned and
unchanged during executor work; staged/unmerged remain empty.
No optimization of O(N×M), Gemini cleanup, localization, keys/spacing changes,
Measure Sheet writer/idempotency change, or token cleanup.
Manual smoke: AUTOMATED_ONLY_OK / NOT_APPLICABLE unless automated evidence
exposes a concrete visual/lifecycle conflict; no mandatory Windows smoke.

## Docs-scope validation and preservation contract

For this five-doc scope verify matching route and artifact/ledger, exact
current/future sets, explicit multi-zone exception, one neutral row and one
empty verdict block, aligned baseline/divergence, staged/unmerged emptiness,
source/test/maps/index and historical/residue preservation, doctor and both
Git diff checks. The docs convention in Prompting Protocol also requires
validate_all, with temporary fixture outputs; no Flutter rerun for this
docs-only scope absent a concrete conflict.

Raw-byte preservation uses SHA-256 of `Path(path).read_bytes()` before/after,
for every Git-tracked and nonignored untracked file from
`git ls-files --cached --others --exclude-standard -z`.
Predecessor history from each route owner's first `Completed combined` heading
onward and all old ledger bytes are checked separately outside the authorized
prefix/NIT edits and new row.
This representation is raw working-tree bytes, without EOL normalization.

Temporary-output validate_all invocation, PowerShell at repository root:

```powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='m1_scope_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-m1-scope-validation-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

## Observed docs-scope validation

- `py -3 -X utf8 -B tools/doctor.py`: PASS, exit 0.
- The temporary-output validate_all invocation above: PASS, exit 0;
  324 Python tests, with four expected missing-optional-photo warnings in
  temporary ZIP/project fixtures. No repository fixture output was rewritten.
- `git diff --check` and `git diff --cached --check`: PASS.
- The three operational route tuples agree, and the exact current/future
  allowlists and unique empty verdict block were checked.
- All old ledger bytes and predecessor history from each route owner's
  first `Completed combined` heading were preserved as raw working-tree bytes.
- All 131 literal responsibility anchors resolved across the three maps.
- Flutter tests and analyzer execution: NOT_APPLICABLE to this docs-only scope;
  predecessor results above remain attributed evidence, and the future child
  must run the complete acceptance contract.

## Stops and TOOL_SKILL_CHECK

Stop on baseline/route/authority mismatch, any sixth current or fourth future
path, protected semantics change, map/anchor conflict, additional independent
zone, out-of-scope validation failure or new analyzer regression.
No source edit is authorized to resolve a docs-only failure.

Repo-local scope-lock skill is used for current/future separation and bounded
reservation; prompt-authoring skill is used for the genuine diff audit handoff.
Inventory owner: `docs/CODEX_TOOLING_POLICY.md`.
Audit-reconciliation skill is not applicable to this new scope.
Helpers used: Git/rg, PowerShell/Python raw-byte checks, doctor and
temporary-output validate_all. No helper/fixture/script changes.
External tool required: NO.

## Independent scope audit and bounded Phase 2

Apply `scope-lock-post-audit` to the complete five-doc diff, excluding only
the empty verdict block below; review the entire new artifact without staging.
Return AUDIT_VERDICT, SAFE_FOR_STAGING and exact SAFE_STAGING_SET.
The independent result must authorize only these two Phase-2 coordinates:
1. This artifact's designated verdict block INTERIOR.
2. This PASS_ID's AUDIT_INDEX Status cell, mechanically mirroring the same
   verdict/safety/exact set under the ledger's existing formatting convention.

Freeze both marker lines, all route-owner bytes, ledger description/other rows
and every other Phase-1 byte. Capture/compare full raw hashes and prove the
two-coordinate delta and matching results without material-set expansion.
Any other patch requires re-audit. No new verdict-copy PASS_ID.
Exact human stage/commit/push of accepted recorded scope material precedes
future M1 implementation authority.

## SELF_REFERENCE_AUDIT

This artifact and its ledger row state scope actions, verified predecessor
Git/evidence and conditional future gates. They contain no assertion of this
pass's own current staging or audit-pipeline position. Phase-1 neutral ledger
and empty-block conventions describe recording mechanics, not acceptance.
No independent result for this scope is fabricated.

## Independent audit verdict

<!-- MEASUREMENT_M1_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M1_EXTRACTION_SCOPE_LOCK_PASS.md

FINDINGS:
- NIT — post-M1 Code Map maintenance should classify the
  measurement_projection map drift using the Code Map Standard's actual
  drift classes, notably STRUCTURE_DRIFT for the new consumer and
  BOUNDARY_DRIFT where the old host-save ownership description becomes stale.
  No scope patch is required and this does not widen M1 authority.

<!-- MEASUREMENT_M1_SCOPE_VERDICT_END -->
