# TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS

## Pass identity

```text
PROJECT: TraceBench / BenchBeep
PASS_ID: TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / HUMAN_SELECTED_FAST_LANE
Date: 2026-08-28
Worktree: C:\dev\TraceBench
Branch: main
Baseline: b742a8e2cbfca7f53c0895365b63328008aa2f02
Parent: c3a44856009141a9956ba483267b8265e05c6950
Predecessor: TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS
Reserved child: TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child Windows manual smoke: REQUIRED
Pre-implementation scope audit: NOT_REQUIRED — explicit human fast-lane decision
Scope Phase 2: NOT_APPLICABLE
Post-implementation independent audit: REQUIRED after human smoke
```

## Outcome and authority boundary

The human selects Photo Alignment + Board Canvas V1 from the non-executable
`NEEDS_USER_DECISION` sentinel. This pass records one binding docs-only scope
and reserves exactly one implementation child. It does not implement alignment,
write an event, decode or transform a photo, edit a Code Map, or alter the
accepted Canonical Photo Import V1 implementation.

This is a protected Lane B product/writer reservation because the future child
adds an explicit human-confirmed canonical event path. The human expressly
chooses a pass-specific fast lane: this four-file scope needs neither a separate
pre-implementation Claude audit nor a Phase-2 verdict recording. That exception
does not amend the general audit protocol, waive the child manual smoke or
post-implementation audit, authorize Codex staging, or widen either allowlist.

After fresh validation, the human may stage, commit, and push only this exact
four-file scope. Only that exact committed/pushed scope activates the reserved
child.

## Live baseline

Verified before writing:

```text
HEAD: b742a8e2cbfca7f53c0895365b63328008aa2f02
origin/main: b742a8e2cbfca7f53c0895365b63328008aa2f02
Parent: c3a44856009141a9956ba483267b8265e05c6950
Subject: docs: close canonical photo import code maps
Divergence: 0 0
Staged paths: 0
Unmerged paths: 0
Code Maps / index rows: 50 / 50
MAINTAINED / REVIEW_REQUIRED / RETIRED: 48 / 0 / 2
```

The only short-status residue is the known content-clean generated Windows trio
plus untracked scratch `TraceBench_ALL_CODE.txt`:

- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`
- `TraceBench_ALL_CODE.txt`

Their substantive diff is empty and all four paths remain outside authority.
The predecessor Canonical Photo Import implementation and its accepted
committed-source Code Map maintenance are complete at this baseline.

## TOOL_SKILL_CHECK

```text
relevant skill/tool/helper found:
- .agents/skills/tracebench-scope-lock/SKILL.md
- docs/CODEX_TOOLING_POLICY.md and the three loader-qualified repo skills
- rg, git, tools/doctor.py, and tools/validate_all.py
- maintained PhotoEventWriter, PhotoWorkbenchPanel, Board Canvas,
  Board Canvas test, writer-test, PythonRunner, and ProjectSession maps
- accepted event schema, validator, materializer, Dart model, and generic
  Python canonical writer owners

capability actually used:
- tracebench-scope-lock separated the four current docs paths from the exact
  twelve-path future child and locked its route, boundaries, tests, and stops

why applicable:
- this pass is a docs-only reservation of one protected canonical writer plus
  deterministic visual-alignment/rendering implementation

external tool required: NO
```

`tracebench-prompt-authoring` is not used because this pass records binding
scope rather than authoring a standalone executor prompt.
`tracebench-audit-reconciliation` is not applicable because there is no pushed
pending artifact to reconcile. No external plugin, installer, download, or
network action is required or authorized.

## Exact current material set — 4 paths

This scope may write exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/audit/TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS.md`
   (new)

No fifth scope path is authorized. In particular, `docs/AUDIT_INDEX.md`, every
Code Map and `docs/code_maps/CODE_MAP_INDEX.md`, Dart/runtime/tests, Python
tools/tests, schemas, materializers, models, ProjectSession, packages, assets,
platform/generated substantive bytes, `_incoming`, and scratch are frozen.

This fast-lane artifact has no ledger row, no designated verdict block, and no
Phase-2 coordinates. Do not create any of them in this pass.

## Reserved child exact allowlist — 12 paths

`TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_IMPL_PASS` may write exactly:

1. `tools/validate_events_jsonl.py`
2. `tests/test_validate_events_jsonl.py`
3. `lib/features/photos/logic/photo_alignment_transform.dart` (new)
4. `lib/features/photos/logic/photo_event_read_model.dart`
5. `lib/features/photos/services/photo_event_writer.dart`
6. `lib/features/photos/widgets/photo_workbench_panel.dart`
7. `lib/features/board_canvas/rendering/aligned_photo_layer.dart` (new)
8. `lib/features/board_canvas/screens/board_canvas_screen.dart`
9. `test/unit/photo_alignment_transform_test.dart` (new)
10. `test/unit/photo_event_read_model_test.dart`
11. `test/unit/photo_event_writer_test.dart`
12. `test/widget/board_canvas_screen_test.dart`

No thirteenth implementation path is authorized. The child edits no docs or
Code Maps. If compilation, testing, safe rendering, or canonical writing needs
path 13, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked V1 user flow

Board Canvas remains the primary normal workflow. The future child implements:

```text
open Board Canvas -> Fotod
-> select one already accepted canonical photo_added item
-> choose board side and Similarity (default) or Affine (Advanced)
-> add corresponding photo-local / board-normalized point pairs
-> preview the aligned photo and residual directly on Board Canvas
-> explicitly Kinnita joondus
-> append exactly one accepted photo_to_board_alignment_confirmed event
-> ProjectSession.applyCanonicalEvent with captured generation
-> derive the accepted alignment from current events immediately
-> render it as the active Board Canvas reference layer
```

The photo source is an already canonical imported photo. Picker/import/copy/hash
behavior remains the accepted Canonical Photo Import V1 path and is not reopened.
The Wizard `wizard_background.*` file remains noncanonical unless it has already
been separately imported through `photo_added`; Wizard intake alone can never be
selected as a canonical alignment source.

The `Fotod` panel owns alignment editing. It lists accepted event-derived
photos, lets the human select the source photo, choose `top`, `bottom`, or
`unknown`, and add, remove, or reorder complete point pairs. A pair contains one
photo-local point selected on the intrinsic photo preview and one
board-normalized point captured on Board Canvas. Incomplete pairs never enter a
solver or writer.

`Similarity` is the default. `Affine` is available only behind an explicit
`Advanced` affordance. Switching transform type retains the ordered pair list,
revalidates it under the selected model, updates the preview when valid, and
writes nothing. Cancel discards only the UI-local draft and restores the last
confirmed event-derived layer, if any.

The preview is visibly provisional. It shows pair markers, transform type,
board side, board-normalized RMS residual, maximum residual, and validation
feedback. No preview, point click, transform switch, opacity/visibility change,
or cancel action writes canonical state.

## Deterministic transform contract

`photo_alignment_transform.dart` is a normal pure Dart library. Widget State
may own draft values and selection, but not transform math.

### Shared numeric rules

- All coordinates, intermediate values, coefficients, residuals, and outputs
  must be finite.
- Photo points use intrinsic image pixels and must be inside the inclusive
  image rectangle `0 <= x <= width`, `0 <= y <= height`, where width and height
  are finite and positive decoded intrinsic dimensions.
- Board points must be inside the inclusive normalized square `0..1` on both
  axes.
- Point arrays must have equal length and preserve pair identity.
- Duplicate or near-duplicate points are rejected in each coordinate space.
- Degeneracy checks are scale-aware: normalize each point set by its finite
  positive bounding-box diagonal and use one documented fixed relative epsilon
  of `1e-9`. Exact zeros and normalized magnitudes at or below that epsilon are
  degenerate.
- Extra pairs are allowed. Solving is deterministic least squares: the same
  finite pair set produces the same result, and pair reordering changes only
  floating-point noise within the focused test tolerance.
- Residuals are computed after mapping photo points into board-normalized space.
  The preview reports RMS and maximum Euclidean error in board-normalized units.
- No random sampling, RANSAC, heuristic point deletion, snapping, perspective
  term, or homography is allowed.

### Similarity

- Requires at least two complete pairs.
- Solves only rotation, one uniform strictly positive scale, and translation.
- Reflection, shear, and independent X/Y scale are not similarity outputs.
- Reject non-finite data, duplicate/near-duplicate points, zero/near-zero source
  spread, zero/near-zero board spread, or a solved scale at or below the shared
  epsilon.
- Overdetermined input uses the deterministic least-squares best fit and reports
  nonzero residual honestly.

### Affine

- Requires at least three complete pairs.
- Solves the full 2x3 affine map from photo-local pixels to board-normalized
  coordinates.
- Reject non-finite data, duplicate/near-duplicate points, collinear or
  rank-deficient source geometry, or a singular/near-singular solved linear
  2x2 block under the shared normalized epsilon contract.
- Shear is valid. A negative determinant is valid only when the draft preview
  shows a persistent visible mirrored-result warning before confirmation.
- The mirror warning is not electrical, damage, or fault evidence and does not
  block an otherwise valid explicit human confirmation.

Both transform types write the exact quality label
`manual_preview_confirmed`. There is no computed confidence, automatic quality
promotion, or alternate V1 quality vocabulary.

## Canonical event write contract

`photo_event_writer.dart` remains the sole Dart photo-event canonical adapter.
Its owner adds a public alignment-confirmation seam while preserving the frozen
photo-import contract. The API may use an alignment-specific interface or
compatible public request type inside the same file, but it must expose the
owner's `confirmAlignment` operation without adding a required member that
forces the frozen `photo_import_service.dart` or its frozen fake/test owner to
change.

Only the explicit `Kinnita joondus` action may invoke it. The operation:

- revalidates the exact accepted photo, board side, coordinate spaces, ordered
  complete pairs, transform type, deterministic solution, and fixed quality
  label;
- allocates the next unique positive V1 `sequence`, the next unique global
  `evt_[0-9]{6}` event ID, and the next unique `ALN[0-9]+` alignment ID from
  current live event history, keeping all three counters independent;
- creates exactly schema `1.0`, `actor.type: user`, `actor.id:
  local_operator`, `event_type: photo_to_board_alignment_confirmed`, and
  `status: accepted`;
- writes only `alignment_id`, `source_photo_id`, `board_side`,
  `coordinate_space_from: photo_local`, `coordinate_space_to:
  board_normalized`, ordered `reference_points_photo`, ordered
  `reference_points_board`, `transform_type`, and
  `alignment_quality_label: manual_preview_confirmed`;
- sends no transform matrix, residual, opacity, visibility, confidence,
  component, pin, net, measurement, damage, suspect, trace, or fault field;
- delegates validation/locked append to the unchanged generic
  `tools/event_writer_service.py` through the existing `PythonRunner`; and
- reads back the exact candidate and retains conservative durable / uncertain /
  proven-no-event classification.

One confirm activation is single-shot while in flight and can append at most
one candidate event. A writer error never creates a local substitute event.

## Validator hardening boundary

The child may harden only the existing
`photo_to_board_alignment_confirmed` runtime validation and its focused Python
tests. It must reject non-finite coordinates, unequal lengths, insufficient
pairs, duplicate/near-duplicate points, similarity zero/near-zero spread or
scale, affine source collinearity/rank deficiency, and affine singular/
near-singular solved output. Existing actor, source-photo ordering, ID,
coordinate-space, board-range, forbidden-field, and transform-enum rules remain.

The Python validator applies the same scale-normalized `1e-9` degeneracy
contract to payload geometry. Intrinsic image upper bounds remain a Dart
preview/writer guard because the canonical payload contains no intrinsic image
dimensions and the validator must not open image files or introduce an EXIF/
metadata pipeline.

`schemas/events.schema.json` remains intentionally unchanged even though the
runtime validator becomes stricter than its frozen structural schema. Do not
patch that known divergence in this child.

## Event-derived read and session contract

`photo_event_read_model.dart` expands its pure `ZERO_WRITE` derivation to pair
accepted canonical `photo_added` events with later accepted valid
`photo_to_board_alignment_confirmed` events. It does not read or synthesize
`knownFacts.photoToBoardAlignments`, mutate `ProjectState`, or materialize facts.

It accepts only schema-1.0, status-accepted, user-actor alignment events whose
source photo is a prior accepted safe photo event and whose payload passes the
same finite/type/count/space/range/degeneracy rules needed to solve. Malformed,
forward-referencing, unsupported, or unsafe events remain visible only in raw
history and are ignored for alignment rendering.

The active default is the valid accepted alignment with the greatest V1
`sequence`; V1 sequence uniqueness supplies deterministic tie-free ordering.
After reopen, both valid `similarity` and `affine` events are eligible. During
editing, a valid draft preview temporarily overrides the confirmed visual layer
without becoming event-derived state.

Confirmation captures `ProjectSession.generation` before awaiting the writer.
The exact returned event is applied only through the current
`ProjectSession.applyCanonicalEvent`. A stale generation never mutates the
newer session. The already durable event remains in the old project's log and
becomes visible when that project is reopened. An accepted application makes
projection freshness stale but the alignment immediately renders from current
events; it does not wait for Known Facts regeneration.

`ProjectSession`, `ProjectState`, `TraceBenchEvent`, Known Facts models,
materializer, and schema owners remain unchanged.

## Photo-file resolution and missing-file boundary

Alignment creates no new photo file. Rendering resolves only the selected
accepted `photo_added.path` below the current directory-backed project's real
root. The relative path must pass the existing safe photo-path rules; the final
resolved target must be a contained regular file after symlink/junction
resolution. Missing, unreadable, undecodable, escaping, ZIP-only, or bundled
photo bytes produce an honest nonblocking unavailable warning and no layer.

The source file, accepted imported copy, Wizard background, project directory,
and every unrelated file are immutable in this child. There is no rollback or
cleanup file deletion because alignment writes no new file.

## Board Canvas overlay and UI-local state

`aligned_photo_layer.dart` owns only clipped, pointer-ignored rendering of a
validated solved transform and injected/testable image presentation. It owns no
draft, provider, event, file mutation, schema, or canonical meaning.

Within the existing `_CanvasPanel` / `InteractiveViewer` board plane, the exact
bottom-to-top stack becomes:

1. opaque Board Canvas background and grid;
2. optional legacy Wizard background photo;
3. active canonical aligned photo (confirmed event or current valid draft);
4. Wizard contour and visual candidates;
5. alignment-edit photo/board reference markers;
6. canonical component placements;
7. measurement badges, placement ghosts, status, warnings, and controls.

The aligned layer is clipped to the Canvas board rectangle and wrapped in
`IgnorePointer`. It shares the Canvas `InteractiveViewer`, so pan, zoom, fit,
placement hit testing, and existing gestures remain host-owned and unchanged.
Photo-local points map through the solved transform into board-normalized
coordinates and then through the full current board rectangle.

The newest valid confirmed layer is visible by default at UI-local opacity
`0.65`. Visibility and opacity controls live in `Fotod`, range from `0.0..1.0`,
and are reset when project/session identity changes. They are never serialized,
placed in an event, written to `.tracebench_local`, or treated as confirmation.
Draft markers exist only while editing. Cancel removes them and restores the
confirmed layer. Confirmation clears the draft only after event application is
accepted for the captured generation.

Existing zero-component availability, wide `Fotod` rail entry, compact `Fotod`
action, focus mode, Board placement selection/hit testing, six local tools,
Wizard toggle/controls, and freshness banner remain usable.

## Evidence and product boundary

Alignment is geometric/visual evidence only. It does not confirm photo pixels,
component identity, type, value, designator, package, footprint, contacts,
pins, pads, board electrical side, traces, connections, nets, measurements,
damage, suspect state, diagnosis, fault, or repair outcome. Renderer/view code
writes nothing. AI may propose no canonical alignment and has no confirmation
action.

The child must not:

- implement homography, perspective correction, camera capture, EXIF handling,
  automatic point detection, AI confirmation, or automatic component creation;
- formalize or write `photo_reference_points_set` or `photo_layer_aligned`;
- author damage, suspect regions, visual traces, components, nets, or
  measurements;
- change schemas, materializer, KnownFacts/ProjectState/TraceBenchEvent,
  ProjectSession, photo import service, Wizard, ProjectCreator, ProjectLoader,
  Project ZIP tools/spec, packages, assets, routes, or platform files; or
- persist transform coefficients, residuals, visibility, opacity, active layer,
  draft order, or edit state outside the confirmed event's reference points and
  transform type.

## CODE_MAP_PREFLIGHT

All applicable existing maps and index rows are `MAINTAINED` at scope entry.
Source/tests and canonical owners remain authoritative.

| Child target | Entry map result | Changed responsibility zone | Coupled / excluded zones | Write class | Post-child disposition |
| --- | --- | --- | --- | --- | --- |
| `tools/validate_events_jsonl.py` | Python; outside Dart bootstrap | alignment validator numeric/degeneracy guards | schema and every other event family frozen | `ZERO_WRITE` validation | `NOT_APPLICABLE` |
| `tests/test_validate_events_jsonl.py` | Python; outside Dart bootstrap | focused alignment validator cases | other Python test families frozen | test-only | `NOT_APPLICABLE` |
| `photo_alignment_transform.dart` | new; no source/map to qualify | pure similarity/affine solve and residuals | no widget/provider/writer/file owner | `ZERO_WRITE` | committed-source qualification required |
| `photo_event_read_model.dart` | no map; accepted entry `SCORE 5/12` | accepted photo/alignment pairing and latest-valid selection | Known Facts/materializer/session frozen | `ZERO_WRITE` | entry `NOT_APPLICABLE`; requalify committed child source |
| `photo_event_writer.dart` | maintained writer map | public alignment request, envelope/ID allocation, append/readback | photo import contract and generic Python tool inspect-only | `CANONICAL_EVENT` | `UPDATE_REQUIRED` |
| `photo_workbench_panel.dart` | maintained panel map | alignment selection/draft/confirm/session/controls | picker/import flow preserved; Canvas host coupled | `UI_LOCAL` + delegated `CANONICAL_EVENT` / `PROJECTION_STATE` | `UPDATE_REQUIRED` |
| `aligned_photo_layer.dart` | new; no source/map to qualify | clipped pointer-ignored transformed image | no draft/file/writer/provider owner | `ZERO_WRITE` | committed-source qualification required |
| `board_canvas_screen.dart` | maintained Board Canvas map | event-derived active layer, board capture, markers, exact stack | placements/Wizard/focus/freshness/writers coupled and preserved | `UI_LOCAL` + `ZERO_WRITE` host | `UPDATE_REQUIRED` |
| `photo_alignment_transform_test.dart` | new; no source/map to qualify | pure solver/degeneracy/residual families | no widget/filesystem tests | test-only | committed-source qualification required |
| `photo_event_read_model_test.dart` | no map; accepted entry `SCORE 4/12` | accepted/rejected/latest/immediate-event derivation | session owner observed, not changed | test-only | entry `NOT_APPLICABLE`; requalify committed child source |
| `photo_event_writer_test.dart` | maintained writer-test map | exact alignment envelope/allocation/durability cases | real Python validator remains separate | exercised `CANONICAL_EVENT` | `UPDATE_REQUIRED` |
| `board_canvas_screen_test.dart` | maintained Board test map | alignment editor/overlay/session/stack/responsive families | real image/filesystem/writer persistence stays in focused owners/manual smoke | exercised UI/event/projection | `UPDATE_REQUIRED` |

Direct dependencies reviewed now:

- `docs/code_maps/lib/shared/services/python_runner.dart.md` is `MAINTAINED` but
  its exact `photo_added`-only caller description will become
  `UPDATE_REQUIRED` after the writer also dispatches confirmed alignment.
- ProjectSession, PhotoImportService, its unit suite, ProjectLoader,
  New Project Wizard, and ProjectCreator maps are `REVIEWED_NO_CHANGE` provided
  their source and interfaces remain frozen as locked.
- No current map is missing, stale, conflicting, or `REVIEW_REQUIRED`.
- The human explicitly authorizes the coherent multi-zone combination across
  photo read/write/panel, pure transform, Canvas render/capture, and their exact
  tests. `DECOMPOSE_REQUIRED` does not apply to this selected product slice.

Map maintenance is forbidden in scope and child. After accepted committed
implementation, requalify every changed/new Dart target from committed source,
refresh every actual `UPDATE_REQUIRED` map, and create a new map only when the
live Standard requires it. That later docs/maps pass receives its own exact
allowlist; no speculative map or PASS_ID is created now.

## Automated test contract

The child must add focused coverage for:

1. exact two-pair similarity and overdetermined noisy similarity;
2. exact three-pair affine, overdetermined affine, shear, and reflected affine;
3. deterministic pair reordering and residual/RMS/max-error output;
4. non-finite coordinates/dimensions/results, unequal pairs, insufficient
   counts, out-of-bounds photo/board points, duplicates/near-duplicates,
   zero/near-zero spread, affine collinearity/rank failure, and singular/
   near-singular affine output;
5. fixed positive similarity scale, no similarity reflection/shear, affine
   negative-determinant mirror flag, and no homography output;
6. accepted photo/alignment pairing, prior-photo requirement, malformed-event
   rejection, latest valid sequence default, and both transform types after
   reopen;
7. exact V1 alignment envelope, independent event/sequence/alignment IDs,
   fixed quality label, user actor, single-shot confirmation, exact readback,
   durable recovery, uncertainty, and proven-no-event failure;
8. add/remove/reorder point pairs, transform switching, board capture, valid
   draft preview, residual display, mirror warning, and cancel with zero write;
9. confirm producing exactly one event, captured-generation rejection after a
   project switch, no newer-session mutation, immediate event-derived rendering
   while projection freshness is stale, and newest-alignment default;
10. visible-by-default confirmed layer, UI-local opacity/visibility, clipping,
    pointer ignoring, missing/unsafe/unreadable photo warning, and no persistent
    view state;
11. exact seven-layer Canvas order, legacy Wizard coexistence, canonical
    placements above aligned/Wizard layers, edit markers below placements, and
    unchanged pan/zoom/fit/hit testing; and
12. wide and compact `Fotod`, zero-component Canvas usability, read-only
    non-directory behavior, and zero unrelated canonical writer calls.

Widget tests must use injected/testable image presentation rather than decode
real `Image.file` bytes. Pure transform tests own math; focused writer tests own
the fake process protocol; Python tests own runtime validator parity; human
Windows smoke owns real file decode and desktop pixels.

Required fresh commands include:

```text
py -3 -m unittest tests.test_validate_events_jsonl
flutter test test/unit/photo_alignment_transform_test.dart
flutter test test/unit/photo_event_read_model_test.dart
flutter test test/unit/photo_event_writer_test.dart
flutter test test/unit/photo_import_service_test.dart
flutter test test/unit/project_session_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter analyze --no-pub
flutter test
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Run Flutter commands sequentially. If a focused test hangs or stalls, stop
after at most two focused patch attempts; do not broaden scope or hide a failure
with an unbounded wait. Prove the exact twelve-path substantive material set,
empty staged/unmerged sets, no docs/maps/schema/model/materializer/ProjectSession/
Wizard/import-service/ZIP drift, and no unrelated alignment-writing symbol.

## Required human Windows smoke after implementation

Before the child post-implementation audit, a human must record:

1. similarity with two and extra pairs, live residual preview, confirm, and
   immediate layer;
2. affine Advanced mode including visible shear behavior;
3. reflected affine with the persistent mirror warning before confirmation;
4. cancel with zero new event and restoration of the confirmed layer;
5. one explicit confirm producing one event and projection-stale immediate
   rendering;
6. close/reopen rendering of valid confirmed similarity and affine events;
7. missing/renamed photo yielding a nonblocking warning and no broken Canvas;
8. wide Board Canvas `Fotod`, point capture, layer controls, pan/zoom/fit, and
   placements;
9. compact Board Canvas with the same usable flow and no overflow; and
10. switch project/session while confirm is in flight, proving the newer
    session is unchanged and the old durable event reappears only when its
    project is reopened.

Automated tests cannot be reported as human smoke. Do not claim smoke PASS
without the human observation.

## Route and activation

```text
TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_IMPL_PASS
-> committed-source Code Map refresh if required
-> NEEDS_USER_DECISION [non-executable]
```

No second product child is armed. The implementation child activates only
after exact human scope staging/commit/push. It requires its own automated
validation, human Windows smoke, independent implementation audit, and exact
human staging/commit/push. Any later Code Map maintenance describes only
accepted committed child source and returns to the sentinel.

## Scope validation contract

Run fresh for this docs-only scope:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Also prove exactly four material paths, no `AUDIT_INDEX` or Code Map/index
change, no runtime/test/tool/schema/model/materializer/ProjectSession/Wizard/
import-service/ZIP substantive diff, zero staged/unmerged paths, unchanged
Windows substantive residue, route agreement, and absence of any fifth scope
path.

## Stop conditions

Stop and return to the human if:

- baseline, branch, divergence, predecessor completion, route, registry, or
  maintained-map state differs;
- scope needs a fifth path or child needs path 13;
- a schema, materializer, model, ProjectSession, photo import service, Wizard,
  ProjectCreator/Loader, Project ZIP, package, asset, route, or platform change
  becomes necessary;
- the public writer change would force a frozen importer or importer-test edit;
- intrinsic photo bounds cannot be checked without adding image metadata to the
  canonical event or Python validator;
- finite/degeneracy/rank/singularity behavior cannot remain deterministic and
  parity-tested inside the exact Dart/Python owners;
- the Canvas layer cannot remain clipped, pointer-ignored, below Wizard geometry
  and canonical placements, or compatible with zero components;
- alignment would promote photo evidence into component/net/measurement/fault
  truth, formalize a deferred event, or introduce homography/AI confirmation;
- a relevant current map is stale, conflicting, `REVIEW_REQUIRED`, or
  unverifiable;
- automated validation or required human smoke fails; or
- staging, commit, push, reset, restore, stash, clean, install, download, or
  deletion outside an invocation-owned test fixture would be required by Codex.

Use the exact Code Map blocker vocabulary when applicable and
`BLOCKED_ALLOWLIST_MISMATCH` for path 13. Do not silently create another child,
map pass, compatibility patch, or Project ZIP/schema redesign.

## SELF_REFERENCE_AUDIT

- The touched artifact and three route owners are checked together.
- All four identify this scope as current and only the exact twelve-path child
  as the next executable pass after human commit/push.
- This artifact contains no verdict block and has no `AUDIT_INDEX` row because
  the human explicitly selected the pass-specific fast lane.
- The fast-lane statement is an exact current-pass authorization, not a claim
  that general Lane B audit policy has changed.
- Scope validation and staging readiness are reported only after fresh command
  evidence; child tests, smoke, audit, acceptance, commit, and push remain
  future gates.
- No touched file claims that the child implementation or smoke already passed.

