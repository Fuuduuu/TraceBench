# BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only scope lock
- Current: `BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_SCREEN_CODE_MAP_PASS`

This pass locks the first production code-map target and future map-pass
allowlist. It creates no map, adds no index row, and changes no source or test.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 5b5c346a6030b40b4071fb6ebc1e4593d2e2fd1b`
- Commit subject: `docs: close out code map standard bootstrap`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Only known untracked scratch/design/generated files were present; they remain
  untouched, unstaged, and outside scope.

The live route was `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`. The human
selected this first production-map scope lock, so the route change has no live
governance conflict.

## Binding sources

- `docs/POHIKIRI.md`
- `docs/code_maps/CODE_MAP_STANDARD.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/UI_WORKFLOWS.md`
- `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_POST_AUDIT_PASS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Maps remain task-specific navigation and impact evidence. They cannot override
these owners or authorize implementation.

## Accepted committed-state evidence

Target source:

- path: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- physical lines: 11,816
- committed/worktree blob: `a6eb5ae6167694fe2c8b2733618ef66e349a564f`

Relevant test evidence:

- path: `test/widget/board_canvas_screen_test.dart`
- physical lines: 10,043
- test declarations: 147
- committed/worktree blob: `f1b9655c49fc671eba50a11d5d9990eb6d0c4643`

Both worktree blobs matched `HEAD` during the gate, so the precheck describes
accepted committed state rather than an unfinished local diff.

## Qualification precheck

The production target qualifies automatically. The compact result for the map
is:

```text
AUTO — >5000 lines + 3+ responsibilities
```

Independent automatic evidence also exists:

- canonical add-component, metadata-edit, placement-confirmation, and
  measurement writer paths coexist with UI-local draft/selection state and
  read-only painters/renderers; and
- the source owns more than five independently tested behaviors.

Observed responsibility evidence includes workbench orchestration; typed
selection and component navigation; filtering and hover; canvas pan/zoom,
hit-testing, and focus; Add Component template/ghost drafting; explicit
component creation, metadata edit, and placement-save orchestration; integrated
measurement; inspector/evidence presentation; measurement badges; and footprint
rendering/semantics.

The relevant test file separately auto-qualifies as a large multi-family test
surface. Production and test maps qualify independently. This pass intentionally
authorizes only the production map; the future map may link the test file and
stable helpers but must not create its map or an index row for it.

## Write and protected-boundary evidence

Actual call-path classes to preserve in the map:

- `CANONICAL_EVENT`: `_confirmRightPanelComponentCreation` calls the existing
  add-component writer; `_confirmRightPanelMetadataEdit` calls the existing
  edit writer; `_confirmAddComponentTemplatePlacement` calls the existing
  placement writer; `_IntegratedMeasurePanelState._saveMeasurement` calls the
  existing measurement writer.
- `PROJECTION_STATE`: `_markPlacementProjectionStale` and
  `_appendMeasurementEventAndMarkStale` mirror returned events in local provider
  state and mark the projection stale after successful writer responses.
- `UI_LOCAL`: selection, filtering, panel/focus state, drafts, ghost dragging,
  badge visibility, pan/zoom, and navigation state.
- `ZERO_WRITE`: painter/rendering, footprint classification, inspector and
  evidence summaries, measurement association display, and safety copy.

The map must preserve the split between explicit human write actions and
read-only/UI-local surfaces. It must not imply direct `known_facts.json` writes,
promote visual traces into electrical proof, turn template/contact drafts into
pin/pad/net facts, or merge placement, identity, measurement, and electrical
semantics.

## Regression and test evidence

The 147 focused tests cover distinct families including navigator/filtering,
selection and hit-testing, footprints/painters, Workbench layout, Add Component
creation/edit/placement/drafts, integrated measurement, inspector/readiness,
measurement association and badges, visual traces, volatility, and explicit
writer boundaries.

Stable future map anchors may include `_harness`, `_routerHarness`,
`_selectPlacement`, `_tapCanvasAtNormalized`, `_boardCanvasPainter`, the four
fake writer classes, and representative tests that assert no-writer navigation,
explicit `Salvesta` writes, read-only pan/zoom, canonical-state preservation,
and source data-path boundaries. These links do not authorize a test map.

The component navigator closeout records 147 focused tests, 416 full Flutter
tests, and 285 validation tests passing for that accepted implementation. This
scope lock carries the audit as historical evidence and manufactures no new
Flutter or visual result.

## Armed map-pass allowlist

After this scope lock is independently audited, accepted, and pushed,
`BOARD_CANVAS_SCREEN_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_PASS.md`

The target Dart source and relevant test remain inspect-only. If a fourth file
or any source/test edit is required, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked map contract

The future production map must follow the standard template and:

- describe accepted committed source only;
- use stable symbols, never maintained line numbers;
- use no more than 12 independently meaningful responsibility zones;
- target 150–250 lines and remain below 300 without a human exception;
- cover flows, dependencies, evidence/write classes, protected and zero-write
  boundaries, relevant tests, dangerous combinations, safe SNIPER slices,
  freshness triggers, uncertainty, and non-authorizing extraction seams;
- add exactly one production-map index row; and
- exclude route state, commits, PASS_IDs, audit verdicts, staging instructions,
  active allowlists, normative refactor direction, and all test-map content.

## Locked map lifecycle

Initial state:

- map: `REVIEW_REQUIRED`
- index row: `REVIEW_REQUIRED`

Claude then performs a full read-only map-to-code audit against committed
source, relevant tests, canonical owners, and active boundaries.

Only this result permits metadata finalization:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
```

The same map pass may then record audit evidence in its allowed audit artifact
and synchronize map/index status to `MAINTAINED`. Accepted nits must be resolved
or explicitly recorded as non-blocking. Any substantive content correction
after the first audit must be covered by the final audit.

A short final read-only Claude diff audit is required after metadata
finalization and before staging. It verifies exact three-file scope, synchronized
status, map/source consistency, and the exact safe staging set. A
`BLOCKED_MAP_DRIFT` result or `SAFE_FOR_SNIPER_USE: NO` leaves map and index at
`REVIEW_REQUIRED`, forbids staging, and returns the blocker for human routing.

## Preserved boundaries

No Dart, test, test-file map, code-map standard, Prompting Constitution,
`docs/FILE_MAP.md`, runtime, route behavior, schema, writer, materializer,
validator, projection, Project ZIP, event/fact, canonical placement/coordinate,
net/electrical, package, asset, tool/linter, refactor/extraction, Board Canvas
behavior, or `_incoming` change is authorized. Known scratch remains untouched.

## Model routing

`MODEL_ROUTING_CHECK result: PASS` — Codex drafts this Lane A docs-only lock,
Claude Code performs the independent pre-staging audit, and the human owns exact
staging, commit, and push.

## Validation record

- `python tools/validate_all.py`: PASS; 285 tests.
- `git diff --check`: PASS.
- Changed-file allowlist: exact five docs files; PASS.
- `git diff --cached --name-status`: empty.
- No code-map file created and `CODE_MAP_INDEX.md` unchanged.
- Target source and test unchanged from `HEAD`.
- `HEAD`: unchanged at `5b5c346a6030b40b4071fb6ebc1e4593d2e2fd1b`.
