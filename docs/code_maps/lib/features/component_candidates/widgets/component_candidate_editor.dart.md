# Code Map: `lib/features/component_candidates/widgets/component_candidate_editor.dart`

- Source: `lib/features/component_candidates/widgets/component_candidate_editor.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — independent document edits, selection/hit testing, controls, pointer integration and painting`
- Audit evidence: none; this source/map diff awaits independent review.

## File purpose

Shared noncanonical candidate editor used by Wizard Step 4 and Canvas. It owns
the caller-controlled document editor, surface/controls, hit gating and painter.
Pure drag transaction decisions are imported; project acquisition, storage,
Session and canonical confirmation remain outside this library.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Document editing | `ComponentCandidateEditorController`, `replaceDocument`, `addAt`, `_updateSelected`, `moveSelected`, `deleteSelected` | Mutates a UI-local immutable document, preserves candidate keys/high water and publishes changes. No file writes. |
| 2. Selection and hit geometry | `select`, `selected`, `geometryFor`, `hitTest` | Selects an existing draft, synchronizes style controls and resolves nearest-center/topmost hit targets through existing shared geometry. |
| 3. Pointer adapter and preview | `_ComponentCandidateEditorState`, `_currentDrag`, `_discardDrag`, `_endDrag`, `didUpdateWidget`, `_surface`, `CandidateDragSession`, `kTouchSlop` | Owns render-transform conversion and transient preview. Delegates threshold, displacement and commit decisions to the pure session; commits only a changed valid owning-pointer release. Reflow, cancellation and invalidated contexts do not save a preview. |
| 4. Controls and completion | `_controls`, `edit`, `keyFor`, `_stateRow`, `componentCandidateShapeLabel` | Retains four-shape/style controls, labels, keys and delete action. Completion is emitted only when an edit replaces the document. |
| 5. Painting and interception | `ComponentCandidatePainter`, `markerGeometries`, `paint`, `shouldRepaint`, `canInteractAt` | Renders document or transient preview using shared geometry, preserving shape/rotation/minimum body/hit sizes and caller-owned canonical hit gating. |

## State and data flow

1. [D] Caller supplies one controller to surface and controls, a fitted reference
   rectangle, enabled/Add flags, selection/completion callbacks and hit gating.
2. [D] Pointer-down captures candidate key, document identity, owning pointer and
   global point, then selects. It changes no candidate position. `isDragging`
   retains its existing pointer-ownership role for Wizard scroll suppression.
3. [D] A move converts current and reference global points through the same
   current RenderBox transform. Only their displacement enters the drag session;
   a panel/frame-origin change is not pointer movement. Out-of-frame moves retain
   the accepted Wizard last-in-frame behavior.
4. [D] The session applies Flutter's 18-logical-pixel touch slop, displacement
   normalization, center translation and no-op/cancel decisions. Preview paint
   copies a candidate value without replacing the controller document.
5. [D] A matching valid pointer-up may update the document and emit completion
   once. Cancellation, disable, controller/document replacement, deselection,
   foreign pointer end or unchanged pose cannot commit that preview.
6. [D] Wizard owns intake/creation lifecycle. Canvas owns epoch/revision-guarded
   sidecar saves. Both receive the same completed UI-local edit contract; neither
   receives a canonical confirmation from this editor.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `candidate_drag_session.dart` | imported pure transaction | Threshold, pointer identity, relative normalized pose, clamping and valid changed completion. |
| `component_candidate_draft.dart` | document/value input and output | Existing noncanonical identity, shape, position, size and rotation contract. |
| `WizardCandidateGeometry`, `WizardVisualCandidateShape` | geometry/vocabulary | Existing reference-frame shape, rotation, body and hit bounds. |
| Flutter Material/gestures, `WorkbenchColors`, `WizardCompactTileSelector`, `WizardCompactTile` | framework/presentation | Existing controls, tokens, event delivery, render transform and slop. |

The new drag helper is `NOT_REQUIRED` for its own map: it is one small cohesive
pointer transaction, not five independent responsibilities obtained by counting
phase guards or calculated fields. Its focused standalone test also does not
qualify under CODE_MAP_STANDARD. This editor library qualifies independently.

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| Controller edits and selection | `UI_LOCAL` | [D] Replace in-memory values and notify listeners. No storage or Session import. |
| Drag session, geometry and painter | `ZERO_WRITE` | [D] Calculate values or paint; held previews do not replace the document. |
| Completion callback | caller-owned `UI_LOCAL` / invoked `NONCANONICAL_FILE` | [D] Wizard consumes draft state; Canvas's unchanged callback requests the existing local sidecar store. No direct file ownership here. |

## Zero-write zones

Geometry resolution, hit testing, rendering and the imported drag policy have no
canonical event/fact, writer, persistence, Session or ZIP authority.

## Impact matrix

| Change zone | Evidence | Coupled owners | Write class | Tests |
| --- | --- | --- | --- | --- |
| Pointer and preview | [D] Actual event adapter and identity guard | Wizard scrolling, Canvas panel reflow | `UI_LOCAL` | `candidate pointer transaction`, standalone drag-session tests |
| Completion gate | [D] Document replacement triggers callback | Canvas local sidecar lifecycle | invoked `NONCANONICAL_FILE` | `BB-02 panel-opening wobble never persists a real sidecar`, cancellation and reopen cases |
| Shape/control/hit/paint | [D] Existing direct controller/geometry paths | Wizard and Canvas views | `UI_LOCAL` / `ZERO_WRITE` | editor catalogue/pose cases; Wizard and Canvas regression suites |

## Relevant tests and helpers

- `test/unit/candidate_drag_session_test.dart`: direct policy import, including
  threshold, scale, frame changes, original-center translation, pointer ownership,
  cancellation, clamping, invalid numbers and return-to-start roundoff.
- `test/widget/component_candidate_editor_test.dart`: real pointer adapter,
  changed origin/frame, scale, preview/end, interruptions and existing controls.
- `test/widget/board_canvas_screen_test.dart`: actual panel reflow and real
  sidecar non-write cases alongside retained canonical/lifecycle regressions.
- `test/widget/new_project_wizard_screen_test.dart`: accepted drag boundaries,
  rotated/letterboxed geometry, creation and responsive workflow coverage.

## Dangerous combinations

Do not normalize an absolute pointer using a newly changed frame, mutate the
document during preview, save on cancellation, retire another pointer's session,
or apply an old gesture after selection/document/controller identity changes.

## Safe SNIPER slices

One pointer-policy branch plus its standalone and real editor/consumer test;
completion changes also retain the real sidecar and Wizard regressions.

## Future extraction seams

No new controller framework, confirmation, persistence contract or redesign is
authorized by this map.

## Freshness and review triggers

Review event-to-transform conversion, gesture identity, preview/commit timing,
controls, geometry, callback meaning and either caller's lifecycle changes.

## Known uncertainty

Automated tests and VM pointer evidence do not constitute human visual acceptance.
Canonical confirmation and unrelated workflow findings remain outside this owner.
