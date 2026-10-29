# Code Map: `lib/features/board_canvas/widgets/placement_template_preview.dart`

- Source: `lib/features/board_canvas/widgets/placement_template_preview.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — five-plus independently testable catalogue/presentation/painter behaviors; not a small cohesive value adapter`
- Audit evidence: none

## File purpose

Owns the single seven-template Placement catalogue and read-only visual
presentation shared by the Add panel and Canvas ghost. Public widgets take
explicit template, scalar and marker values plus intent callbacks. No draft,
controller, eligibility, gesture routing, canonical geometry or writer is owned
here. Component candidates retain their separate editor and geometry contract.

## Qualification

[D] The catalogue/lookup contract, chooser intent/selection, selected-summary
change action, aspect-ratio preview, scalar draft card and body/marker/dash
painter have independently observable behavior. These are complete presentation
owners, not five calculated properties of a small adapter. The seven shape
branches and derived catalogue getters are not counted as separate owners.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Catalogue and lookup | `PlacementTemplateBodyShape`, `PlacementTemplateDefinition`, `starterPlacementTemplates`, `placementTemplateById` | One ordered constant catalogue; labels, body proportions, marker defaults and nullable trimmed-ID lookup. |
| 2. Chooser | `PlacementTemplateChooser`, `_PlacementTemplateListTile` | Keyed template rows, selected indicator, mini shape/count presentation and template-ID intent callback. No selection storage. |
| 3. Selected summary | `PlacementTemplateSelectedSummary` | Existing shape, short contact count, draft badge, selected semantics and change-template callback. |
| 4. Shape preview | `PlacementTemplatePreview`, `_buildTemplateMiniShape` | Existing keyed aspect-ratio CustomPaint and small shape icon decoration. Caller supplies the four marker counts. |
| 5. Draft card | `PlacementDraftPreviewCard` | Dashed local preview, unsaved label and formatted width/height/rotation text from explicit values. No mutation or validation. |
| 6. Preview painter | `PlacementTemplatePreviewPainter`, `_buildBodyPath`, `_drawContactMarkersAlongTop`, `_drawContactMarkersAlongRight`, `_drawContactMarkersAlongBottom`, `_drawContactMarkersAlongLeft`, `_drawDashedPath`, `shouldRepaint` | Body path, edge marker distribution, optional fill/dashes, style overrides and retained repaint predicate. |

## Anchor inventory and verification

Responsibility-table anchors are literal substrings in Source. Flutter classes
are framework consumers. Stable symbols replace line-number anchors.

## State and data flow

1. [D] `starterPlacementTemplates` keeps seven original IDs, ordering, labels,
   examples and marker defaults. Lookup trims its input and returns null for
   empty/unknown IDs; it neither creates a fallback entry nor changes state.
2. [D] Template definition derives body kind/aspect and contact summary from its
   immutable values. Shape proportions are presentation metadata, not persisted
   placement width/height or a redefinition of normalized board coordinates.
3. [D] Chooser receives the selected ID and callback. Tapping a row emits its ID;
   the caller updates selection and rebuilds. Summary emits only change intent.
4. [D] The host adapts the catalogue into the existing workflow `PlacementTemplate`
   values. Workflow snapshots are unpacked by thin host builders into explicit
   widget arguments; this library imports neither workflow nor host.
5. [D] Static preview uses template aspect ratio with caller marker counts. Draft
   card uses the same aspect ratio in the retained bounded slot; size and degree
   rotation are displayed as text, not applied as a new card transform.
6. [D] The painter insets by 12, uses a centered circular path for round bodies
   and the existing rounded-rectangle paths otherwise. Markers are positioned on
   the inset rectangle edges in top/right/bottom/left order, including round
   templates. A zero count draws none; one is centered; larger counts are evenly
   spaced at `(index + 1) / (count + 1)`.
7. [D] Default boundary/marker colors, transparent fill, 1.8 stroke and solid
   boundary remain unchanged. Draft card overrides dashes/stroke; Canvas ghost
   supplies its existing colors/fill/dashes/stroke. Host retains ghost sizing,
   position, rotation and drag gestures.
8. [D] `shouldRepaint` compares template identity and four marker counts only.
   Style-only changes are deliberately not added to this existing predicate.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework/read presentation | Widgets, theme text roles, callbacks, paths, canvas and CustomPainter. |
| `dart:math` | pure calculation | Round-body radius, mini shape bounds and dashed path lengths. |
| `board_canvas_palette.dart` | read-only visual tokens | Existing warm preview/selection/summary styling. |
| `board_canvas_screen.dart` | constructing caller, not imported | Explicit-value adapters and Canvas ghost painter reuse; owns selection/context/gestures. |
| `board_canvas_placement_panel.dart` | indirect workflow, not imported | Owns drafts, counts/scalars/guards and writer handoff; receives constructed preview widgets through host builders. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Catalogue, lookup and derived labels | `ZERO_WRITE` | [D] Constant values and pure getters/lookup. |
| Chooser/summary construction | `ZERO_WRITE` | [D] Stateless widgets; callbacks express intent, without local storage. |
| Row/change callbacks | caller-owned `UI_LOCAL` intent | [D] The current host supplies existing Placement-holder template/change mutators. No writer callback is introduced. |
| Shape/draft widgets and painter | `ZERO_WRITE` | [D] Format and draw supplied values only; no provider, filesystem or event API. |

The module has no Session, canonical event, persistence, controller, validator,
candidate editor, coordinate conversion or hit-testing dependency. Marker
decoration does not create electrical contacts, pins, components or placements.

## Zero-write zones

- All catalogue, lookup, body path, mini shape and marker/dash calculations.
- All widget build methods, selection indicators and size/rotation labels.
- Canvas ghost painting through this painter; host gestures and eventual Save
  remain separate owners and do not turn drawing into a canonical action.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Catalogue/defaults/lookup | [D] constant entries and trimmed lookup | host `PlacementTemplate` adapter and holder seeding | `ZERO_WRITE` | direct catalogue/default/fallback tests; retained Canvas template cases |
| Chooser/summary | [D] keys, labels, mini shapes and callbacks | host selection and workflow template-change mutators | `ZERO_WRITE` / caller `UI_LOCAL` | direct selected/callback/layout tests; Canvas change-template cases |
| Static/draft preview | [D] aspect slots and explicit values | host snapshot adapter and workflow controls | `ZERO_WRITE` | direct shape/count/scalar-label tests; Canvas size/rotation cases |
| Painter body/markers | [D] recorded path bounds and edge points | all panel previews and host ghost consumer | `ZERO_WRITE` | direct seven-shape and edge-distribution tests; retained Canvas ghost tests |
| Painter style/repaint | [D] retained predicate and explicit overrides | draft card and Canvas ghost style inputs | `ZERO_WRITE` | direct dashes/defaults/override/repaint tests |
| Dependency boundary | [D] import and source ownership guards | host and frozen workflow module | `ZERO_WRITE` | standalone import guard and Canvas static-owner guard |

## Relevant tests and helpers

- `test/widget/placement_template_preview_test.dart` imports this library without
  BoardCanvasScreen. It checks catalogue identity/defaults, lookup, selected
  indicators/callbacks, all shape ratios/path bounds, marker totals/positions,
  draft labels, painter styles/repaint and compact/wide widget slots.
- The direct paint recorder inspects real Canvas operations; fixed coordinate
  expectations are independent of the production edge-placement function.
- `test/widget/board_canvas_screen_test.dart` retains existing template selection,
  size/count/rotation, ghost, first-placement, bounds, save and duplicate cases.
- Existing static-owner assertions follow moved declarations and Eelvaade copy
  into this library while preserving workflow/render/data-path exclusions.
- Frozen P0/C0/M0/I0 groups continue to cover lifecycle, composition and canonical
  handoff through the unchanged workflow owners.

## Dangerous combinations

- Duplicating the catalogue in a caller can desynchronize IDs/defaults/seeding.
- Moving draft selection, validation, hit testing or writer calls here would
  violate the explicit-value presentation boundary.
- Treating template aspect metadata as canonical Placement geometry, or sharing
  it with candidate geometry, would change a separate persisted contract.
- Changing path insets, edge marker arithmetic or the repaint predicate affects
  all current preview consumers, including the host ghost.
- Changing callbacks to retain state could alter caller-owned template lifetime.

## Safe SNIPER slices

- One catalogue label/default: exact entry plus direct catalogue and host seeding
  evidence; preserve identity/order and explicit workflow ownership.
- One presentation control: widget/key/callback plus direct and host consumer
  tests; inspect host adapters without moving workflow state.
- One painter concern: exact path/marker/style symbol plus recorded operations
  and ghost consumer; preserve canonical geometry and gesture ownership.

## Future extraction seams

[S] Catalogue, stateless widgets and painter are separate review zones. This map
does not prescribe additional files, controllers, workflows or abstractions.

## Freshness and review triggers

Review public API, catalogue identity/order/defaults, widget keys/labels/theme,
callback semantics, host adapters, preview slots, painter edge geometry/styles/
repaint and consumer ownership when these contracts change.

## Known uncertainty

- [D] Widget/paint tests do not establish human visual acceptance or native
  Windows Save integration; the existing workflow owns that separate boundary.
- [D] The retained repaint predicate ignores style-only changes. The extraction
  preserves that behavior rather than making an unrelated fix.
