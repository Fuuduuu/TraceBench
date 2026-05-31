# BOARD_CANVAS_READONLY_POLISH_V1_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_READONLY_POLISH_V1_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only visual polish scope lock.

## Verdict
Completed (scope lock accepted).

## Inputs accepted
- `LIVE_POSITIVE_SMOKE_TEST_RUN_PASS` verdict: `PASS`.
- Claude Design verdict: `GO` for docs-only visual polish scope lock.
- GPT Pro verdict: `APPROVE_SCOPE_LOCK`.

## Accepted baseline (locked)
- Positive smoke confirms:
  - `SMP001` placement rendering,
  - placement selector behavior,
  - read-only inspector behavior,
  - measurement summary (`M1001`) behavior,
  - visual trace metadata summary (`VT001`) behavior,
  - readiness metadata panel (`ALN1001`) behavior,
  - persistent `renderer writes: none`.
- Hard evidence boundaries remained preserved in smoke observations.

## Allowed V1 polish scope (locked)
Styling/layout/copy/accessibility only:
- substrate/outline/subtle-grid visual styling,
- selected/unselected visual-state polish,
- placement selector styling,
- inspector + metadata-card layout polish,
- read-only category tag presentation (`MEASURED`, `VISUAL`, `READINESS`, `STALE`, `REMOVED`, `UNKNOWN`),
- spacing/typography/hierarchy polish,
- empty/no-selection/no-placement state polish,
- responsive and focus/contrast improvements,
- right-column metadata-stack polish,
- persistent visible `renderer writes: none`.

## Forbidden V1 polish scope (locked)
- background photo/helper layers,
- transform/matrix computation or displayed transform outputs,
- photo-local evidence conversion/rendering on board,
- visual_trace/damage/suspect/measurement geometry overlays on board,
- event-writing or edit/confirm/save/apply/promote controls,
- AI proposal/detection/candidate UI,
- `board_graph.json` / `view_state.json`,
- any template_id or visual-trace wording implying electrical identity/net truth.

## Layout direction lock
- Desktop/wide:
  - left selector/index, center canvas, right inspector/metadata stack.
- Smaller widths:
  - canvas dominant; inspector/measurement/visual-trace/readiness reflow below canvas in fixed order.
- `renderer writes: none` remains visible at all widths.

## Copy/safety requirements lock
Must preserve/strengthen without weakening:
- read-only/no-write projection copy,
- measurement/visual-trace/readiness safety copy,
- `declared type — not computed`,
- no wording implying electrical confirmation from visual/readiness metadata.

## Performance/accessibility guardrails lock
Allowed:
- contrast/focus/keyboard/hit-target/text-label improvements.

Forbidden:
- heavy visual effects/animations,
- persisted theme/view state,
- any polish changes that introduce write actions.

## Future implementation allowlist direction
`BOARD_CANVAS_READONLY_POLISH_V1_IMPL_PASS` may likely touch:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- docs ledger/audit files

Conditionally:
- `lib/shared/footprints/**` only for display-token polish with no semantic changes.

## Future test expectations (locked)
- Existing board-canvas tests remain passing.
- Positive fixture still renders `SMP001` and selection.
- Inspector/measurement/visual-trace/readiness remain metadata-only.
- No forbidden actions/overlays/transform/photo-layer behavior.
- Constrained viewport remains overflow-safe.
- Category tags are text-visible (not color-only).

## Next recommended pass
`BOARD_CANVAS_READONLY_POLISH_V1_IMPL_PASS`
