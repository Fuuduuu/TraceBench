# Board Canvas Measurement M0 Characterization Scope Lock

PASS_ID: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Lane: A
Mode: `DOCS_SCOPE_LOCK`

## Authority and purpose

The human approved gradual Board Canvas modularization with Measurement as
the first pilot. The first executable step is M0 characterization tests only;
production refactoring is excluded. `docs/POHIKIRI.md`, the three live route
owners, and this binding scope govern the reservation. Committed source and
tests outrank descriptive Code Maps.

Verified scope baseline: branch `main`, `HEAD == origin/main ==
6d379f3f5d6d58b334be44a627def8ebe60cb1ea`, subject
`docs: complete combined code map refresh`, divergence `0 / 0`.

Current: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_TEST_PASS`

The completed combined map refresh retains its historical evidence and spent
write authority. This scope reserves exactly one future executable pass.

## Current docs-only write authority

The current scope-lock material set is exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_SCOPE_LOCK_PASS.md`

No sixth path. Preserve all production, test, tool, schema, asset, package,
Code Map/index, historical-audit, platform, and scratch bytes. Preserve the
completed route-history bodies and all other ledger rows. Independent audit
uses `docs/AUDIT_CONTRACT.md` contract `scope-lock-post-audit`; the bounded
verdict-recording exception is defined below. Staging, commit, and push are
human operations requiring explicit authorization.

## Reserved future M0 authority and activation

Future PASS_ID:
`TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_TEST_PASS`

Exact future writable allowlist:

1. `test/widget/board_canvas_screen_test.dart`

Activation requires independent acceptance of this scope, recording of the
returned verdict under the audit contract, and the human's exact scope-doc
commit/push with aligned `HEAD` and `origin/main`. The future pass rechecks
live route and authority against that committed scope. No separate routine
active-lock sync is reserved or required by this sequence. The future test
reservation does not authorize test edits during this docs-only pass.

M0 adds characterization of current behavior in the existing Measurement
responsibility zone. Minimal helpers/fakes may be added or extended inside
that same test file only where required for these cases. Do not change common
harness behavior or independent test zones. Existing assertions remain intact.
No helper or test file outside the single allowed path.

BEFORE behavior == AFTER behavior. A characterization difficulty cannot
authorize production edits or an improvement to the characterized behavior.

## Source-verified ownership and bounded reading

In `lib/features/board_canvas/screens/board_canvas_screen.dart`,
`_IntegratedMeasurePanel` is already a `ConsumerStatefulWidget`.
`_IntegratedMeasurePanelState` owns draft values/units, selected target,
save-in-flight/status/error state, `_saveMeasurement`, invocation of
`v2SaveMeasurementWriterProvider`, captured ProjectSession generation, and
returned-event application. Future physical extraction therefore concerns a
library boundary, without authorizing state/writer ownership redesign here.
Host-State cleanup for component create/edit and placement belongs to later
decisions.

Inspect the maintained Board Canvas source map's Measurement entry zone and
the test map's Measurement zone first, then their exact symbols. Relevant
source symbols are `_IntegratedMeasurePanel`, `_IntegratedMeasurePanelState`,
`_saveBlockReason`, `_saveMeasurement`, `_measurementClientOperationIdFor`,
`_measurementFailureMessage`, `_preferredComponentLabel`, and the
`constraints.maxWidth >= 900` host branch. Relevant existing test anchors
include `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`,
`integrated Measure panel target selection and draft capture stay local`,
and `integrated Measure panel saves measurement only from explicit Salvesta`.
Read direct session/writer dependencies only to close a named case or conflict;
they remain inspect-only. Do not rediscover unrelated source/test zones.

## M0 characterization targets

Cover current behavior where practical; related cases may share fixtures or
test declarations. Equivalent evidence is preferred to one declaration per
bullet. Record any coverage limitation with its concrete UI/harness reason;
do not silently omit a target or alter production to expose it.

1. Typed writer failure presentation for `noProjectDirectory`,
   `invalidProjectDirectory`, `pythonUnavailable`, `lockConflict`,
   `validation`, and `append`, plus generic unexpected-exception copy.
   Distinguish the UI's pre-writer directory guard from a writer-thrown
   `noProjectDirectory` result with a directory-backed fixture.
2. `appended: false` displays the existing already-saved/projection-refresh
   status: `Mõõtmine oli juba salvestatud. Projektsioon vajab värskendamist.`
3. After successful save, the same form/value cannot issue another writer
   request while that panel State remains mounted.
4. During a pending save, `Salvestan...` appears and a second save action
   issues no second writer request.
5. Preserve save guards for missing project directory and no usable selected
   target/component where the current UI exposes those states.
6. A writer result completing after project/session replacement must not
   mutate the newer project; retain captured-generation application.
7. Closing/unmounting the panel mid-save still hands the returned event to
   the captured ProjectSession before the mounted check. Skip local UI status
   updates after unmount; do not suppress the canonical-event handoff.
8. Drafts survive selection changes while the same State remains mounted,
   and reset after leaving Measure mode/unmounting and re-entering.
9. Preserve current timestamped operation-ID pattern and normalized form-key
   content. Cover numeric versus text readings where behavior differs.
10. Preserve current header/selected-component copy with and without a
    designator. Distinguish the header's selector label from the preferred
    component label used in the selected-component presentation.
11. Characterize panel absence immediately below the existing 900
    **content-width** threshold. Do not substitute window width or change
    the threshold; the narrow Measure Sheet route stays available unchanged.

## Critical behavior freeze

- Keep the existing State lifetime: no new widget key, provider, or lifetime
  owner. Draft dictionaries persist across selection changes and reset on
  panel remount.
- Keep save order exactly: read session and capture generation -> await
  writer -> `applyCanonicalEvent(event, generation)` -> mounted check ->
  local UI status update. The `applyCanonicalEvent` return value stays ignored.
- Keep `projectStateProvider ?? widget.projectState` fallback unchanged.
- Keep `_saveBlockReason` order: component, target, existing-value row, blank
  value, blank unit, successful-form repeat, then missing directory.
- Keep all current user-visible copy, including typed/generic failures,
  guards, header/selection labels, and success/projection-refresh status.
- Keep `_readingValue` as `num.tryParse(rawValue) ?? rawValue` and retain the
  current form key `[row.target, unitLabel.trim(), trimmedValue,
  'human_entered'].join('|')`.
- Keep operation IDs as `op_board_canvas_measurement_${safeKey}_$timestamp`:
  current non-alphanumeric normalization to `_`, repeated-underscore collapse,
  edge-underscore removal, and UTC microsecond timestamp. Characterize the
  pattern without changing timestamp behavior or normalizing it differently.
- Keep the 900 content-width host branch and narrow-screen Measure Sheet
  navigation. Do not share a save helper with Measure Sheet.
- Do not retarget, weaken, delete, or move ownership of existing static source
  checks. Their retarget belongs to later physical module extraction.

## Maps, zone boundary, and disposition

The registry identifies both relevant maps as `MAINTAINED` and usable for
SNIPER navigation:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
  zone 4, Measurement entry: `_IntegratedMeasurePanelState`,
  `_saveMeasurement`, `_MeasureTargetRow`, `applyCanonicalEvent`.
- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
  zone 4, Measurement: draft/target/save/session UI and pure Measurement read
  contracts, including `_FakeSaveMeasurementWriter`,
  `_measurementRecordedEventJson`, `measurementValueBadgesByComponents`,
  `measurementValueBadgeText`, and `measurementValidityNeedsCaution`.

Current scope disposition for both inspected maps: `REVIEWED_NO_CHANGE`.
Changed Dart/test responsibility zones in this docs pass: none. Both maps,
all other maps, and `CODE_MAP_INDEX.md` remain byte-frozen in scope and M0.

Future M0 must re-evaluate map disposition after the accepted test diff.
If added characterization materially changes mapped test evidence, route to
separately scoped committed-source map maintenance; otherwise no map edit is
required. Do not predeclare `UPDATE_REQUIRED` solely because declaration
count increases. This reservation names no new maintenance PASS_ID.

M0 stays within the existing Measurement behavior zone. No
`DECOMPOSE_REQUIRED` override is needed. If work requires a second independent
zone, stop with `DECOMPOSE_REQUIRED`; do not expand this allowlist.

## Inspect-only surfaces, exclusions, and stops

All paths other than the future single test file are frozen during M0,
including the Board Canvas source, ProjectSession, V2 measurement writer,
Measure Sheet, all static-check owners, maps/index, other tests, tools,
schemas, assets, packages, platform files, and scratch/residue. Inside the
allowed file, independent zones and existing static source checks are frozen.

No widget/class move, new module, provider/controller/repository, projection
optimization, responsive/copy/painter/rendering change, canonical writer or
operation-ID change, or new product functionality. Protected event/evidence,
graph, validity, repair/conflict, device fallback, and Project ZIP contracts
remain unchanged. No `sequence` addition to V2 events.

Stop on baseline/route/authority disagreement, unexpected staged/unmerged
state, any required nonallowlisted edit, protected-semantic change, stale or
conflicting required map, a second independent zone, or validation failure
outside the authorized scope. Preserve Windows generated-plugin residue and
all known scratch without staging or cleanup.

## Later work: non-authorizing directions only

- L1: minimal shared read-only presentation seam required by Measurement and
  Inspector.
- M1: physical extraction to a normal library such as
  `widgets/integrated_measure_panel.dart`.
- M2: Measurement read-model performance, including the previously identified
  bulk O(componentIds × measurements) candidate.

Component create/edit, Inspector, and Placement follow only through later
human decisions. None of L1, M1, M2, or those areas is armed. Only the exact
M0 child is reserved.

## Validation and acceptance contracts

For this docs scope: verify baseline/divergence, staged/unmerged emptiness,
the exact five-path material set, matching routes in all three owners,
artifact/ledger agreement, the single future test path, preserved history and
frozen bytes, `git diff --check`, `git diff --cached --check`, and
`py -3 tools/doctor.py`. `docs/PROMPTING_PROTOCOL.md` requires `validate_all`
for docs-only passes; run its fixture outputs in temporary storage to preserve
asset bytes. No Flutter test implementation or product smoke is required by
this docs reservation.

Future M0 validation commands:

```text
dart format test/widget/board_canvas_screen_test.dart
flutter analyze
flutter test test/widget/board_canvas_screen_test.dart
flutter test
py -3 tools/doctor.py
git diff --check
git diff --cached --check
git diff --name-only
git status --short --branch
```

Also run `tools/validate_all.py` using the temporary-output invocation below,
prove the exact one-test-file diff, empty staged/unmerged state, frozen
source/maps/static checks and unrelated test zones, and report coverage of
the eleven targets. Acceptance requires current behavior evidence with no
production change. `AUTOMATED_ONLY_OK`: manual smoke is `NOT_APPLICABLE` for
the reserved test-only pass with unchanged runtime. Independent audit of the
M0 test diff and exact human commit/push remain required; automated checks do
not substitute for audit or authorize a later extraction.

Temporary-output validation invocation, from repository root in PowerShell:

```powershell
@'
import runpy, tempfile
from pathlib import Path
namespace = runpy.run_path('tools/validate_all.py', run_name='m0_scope_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-m0-validation-') as temporary:
    for fixture in namespace['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(namespace['main']())
'@ | py -3 -X utf8 -B -
```

## TOOL_SKILL_CHECK

- Relevant capability: repo-local `tracebench-scope-lock`, inventoried by
  `docs/CODEX_TOOLING_POLICY.md`; used for docs-only reservation and separation
  of current authority from the future allowlist.
- `tracebench-prompt-authoring` used for the canonical audit handoff.
  `tracebench-audit-reconciliation` is not applicable: this is a new scope,
  not reconciliation of a pushed pass's evidence.
- Existing helpers used: Git, PowerShell/Python byte-preservation checks,
  `tools/doctor.py`, and temporary-output `tools/validate_all.py`.
- External tool required: NO. No helper, fixture, or script edit is authorized.

## Independent audit and bounded verdict recording

Review the complete five-doc Phase 1 diff under `scope-lock-post-audit`,
excluding only the empty designated block below. Return `AUDIT_VERDICT`,
`SAFE_FOR_STAGING`, and exact `SAFE_STAGING_SET` under the canonical contract.

After the independent result, the only Phase 2 exception is:

1. Insert the returned verdict/safety/exact-set recording between
   `MEASUREMENT_M0_SCOPE_VERDICT_BEGIN` and
   `MEASUREMENT_M0_SCOPE_VERDICT_END` in this artifact.
2. Mechanically mirror that same verdict, safety result, and exact set in the
   Status cell of this PASS_ID's existing `docs/AUDIT_INDEX.md` row.

Freeze every other Phase 1 byte, including both marker lines, all route
owners, ledger descriptions/other rows, and all frozen repository surfaces.
Prove the bounded Phase 1-to-Phase 2 delta and matching records with no
material-set expansion. This conditional exception does not authorize
recording a fabricated verdict or any other patch. Other changes require
independent re-audit; no new verdict-copy PASS_ID is created.

<!-- MEASUREMENT_M0_SCOPE_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_M0_CHARACTERIZATION_SCOPE_LOCK_PASS.md

<!-- MEASUREMENT_M0_SCOPE_VERDICT_END -->
