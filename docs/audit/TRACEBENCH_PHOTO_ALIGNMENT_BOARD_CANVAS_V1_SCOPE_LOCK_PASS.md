# TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS

## Pass identity

```text
PROJECT: TraceBench / BenchBeep
PASS_ID: TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / HUMAN_SELECTED_FAST_LANE
Original scope date: 2026-08-28
Primary-photo amendment date: 2026-08-29
Worktree: C:\dev\TraceBench
Branch: main
Original scope baseline: b742a8e2cbfca7f53c0895365b63328008aa2f02
Original scope parent: c3a44856009141a9956ba483267b8265e05c6950
Amendment baseline: 56ce35f284dcfc124c8f05be933974c6754b6dfb
Amendment parent: b742a8e2cbfca7f53c0895365b63328008aa2f02
Amendment mode: SCOPE_LOCK / DOCS_ONLY / PRIMARY_PHOTO_AMENDMENT
Predecessor: committed original Photo Alignment scope at amendment baseline
Reserved child: TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_IMPL_PASS
Scope manual smoke: NOT_APPLICABLE
Child Windows manual smoke: REQUIRED
Original pre-implementation scope audit: NOT_REQUIRED — explicit human fast-lane decision
Amendment independent audit: REQUIRED
Scope Phase 2: NOT_APPLICABLE
Post-implementation independent audit: REQUIRED after human smoke
```

## Outcome and authority boundary

The original pass selected Photo Alignment + Board Canvas V1 from the
non-executable `NEEDS_USER_DECISION` sentinel and reserved exactly one
implementation child. This human-approved amendment replaces only the child's
primary-photo and conditional canonical-handoff contract. It does not implement
alignment, write an event, decode or transform a photo, edit a Code Map, or
alter the accepted Canonical Photo Import V1 implementation.

This remains a protected Lane B product/writer reservation. The original
four-file scope used the recorded pass-specific fast lane; this protected
canonical-write amendment requires independent read-only audit but creates no
`AUDIT_INDEX` row, verdict block, or Phase-2 recording. It does not waive child
manual smoke or post-implementation audit, authorize Codex staging, or widen
either allowlist.

After fresh validation and accepted independent amendment audit, the human may
stage, commit, and push only this exact four-file amendment. Only that exact
committed/pushed amendment authorizes resumed work on the preserved child.

## Live baseline

Verified before amendment writing:

```text
HEAD: 56ce35f284dcfc124c8f05be933974c6754b6dfb
origin/main: 56ce35f284dcfc124c8f05be933974c6754b6dfb
Parent: b742a8e2cbfca7f53c0895365b63328008aa2f02
Subject: docs: scope photo alignment board canvas v1
Divergence: 0 0
Staged paths: 0
Unmerged paths: 0
Code Maps / index rows: 50 / 50
MAINTAINED / REVIEW_REQUIRED / RETIRED: 48 / 0 / 2
```

At amendment entry, short status contains the exact existing twelve-path Photo
Alignment implementation material, the known content-clean generated Windows
trio, and untracked scratch `TraceBench_ALL_CODE.txt`. The twelve implementation
paths are the reserved child allowlist below and are byte-frozen during this
docs-only amendment. The other four residue paths are:

- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`
- `TraceBench_ALL_CODE.txt`

The Windows trio's substantive diff is empty and all four residue paths remain
outside authority. The original scope commit is the amendment baseline; the
accepted Canonical Photo Import implementation and its committed-source Code
Map maintenance remain complete and unchanged.

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
- tracebench-scope-lock separated the four amendment docs from the byte-frozen
  twelve-path child and reconciled its primary-photo writer contract, tests,
  route, and stops

why applicable:
- this is a docs-only amendment of an existing protected canonical writer and
  deterministic visual-alignment/rendering reservation

external tool required: NO
```

`tracebench-prompt-authoring` is not used because this pass records binding
scope rather than authoring a standalone executor prompt.
`tracebench-audit-reconciliation` is not applicable because there is no pushed
pending artifact to reconcile. No external plugin, installer, download, or
network action is required or authorized.

## Exact current material set — 4 paths

This amendment may write exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/audit/TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS.md`

No fifth scope path is authorized. In particular, `docs/AUDIT_INDEX.md`, every
Code Map and `docs/code_maps/CODE_MAP_INDEX.md`, Dart/runtime/tests, Python
tools/tests, schemas, materializers, models, ProjectSession, packages, assets,
platform/generated substantive bytes, `_incoming`, and scratch are frozen.

This artifact has no ledger row, no designated verdict block, and no Phase-2
coordinates. Do not create any of them in this amendment. The complete existing
twelve-path child material and every other non-doc byte remain frozen.

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

The primary-photo correction is expected to edit only these existing child
paths as needed:

1. `lib/features/photos/logic/photo_event_read_model.dart`
2. `lib/features/photos/services/photo_event_writer.dart`
3. `lib/features/photos/widgets/photo_workbench_panel.dart`
4. `lib/features/board_canvas/rendering/aligned_photo_layer.dart`
5. `lib/features/board_canvas/screens/board_canvas_screen.dart`
6. `test/unit/photo_event_read_model_test.dart`
7. `test/unit/photo_event_writer_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

The four validator/transform paths remain byte-preserved with their current
implementation and regression fixes. This expected amendment delta neither
removes a path from nor adds a path to the preserved twelve-path material union.

## Locked V1 user flow

Board Canvas remains the primary normal workflow. The future child implements:

```text
open Board Canvas -> Fotod
-> Projekti foto is the existing Wizard/project background; no picker/re-import
-> choose board side and Similarity (default) or Affine (Advanced)
-> add corresponding photo-local / board-normalized point pairs
-> preview the aligned photo and residual directly on Board Canvas
-> explicitly Kinnita joondus
-> reuse a matching primary photo_added, or append/apply one for the existing file
-> append/apply one accepted photo_to_board_alignment_confirmed event
-> derive the accepted alignment from current events immediately
-> render it as the active Board Canvas reference layer
```

The authoritative primary-photo asset is the existing safe project-local
relative path exposed by `WizardIntake.backgroundPhoto`. It is the only Photo
Alignment V1 authoring source. The user selects it once during project creation;
alignment never asks the user to pick or import that same image again. Wizard
intake remains noncanonical on creation and project load: no event is written
until explicit `Kinnita joondus` requires the canonical handoff below.

If no Wizard/project background photo exists, alignment authoring is unavailable
and the panel shows clear primary-photo guidance. Existing `Impordi ja lisa`
remains available, but only as a visually secondary additional-photo-evidence
flow. Wizard-background visibility remains a separate UI-local choice; its
initial hidden/visible state is unchanged by this amendment.

The `Fotod` panel presents the source as `Projekti foto` and exposes no
canonical-photo selector for alignment. It lets the human choose `top`,
`bottom`, or `unknown` and add, remove, or reorder complete point pairs. A pair
contains one photo-local point selected on the intrinsic primary-photo preview
and one board-normalized point captured on Board Canvas. Incomplete pairs never
enter a solver or writer.

Additional accepted `photo_added` items remain visible as detail,
alternate-angle, microscope, or other visual evidence. They are not V1
alignment-authoring sources and do not automatically replace, compete with,
merge with, multi-align with, fuse with, or AI-match against the primary photo.

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
Its owner adds a primary-photo handoff seam plus the public
alignment-confirmation seam while preserving the frozen additional-photo
import contract. The API may use primary-photo- and alignment-specific
interfaces or compatible public request/result types inside the same file. It
must not add a required member that forces the frozen
`photo_import_service.dart` or its frozen fake/test owner to change.

Only the explicit `Kinnita joondus` action may begin canonical writing. One
activation is single-shot while in flight and performs this ordered protocol:

1. Capture the current project identity and `ProjectSession.generation` before
   the first await.
2. Re-resolve `WizardIntake.backgroundPhoto.relativePath` below the real
   directory-backed project root. Revalidate the safe relative path, supported
   image extension, final regular-file containment after symlink/junction
   resolution, readability, and decoded positive intrinsic dimensions. Compute
   lowercase SHA-256 from the current file bytes.
3. Reconcile the current durable `events.jsonl` under the existing contained
   readback rules before allocating. An accepted `photo_added` matches the
   current primary only when its safe `path` exactly equals the Wizard relative
   path and its valid 64-hex `sha256`, normalized to lowercase, equals the
   computed lowercase digest. If more than one matching historical event
   exists, reuse the one with the lowest valid V1 `sequence`. A same-path event
   with a different or missing hash is not a match.
4. When no match exists, allocate a unique valid `photo_id`, positive V1
   `sequence`, and global `evt_[0-9]{6}` ID against reconciled live history and
   append exactly one existing schema-`1.0`, accepted user `photo_added` with
   `mode: normal`, no `layer`, the Wizard relative path, and the computed
   SHA-256. The existing file is referenced in place: no picker, copy, move,
   rename, overwrite, deletion, cleanup, or rollback is performed.
5. Apply the exact returned or recovered `photo_added` through
   `ProjectSession.applyCanonicalEvent` with the captured generation when that
   event is not already present in the current session. If project identity or
   generation changed, stop before alignment and do not mutate the newer
   session.
6. Against the now-current same-project event state, revalidate the exact
   primary photo, board side, coordinate spaces, ordered complete pairs,
   transform type, deterministic solution, and fixed quality label. Allocate
   the next unique positive V1 `sequence`, global `evt_[0-9]{6}` ID, and
   `ALN[0-9]+` ID independently and append the existing accepted
   `photo_to_board_alignment_confirmed` envelope.
7. Apply the exact returned alignment event through the same captured-generation
   ProjectSession boundary. The event writes only `alignment_id`,
   `source_photo_id`, `board_side`, `coordinate_space_from: photo_local`,
   `coordinate_space_to: board_normalized`, ordered `reference_points_photo`,
   ordered `reference_points_board`, `transform_type`, and
   `alignment_quality_label: manual_preview_confirmed`.

Both event writes delegate validation/locked append to the unchanged generic
`tools/event_writer_service.py` through the existing `PythonRunner` and retain
exact readback plus conservative durable / uncertain / proven-no-event
classification. No transform matrix, residual, opacity, visibility, confidence,
component, pin, net, measurement, damage, suspect, trace, or fault field is
sent.

When a matching primary identity is already canonical, confirm appends exactly
one alignment event. The first confirm conditionally appends two events only
when the primary identity is absent. Cancel appends zero. A durable
`photo_added` remains canonical if alignment confirmation later fails. An
uncertain photo-write outcome stops before alignment and creates no local
substitute. On retry, durable-history reconciliation must reuse any matching
identity rather than append a duplicate.

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

Given the safe Wizard primary relative path and freshly computed SHA-256, the
read model deterministically identifies the matching accepted primary
`photo_added`. The active default is only the valid accepted alignment for that
primary identity with the greatest V1 `sequence`; V1 sequence uniqueness
supplies deterministic tie-free ordering. After reopen, both valid `similarity`
and `affine` primary events are eligible. Valid non-primary alignments remain
canonical history but never become the V1 authoring source or active/default
Canvas layer. During editing, a valid primary draft preview temporarily
overrides the confirmed visual layer without becoming event-derived state.

Confirmation captures `ProjectSession.generation` and project identity before
the first await. The exact returned or recovered photo event and returned
alignment event are applied in order only through the current
`ProjectSession.applyCanonicalEvent`. A project/generation change before,
between, or after the two possible writes never mutates the newer session or
permits the second write against it. Already durable events remain in the old
project's log and become visible when that project is reopened. An accepted
application makes projection freshness stale but the alignment immediately
renders from current events; it does not wait for Known Facts regeneration.

`ProjectSession`, `ProjectState`, `TraceBenchEvent`, Known Facts models,
materializer, and schema owners remain unchanged.

## Photo-file resolution and missing-file boundary

Alignment creates no new photo file. Primary handoff and rendering resolve only
the Wizard background relative path below the current directory-backed
project's real root. The path must pass the existing safe photo-path rules; the
final resolved target must be a contained regular file after symlink/junction
resolution. Handoff also proves readability, decodability, positive intrinsic
dimensions, and lowercase SHA-256 before canonical matching or append. Missing,
unreadable, undecodable, escaping, ZIP-only, or bundled primary bytes produce an
honest nonblocking unavailable warning and no layer or event.

The source file, Wizard background, every accepted imported copy, project
directory, and every unrelated file are immutable in this child. Primary
handoff references the existing file in place. There is no file rollback or
cleanup deletion because alignment creates no file.

## Board Canvas overlay and UI-local state

`aligned_photo_layer.dart` owns safe contained primary-photo resolution,
intrinsic decode/dimensions and digest support plus clipped, pointer-ignored
rendering of a validated solved transform and injected/testable image
presentation. It owns no draft, provider, event, file mutation, schema, or
canonical meaning.

Within the existing `_CanvasPanel` / `InteractiveViewer` board plane, the exact
bottom-to-top stack becomes:

1. opaque Board Canvas background and grid;
2. optional Wizard primary-photo background;
3. active aligned primary photo (confirmed event or current valid draft);
4. Wizard contour and visual candidates;
5. alignment-edit photo/board reference markers;
6. canonical component placements;
7. measurement badges, placement ghosts, status, warnings, and controls.

The aligned layer is clipped to the Canvas board rectangle and wrapped in
`IgnorePointer`. It shares the Canvas `InteractiveViewer`, so pan, zoom, fit,
placement hit testing, and existing gestures remain host-owned and unchanged.
Photo-local points map through the solved transform into board-normalized
coordinates and then through the full current board rectangle.

The newest valid confirmed primary layer is visible by default at UI-local
opacity `0.65`. Its visibility and opacity controls live in `Fotod`, range from
`0.0..1.0`, and reset when project/session identity changes. The separate
Wizard-background visibility control and its initial state are unchanged. None
of these controls is serialized, placed in an event, written to
`.tracebench_local`, or treated as confirmation. Draft markers exist only while
editing. Cancel removes them and restores the confirmed primary layer.
Confirmation clears the draft only after every required event application is
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

The accepted Canonical Photo Import V1 remains valid and unchanged. Its
`Impordi ja lisa` action now has the explicit V1 product meaning of additional
visual evidence. Additional photo events and any historical non-primary
alignment events remain readable canonical history but cannot automatically
become the primary source, active/default aligned layer, multi-photo fit, fused
image, or AI-matched alternative.

The child must not:

- implement homography, perspective correction, camera capture, EXIF handling,
  automatic point detection, AI confirmation, or automatic component creation;
- formalize or write `photo_reference_points_set` or `photo_layer_aligned`;
- author damage, suspect regions, visual traces, components, nets, or
  measurements;
- align, merge, fuse, multi-fit, AI-match, or automatically switch to an
  additional photo;
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
| `photo_event_read_model.dart` | no map; accepted entry `SCORE 5/12` | accepted photo/alignment pairing, primary path/hash identity, latest-primary selection | Known Facts/materializer/session frozen | `ZERO_WRITE` | entry `NOT_APPLICABLE`; requalify committed child source |
| `photo_event_writer.dart` | maintained writer map | primary identity reconciliation/handoff plus alignment request, envelope/ID allocation, append/readback | additional-photo import contract and generic Python tool inspect-only | `CANONICAL_EVENT` | `UPDATE_REQUIRED` |
| `photo_workbench_panel.dart` | maintained panel map | primary presentation/draft/conditional confirm/session controls; secondary additional import | picker/import implementation preserved; Canvas host coupled | `UI_LOCAL` + delegated `CANONICAL_EVENT` / `PROJECTION_STATE` | `UPDATE_REQUIRED` |
| `aligned_photo_layer.dart` | new; no source/map to qualify | safe primary resolution/decode/digest plus clipped pointer-ignored transformed image | no draft/file mutation/writer/provider owner | `ZERO_WRITE` | committed-source qualification required |
| `board_canvas_screen.dart` | maintained Board Canvas map | primary-only active layer, board capture, markers, exact stack | placements/Wizard visibility/focus/freshness/writers coupled and preserved | `UI_LOCAL` + `ZERO_WRITE` host | `UPDATE_REQUIRED` |
| `photo_alignment_transform_test.dart` | new; no source/map to qualify | pure solver/degeneracy/residual families | no widget/filesystem tests | test-only | committed-source qualification required |
| `photo_event_read_model_test.dart` | no map; accepted entry `SCORE 4/12` | primary/additional classification, accepted/rejected/latest/immediate-event derivation | session owner observed, not changed | test-only | entry `NOT_APPLICABLE`; requalify committed child source |
| `photo_event_writer_test.dart` | maintained writer-test map | primary reconcile/reuse/conditional handoff and exact alignment envelope/allocation/durability | real Python validator remains separate | exercised `CANONICAL_EVENT` | `UPDATE_REQUIRED` |
| `board_canvas_screen_test.dart` | maintained Board test map | no-reimport primary editor, conditional event sequence, additional noncompetition, overlay/session/stack/responsive families | real image/filesystem/writer persistence stays in focused owners/manual smoke | exercised UI/event/projection | `UPDATE_REQUIRED` |

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
6. primary identity classification by exact safe Wizard path plus current
   SHA-256, lowest-sequence duplicate-match reuse, additional-photo separation,
   malformed-event rejection, greatest valid primary-alignment default, and
   both transform types after reopen;
7. safe contained primary resolution/decode/hash, durable-history reconciliation,
   retry after uncertain/durable handoff, unique photo/envelope IDs, exact
   `mode: normal`/no-layer `photo_added`, exact V1 alignment envelope, fixed
   quality label, user actor, exact readback, uncertainty, and proven-no-event
   failure;
8. primary photo available without picker/re-import or canonical-photo selector,
   add/remove/reorder point pairs, transform switching, board capture, valid
   draft preview, residual display, mirror warning, and cancel with zero write;
9. first confirm producing `photo_added + alignment` (`+2`), later confirm
   reusing identity and producing only alignment (`+1`), durable photo retention
   after alignment failure, and captured-generation rejection before, between,
   and after writes with no newer-session mutation;
10. immediate event-derived primary rendering while projection freshness is
    stale, visible-by-default confirmed aligned layer, unchanged independent
    Wizard-background visibility, UI-local opacity/visibility, clipping,
    pointer ignoring, missing/unsafe/unreadable primary warning, and no
    persistent view state;
11. exact seven-layer Canvas order, Wizard primary-background coexistence,
    canonical placements above aligned/Wizard layers, edit markers below
    placements, and unchanged pan/zoom/fit/hit testing; and
12. secondary additional-photo import/list presentation without automatic
    alignment/source switching, wide and compact `Fotod`, no-primary guidance,
    zero-component Canvas usability, read-only non-directory behavior, zero
    unrelated canonical writer calls, and preservation of the existing
    similarity singular-scale parity plus selected-photo await-identity tests.

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

1. a project with Wizard background enters `Projekti foto` alignment without a
   second picker or `Impordi ja lisa` action;
2. similarity with two and extra pairs, live residual preview, first confirm
   producing exactly `photo_added + alignment` (`+2`), and immediate layer;
3. a later confirm reuses the same primary identity and produces exactly one
   new alignment event (`+1`);
4. affine Advanced mode including visible shear behavior;
5. reflected affine with the persistent mirror warning before confirmation;
6. cancel with zero new canonical event and restoration of the confirmed layer;
7. close/reopen rendering of valid confirmed primary similarity and affine
   events, with the primary identity reused;
8. import one additional photo and prove it remains evidence-only and does not
   take over, enter alignment, multi-fit, or change the active primary layer;
9. a missing/renamed primary photo yields a nonblocking warning, no canonical
   handoff, and no broken Canvas;
10. wide Board Canvas `Fotod`, point capture, layer controls, pan/zoom/fit,
    placements, and secondary additional-photo import;
11. compact Board Canvas with the same usable primary flow and no overflow; and
12. switch project/session while primary handoff or alignment confirm is in
    flight, proving the newer session is unchanged and durable old-project
    events reappear only when their project is reopened.

Automated tests cannot be reported as human smoke. Do not claim smoke PASS
without the human observation.

## Route and activation

```text
TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_SCOPE_LOCK_PASS
-> TRACEBENCH_PHOTO_ALIGNMENT_BOARD_CANVAS_V1_IMPL_PASS
-> committed-source Code Map refresh if required
-> NEEDS_USER_DECISION [non-executable]
```

No second product child is armed. Resumed implementation edits under the
amended contract activate only after accepted independent amendment audit and
exact human amendment staging/commit/push. The preserved child then requires
its own automated validation, human Windows smoke, independent implementation
audit, and exact human staging/commit/push. Any later Code Map maintenance
describes only accepted committed child source and returns to the sentinel.

## Scope validation contract

Run fresh for this docs-only amendment:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
```

Also prove exactly four newly changed docs paths, no `AUDIT_INDEX` or Code
Map/index change, byte-identical preservation of the pre-existing exact
twelve-path implementation material, no other runtime/test/tool/schema/model/
materializer/ProjectSession/Wizard/import-service/ZIP delta introduced by the
amendment, zero staged/unmerged paths, unchanged Windows/scratch residue, route
agreement, and absence of any fifth amendment path.

## Stop conditions

Stop and return to the human if:

- baseline, branch, divergence, predecessor completion, route, registry, or
  maintained-map state differs;
- scope needs a fifth path or child needs path 13;
- a schema, materializer, model, ProjectSession, photo import service, Wizard,
  ProjectCreator/Loader, Project ZIP, package, asset, route, or platform change
  becomes necessary;
- the public writer change would force a frozen importer or importer-test edit;
- primary identity cannot be matched by exact safe Wizard path plus freshly
  computed SHA-256, or a durable/uncertain prior handoff cannot be reconciled
  without duplicate `photo_added` risk;
- intrinsic photo bounds cannot be checked without adding image metadata to the
  canonical event or Python validator;
- finite/degeneracy/rank/singularity behavior cannot remain deterministic and
  parity-tested inside the exact Dart/Python owners;
- the Canvas layer cannot remain clipped, pointer-ignored, below Wizard geometry
  and canonical placements, or compatible with zero components;
- an additional photo would become an automatic alignment source, active/default
  layer, multi-photo fit, fusion input, or AI-matched alternative;
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
- All four identify this primary-photo amendment as current and only the same
  exact twelve-path child as the next executable pass after accepted amendment
  audit and human commit/push.
- This artifact contains no verdict block and has no `AUDIT_INDEX` row. The
  amendment's independent verdict is not mechanically recorded in the repo.
- The original fast-lane exception is retained as original-scope history and is
  not presented as a waiver for this protected amendment or general Lane B
  policy.
- Amendment validation and staging safety are reported only after fresh command
  evidence; child tests, smoke, audit, acceptance, commit, and push remain
  separate future gates.
- No touched file claims that the child implementation or smoke already passed.
