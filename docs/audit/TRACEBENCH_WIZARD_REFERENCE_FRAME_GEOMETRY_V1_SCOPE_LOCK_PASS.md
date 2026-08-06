# TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS

```text
PASS_ID: TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / SCOPE_LOCK / ZERO_RUNTIME_WRITE
```

## Entry and human route decision

The verified entry is the isolated worktree
`C:\Users\Kasutaja\Desktop\TraceBench-board-canvas-intake-detour` on branch
`fix/board-canvas-wizard-intake-empty-components-gate` at
`HEAD == origin/main == 33e3a522a7f91157ed40c39cc46cd692360bc93b`,
subject `docs: lock Board Canvas Wizard intake gate scope`, divergence `0 0`.

The human route decision replaces the incomplete gate-only continuation with
one protected reference-frame geometry cycle. The existing Board Canvas gate
and z-order work is valid carried work, but its human smoke exposed a deeper
geometry defect. It is preserved without a separate audit, staging action, or
discard operation and becomes part of the future complete implementation
diff.

## Reproduced cause and classification

The locked causal fact is:

```text
Wizard Step 3 and Step 4 store x / editorWidth and y / editorHeight.
Board Canvas later applies one scalar to both normalized axes as if the source
frame were square. The Wizard editor aspect ratio is not persisted, so the
original rectangular authoring frame cannot be reconstructed.
```

The required classification is:

```text
B. CANVAS_NORMALIZED_ASPECT_IS_WRONG
```

The diagnostic project proves the consequence numerically: its persisted
normalized contour bounds have width `0.6317848411`, height `0.7962616822`,
and square-frame aspect `0.7934387089`; the original `818 x 428` authoring
frame has aspect `1.9112149533`, making the expected contour approximately
`516.8 x 340.8`, aspect `1.5164319249`. The landscape photo is `1021 x 682`,
aspect `1.4970674487`. The photo, contour, and candidates agree in the Wizard
authoring plane; Canvas loses only that plane's aspect.

## Exact current SCOPE write allowlist

This docs-only SCOPE changes exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS.md`

No sixth current-pass path is authorized. All Dart, tests, maps,
`docs/code_maps/CODE_MAP_INDEX.md`, `docs/UI_WORKFLOWS.md`,
`docs/PROJECT_ZIP_SPEC.md`, schemas, tools, assets, packages, `_incoming`,
scratch, generated projects, and every other worktree are read-only. Do not
stage, commit, push, reset, restore, stash, clean, delete, or install.

## Frozen carried work and preservation anchors

The pre-existing target-worktree diff remains exactly:

1. `lib/features/board_canvas/screens/board_canvas_screen.dart`
2. `test/widget/board_canvas_screen_test.dart`

Its `git diff --binary -- <both paths> | git hash-object --stdin` result is
`131464241a1de9bdcbafcba023f5ba2493ff0f4e`. Worktree-byte SHA-256 values from
`Get-FileHash -Algorithm SHA256 -LiteralPath <path>` are:

- Board Canvas source:
  `E9BA5081DD2EBE29D0A0338AE07AB57B394F1CDCBA77D8E79E39D02087007577`;
- Board Canvas test:
  `5BE4DD7F40BA3EFD5DAFF43853B09608796689EED533CBC2E271A6E7B3528F73`.

The original compact Child 2 worktree remains inspect-only. Its substantive
diff is exactly:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`

Its `git diff --binary -- <both paths> | git hash-object --stdin` result is
`a3180b6f93832061ded7497f88de3616c126e2c9`. Worktree-byte SHA-256 values are:

- Wizard source:
  `3E759B8EB5822ADD72205B327BFB0AA15921F67AE3AA8B1B6B2F16592A8FDB4E`;
- Wizard test:
  `D58E8EE3294BDC38B55E42672CA58E241F06B1B3DA271A52378393536F6BF8C1`.

The recovery-patch worktree bytes at
`C:\Users\Kasutaja\Desktop\TraceBench-child2-before-board-canvas-intake-detour.patch`
have SHA-256
`73FFC9112B1D366BCFF7167AF2852568299A7E1EFB1BCC38C3A2F8159223C221`.

## Locked route

```text
TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_PASS
-> TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS
-> TRACEBENCH_WIZARD_COMPACT_SHELL_WORKSPACES_AND_REVIEW_V1_PASS
-> TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

The implementation activates only after independent acceptance of this exact
SCOPE and exact human staging, commit, and push. The final reference-frame
LOCK requires accepted committed implementation, fresh human manual smoke,
independent implementation audit, exact validation evidence, and map refresh
from accepted committed source. Only that LOCK may resume compact Child 2.

## Exact future implementation allowlist

`TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_PASS` may write only:

1. `lib/shared/models/wizard_intake.dart`
2. `lib/features/project/screens/new_project_wizard_screen.dart`
3. `lib/shared/services/project_creator.dart`
4. `lib/shared/services/project_loader.dart`
5. `lib/features/board_canvas/screens/board_canvas_screen.dart`
6. `test/unit/wizard_intake_test.dart`
7. `test/widget/new_project_wizard_screen_test.dart`
8. `test/unit/project_creator_test.dart`
9. `test/unit/project_loader_zip_test.dart`
10. `test/widget/board_canvas_screen_test.dart`
11. `tests/test_project_zip.py`

No twelfth implementation path is authorized.

### Live ownership proof

| Requirement | Exact owner | Why no adjacent owner is needed |
| --- | --- | --- |
| additive typed aspect metadata and deterministic JSON | `lib/shared/models/wizard_intake.dart` | no separate Wizard-intake schema file exists; manifest and `ProjectState` shapes do not change |
| Step 3 reference capture, shared Step 3/4 fitted rectangle, request mapping | `lib/features/project/screens/new_project_wizard_screen.dart` | the parent screen already owns both editors, their normalized gestures/painters, retained draft, and `WizardIntake` construction |
| deterministic generated-project copy/write | `lib/shared/services/project_creator.dart` | `_copyIntakeWithPhoto` is the only manual intake copy that would otherwise drop the field |
| directory/ZIP compatibility warning | `lib/shared/services/project_loader.dart` | `_WizardIntakeLoadResult` already carries intake and warning together; `ProjectState` already owns nullable intake/warning fields |
| rectangular read-only Canvas mapping | `lib/features/board_canvas/screens/board_canvas_screen.dart` | `_WizardIntakeFitTransform`, photo layer, painter, gate, and z-order are already private to this file |
| Project ZIP byte preservation | `tests/test_project_zip.py` only | export/import tools already copy non-excluded files opaquely; no exporter, importer, validator, or `ProjectExporter` production change is required |

`lib/features/project/widgets/new_project_wizard_photo_editor.dart` stays
read-only. Step 2 continues to own its optional photo-only transform editor;
the required persistent reference plane is established in Step 3, where the
photo and contour are actually overlaid, and Step 4 reuses that same plane.

## Exact reference-frame and JSON contract

The future model adds one optional, additive top-level JSON field:

```json
"reference_frame_aspect_ratio": 1.9112149533
```

The typed property is nullable for compatibility and represents
`referenceWidth / referenceHeight`. When present it must be a finite JSON
number greater than zero. `schema_version` remains exactly `1.0` and
`coordinate_space` remains exactly `wizard_normalized`. Existing tolerated
unknown-field behavior remains unchanged.

New Wizard-created intake must always write a non-null value. Deterministic
serialization includes the field immediately after `coordinate_space`.
Legacy typed intake with the field absent retains `null` and omits the field
when serialized; it is never silently backfilled or inferred.

## Shared Wizard fitted-reference contract

- Before the first accepted Step 3 contour interaction, the provisional
  reference rectangle is the current Step 3 inner canvas.
- The first accepted Step 3 contour interaction latches that inner canvas's
  finite positive aspect ratio for the retained draft.
- Once latched, the ratio does not change on navigation, responsive resize,
  photo replacement/removal, contour reset, or Step 4 edits.
- Step 3 and Step 4 each center-fit one rectangle of that ratio inside their
  available canvas. Letterbox space remains display-only and does not clamp or
  create contour points/candidates.
- Photo presentation, contour input/paint, candidate input/paint, hit testing,
  and drag mapping all use the fitted rectangle's local size and origin.
- Step 4 consumes the Step 3 reference and cannot create a second coordinate
  plane. Contour and candidates remain in one shared normalized space.
- The creation request persists the latched ratio without rounding or
  replacing it with photo dimensions, contour bounds, viewport dimensions, or
  a fixed design ratio.

## Rectangular Canvas mapping contract

For a valid ratio `a`, the Canvas reference plane is `Size(a, 1)`:

```text
referencePoint(x, y) = (x * a, y)
mappedPoint(x, y) = offset + referencePoint(x, y) * uniformScale
referenceRect = Rect(offset.x, offset.y, a * uniformScale, uniformScale)
```

Contour min/max fitting is computed after conversion to reference-plane
units. One uniform scalar still fits the converted contour into the existing
available Canvas area and padding. The optional photo uses `referenceRect`;
the contour and every candidate use the same `mappedPoint`; canonical
placements remain above all Wizard/photo layers.

The carried gate and z-order behavior is preserved:

1. opaque board background and grid;
2. optional Wizard photo;
3. Wizard contour and candidates;
4. canonical component placements;
5. UI controls above the canvas.

All Wizard layers stay `IgnorePointer`/read-only on Board Canvas. Pan, zoom,
fit, selection, hit testing, canonical placement rendering, and all existing
writers remain unchanged.

## Legacy, warning, and migration boundary

Missing `reference_frame_aspect_ratio` is a valid legacy intake, not an
invalid project and not grounds to suppress the intake. `ProjectLoader`
returns the typed intake together with this explicit compatibility warning:

```text
Selle projekti Wizardi aluskaadri kuvasuhe puudub. Kasutatakse
legacy-ruutkaadrit; foto, kontuuri ja kandidaatide täpset joondust ei saa
kinnitada. Täpne joondus nõuab migratsiooni või projekti uuesti loomist.
```

Canvas uses the explicit legacy fallback ratio `1.0` and surfaces that
warning. It must not infer aspect from photo pixels, contour/candidate bounds,
current viewport, manifest metadata, or any other heuristic. A missing intake
file remains valid and warning-free. A present invalid aspect follows the
existing invalid-intake warning path.

This implementation performs no legacy-file rewrite and provides no migration
tool or automatic recreation. Old projects are not claimed to be exactly
aligned. Exact alignment requires either a separately scoped migration that
obtains trustworthy reference-frame evidence or recreation through the
updated Wizard.

## Required TDD and exact focused tests

The implementation begins with genuine pre-repair failures and records their
test names/output before production edits:

1. `test/unit/wizard_intake_test.dart`
   - present aspect parses, validates, and serializes deterministically;
   - missing aspect remains nullable and omitted on reserialization;
   - zero, negative, non-number, and non-finite-compatible invalid values fail
     at `$.reference_frame_aspect_ratio`.
2. `test/widget/new_project_wizard_screen_test.dart`
   - Step 3 latches its actual authoring aspect;
   - Step 3 and Step 4 expose the same centered fitted reference bounds after
     a responsive-size change;
   - photo, contour, candidates, taps, drags, and hit testing share those
     bounds; letterbox taps are inert;
   - the creation request carries the exact ratio.
3. `test/unit/project_creator_test.dart`
   - no-photo and copied-photo creation both preserve the ratio in
     `notes/wizard_intake.json` and hydrated directory state.
4. `test/unit/project_loader_zip_test.dart`
   - directory and exact/root-prefixed ZIP loads preserve a present ratio
     without a compatibility warning;
   - missing metadata retains intake plus the exact legacy warning;
   - absent intake remains null and warning-free; invalid present metadata
     retains the existing invalid-intake behavior.
5. `test/widget/board_canvas_screen_test.dart`
   - a known landscape reference frame is portrait under the current square
     mapping RED and landscape after the rectangular mapping GREEN;
   - contour/photo/candidate composite pixels and candidate centers use one
     rectangular transform;
   - legacy fallback and warning are visible;
   - gate, z-order, hidden-photo default, canonical placement visibility,
     pan/zoom/fit, selection, hit testing, read-only candidates, and zero
     writer/canonical mutation remain green.
6. `tests/test_project_zip.py`
   - supported export -> validate -> import preserves the exact
     `notes/wizard_intake.json` bytes containing
     `reference_frame_aspect_ratio`.

All Flutter commands run sequentially. A compile-only failure is not enough
for the Canvas or Wizard RED; each must demonstrate the current wrong geometry
or independent full-canvas mapping before its production correction.

## Future implementation validation

```text
dart format --output=none --set-exit-if-changed <all ten modified Dart files>
flutter analyze <all ten modified Dart files>
flutter test test/unit/wizard_intake_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test test/unit/project_creator_test.dart test/unit/project_loader_zip_test.dart
flutter test test/widget/board_canvas_screen_test.dart
py -3 -m unittest tests.test_project_zip
flutter test
py -3 tools\doctor.py
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git status --short --branch
git diff --name-status
git diff --cached --name-status
```

Fresh human manual smoke is required after GREEN and before independent
implementation audit. It must cover Wizard Step 3/4 frame stability at wide
and compact widths; generated JSON; directory and ZIP reopen; landscape
contour/photo/candidate alignment; hidden/default and visible photo states;
zero-component Canvas reachability; canonical placements above Wizard layers;
pan/zoom/fit; legacy warning/fallback; no-intake parity; read-only candidates;
and zero canonical event/fact creation. The prior failed smoke is not reused.
The implementation audit packet must say `USE ONLY AFTER MANUAL SMOKE PASS`.

## CODE_MAP_PREFLIGHT

The index and each applicable `MAINTAINED` map agree with committed source.
The human decision expressly authorizes the combined multi-zone change.

| Target | Changed zone | Write class | Disposition after accepted implementation |
| --- | --- | --- | --- |
| Wizard screen | retained draft, editor geometry, typed request construction | `UI_LOCAL` + `ZERO_WRITE` | `UPDATE_REQUIRED` |
| ProjectCreator | Wizard intake serialization/copy | `NONCANONICAL_FILE` | `UPDATE_REQUIRED` |
| ProjectLoader | input-path and Wizard-intake compatibility warning | `ZERO_WRITE` | `UPDATE_REQUIRED` |
| Board Canvas | Wizard fit/photo/painter presentation only | `ZERO_WRITE` | `UPDATE_REQUIRED` |
| Wizard screen test | contour/candidate/photo geometry and request mapping | test-local | `UPDATE_REQUIRED` |
| ProjectCreator test | intake fixture, persistence, hydration | test-local | `UPDATE_REQUIRED` |
| Board Canvas test | Wizard fit, composite, geometry, and protected boundary | test-local | `UPDATE_REQUIRED` |

The cohesive `wizard_intake.dart` model and its focused unit test retain the
accepted Standard exclusion and are `NOT_APPLICABLE`; the focused
`project_loader_zip_test.dart` remains non-qualifying; Python tests are outside
bootstrap v1. The maintained photo-editor map is `REVIEWED_NO_CHANGE`.

## Exact final LOCK reservation

After accepted, manually smoked, independently audited, committed and pushed
implementation, `TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS`
may write exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/UI_WORKFLOWS.md`
6. `docs/PROJECT_ZIP_SPEC.md`
7. `docs/code_maps/CODE_MAP_INDEX.md`
8. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
9. `docs/code_maps/lib/shared/services/project_creator.dart.md`
10. `docs/code_maps/lib/shared/services/project_loader.dart.md`
11. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
12. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
13. `docs/code_maps/test/unit/project_creator_test.dart.md`
14. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
15. `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS.md`

No sixteenth LOCK path is reserved. The LOCK records only accepted committed
behavior/evidence, updates the two exact canonical docs, refreshes the seven
qualified maps from committed source, and resumes compact Child 2 without
editing its suspended runtime/test bytes.

## Stops and protected boundaries

Stop if a twelfth implementation file is needed; Step 3 and Step 4 cannot use
one persisted reference frame; the model requires a manifest/schema-version or
`ProjectState` shape change; ZIP preservation needs exporter/importer/
validator/tool production edits; legacy behavior requires inference or file
mutation; the Canvas fix touches canonical coordinate, placement, writer,
event, fact, materializer, projection, measurement, net, electrical, identity,
AI/OCR/CV, repair, app, provider, router, package, asset, or `_incoming`
behavior; a required map is stale/conflicting; either frozen worktree changes
during this SCOPE; the recovery patch hash changes; staged content appears; or
validation fails.

## TOOL_SKILL_CHECK

- relevant repo-local capability: `tracebench-scope-lock`;
- capability used: baseline/route verification, exact future allowlist proof,
  protected-boundary reservation, and audit handoff construction;
- why applicable: this pass reserves a future exact implementation without
  authorizing current runtime work;
- external tool required: `NO`; plugins/MCP/installers remain off.

## Bounded verdict recording

Independent Phase 1 audit may authorize Phase 2 to write only:

1. the empty interior between the two named markers below; and
2. the Status cell of this pass's unique row in `docs/AUDIT_INDEX.md`.

The ledger Status must mechanically mirror the complete returned verdict
payload. Both markers, artifact bytes outside the interior, the ledger
PASS_ID/File/Description cells, every other ledger row, route owners,
allowlists, contracts, frozen runtime/test bytes, maps, tools, specs, scratch,
and all other worktrees remain fixed.

The independent result must report at least:

```text
SCOPE_RESULT: PASS / FAIL
CAUSAL_RESULT: PASS / FAIL
PRESERVATION_RESULT: PASS / FAIL
ALLOWLIST_RESULT: PASS / FAIL
REFERENCE_FRAME_CONTRACT_RESULT: PASS / FAIL
LEGACY_CONTRACT_RESULT: PASS / FAIL
MIGRATION_BOUNDARY_RESULT: PASS / FAIL
ZIP_ROUND_TRIP_RESULT: PASS / FAIL
TDD_CONTRACT_RESULT: PASS / FAIL
CODE_MAP_PREFLIGHT_RESULT: PASS / FAIL
FINAL_LOCK_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
TOOL_SKILL_CHECK: PASS / FAIL
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES / NO
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact paths or NONE
```

<!-- TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

SCOPE_RESULT: PASS
CAUSAL_RESULT: PASS
PRESERVATION_RESULT: PASS
ALLOWLIST_RESULT: PASS
REFERENCE_FRAME_CONTRACT_RESULT: PASS
LEGACY_CONTRACT_RESULT: PASS
MIGRATION_BOUNDARY_RESULT: PASS
ZIP_ROUND_TRIP_RESULT: PASS
TDD_CONTRACT_RESULT: PASS
CODE_MAP_PREFLIGHT_RESULT: PASS
FINAL_LOCK_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS.md

FINDINGS:

NIT-1:
The diagnostic source project is prj_12b1059f.
Do not patch the SCOPE during Phase 2; carry it to implementation or final LOCK.

NIT-2:
NewProjectWizardPhotoLayer is hosted in the read-only photo-editor file but
must be constrained from the parent Wizard screen. Do not widen the future
implementation allowlist to modify that widget file.

NIT-3:
Step 2 photo preview may remain visually different from the latched Step 3/4
reference frame when their aspect ratios differ. Do not patch the SCOPE.
The implementation prompt must state the chosen Step 2 parity behavior
explicitly before implementation starts.

VALIDATION_WARNING_OBSERVATION:
`py -3 tools\validate_all.py` passes with pre-existing optional-photo
sample-fixture warnings. They are non-blocking.
<!-- TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT rule

Check all five touched files mechanically. No touched artifact, ledger cell,
or route owner may assert this pass's own current staging, commit, push, or
audit-pipeline position. Conditional future activation gates and verifiable
entry Git facts are permitted; generic policy examples must remain distinct
from claims about this pass.
