# TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS

## Pass identity

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Role: accepted implementation lock, two-map refresh, evidence record, and route release`
- `CODE_MAP_PREFLIGHT: REQUIRED`
- `CODE_MAP_STATUS: REVIEW_REQUIRED`

## Authority gate

- Repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- Branch: `main`
- `HEAD`: `4a5495f768c212699684151fd0c4c59ad58c3f4b`
- `origin/main`: `4a5495f768c212699684151fd0c4c59ad58c3f4b`
- Subject: `feat: add Wizard component marker visuals v2`
- Parent: `660d629d7a046023b1f51651bec94afe8e39d8ad`
- Divergence: `0 0`
- Entry staged set: empty
- Entry substantive tracked diff: empty
- Five pre-existing porcelain-only tracked paths were verified
  content-identical to `HEAD`; known scratch remained outside authority.

## Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
7. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`

No ninth file is authorized.

## TOOL_SKILL_CHECK

- Repo-local inventory checked:
  `.agents/skills/tracebench-audit-reconciliation`,
  `.agents/skills/tracebench-prompt-authoring`, and
  `.agents/skills/tracebench-scope-lock`
- Applicable repo-local capability:
  `.agents/skills/tracebench-prompt-authoring`
- Capability actually used: prompt-authoring guidance is used only for the
  final read-only audit handoff after this real eight-file diff exists
- Why applicable: the pass must hand a concrete docs/map LOCK diff, observed
  validation, exact bounded Phase 2 authority, and canonical verdict fields to
  independent Claude Code audit
- `tracebench-scope-lock` does not trigger because this pass closes an
  accepted implementation rather than reserving a future implementation
- `tracebench-audit-reconciliation` does not trigger because this pass creates
  a new LOCK record and changes route authority rather than repairing an
  existing artifact/ledger mismatch while leaving route unchanged
- External tool required: `NO`
- Plugins, MCP writes, installs, downloads, internet, and dependencies:
  `NOT USED`

No capability expands the exact eight-file authority.

## Accepted implementation identity

Git command:

```text
git diff-tree --no-commit-id --name-status -r
  4a5495f768c212699684151fd0c4c59ad58c3f4b
```

Exact result:

```text
M  lib/features/project/screens/new_project_wizard_screen.dart
M  test/widget/new_project_wizard_screen_test.dart
```

Commit stat:

```text
2 files changed, 1066 insertions(+), 42 deletions(-)
```

The commit is contained by `origin/main`; `HEAD == origin/main` proves the
pushed identity.

Exact committed Git blob identities:

| Source | Git blob object id |
| --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `0f1168d2f7741172cda6e7327688e8ecc3c52dca` |
| `test/widget/new_project_wizard_screen_test.dart` | `e12d41c556e635278ff981115fe434d9f5706561` |

Object identities use `git rev-parse HEAD:<path>` and name committed Git
representations rather than mutable worktree bytes.

## Human-supplied manual-smoke evidence

The human individually attested `13/13 PASS` for the committed
implementation:

1. placing all four shapes;
2. the default marker being clearly smaller;
3. minimum and maximum size;
4. rotation and reset on rectangular shapes;
5. editing only one selected marker;
6. dragging after styling;
7. selecting tiny and rotated markers from their edges;
8. overlapping-marker selection;
9. deletion retaining the next current style;
10. Step 4 navigation round trip;
11. wide and compact layouts;
12. operation with photo plus contour and without photo; and
13. the `ZERO_WRITE` boundary.

This is human-supplied visual and interaction evidence. It creates no
repository write or canonical product authority.

## Supplied implementation-audit evidence

The supplied final implementation audit returned:

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
CANDIDATE_MODEL_RESULT: PASS
CURRENT_STYLE_RESULT: PASS
SHAPE_RESULT: PASS
SIZE_RESULT: PASS
ROTATION_RESULT: PASS
HIT_TEST_RESULT: PASS
DIRTY_STATE_RESULT: PASS
RETENTION_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
CODE_MAP_RESULT: UPDATE_REQUIRED
```

Its exact safe implementation set was:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

## Accepted findings and disposition

- `LOW-1`: the 8-pixel rendered-size floor flattens approximately the
  50%–76% compact slider range. The human observed and accepted this
  visibility trade-off. No patch is required.
- `NIT-1`: rotation controls remain enabled for `Ümar`. This is allowed by
  the scope and preserves stored rotation across later shape changes. No
  patch is required.

Neither finding opens a package, identity, geometry-storage, canonical,
persistent, photo/contour, or protected-surface change.

## Supplied implementation validation evidence

- Exact formatting of the two implementation files: `PASS`
- Targeted `flutter analyze --no-pub`: `PASS`, no issues
- Focused Wizard widget suite: `52/52 PASS`
- Full `flutter test --no-pub`: `481/481 PASS`
- `py -3 tools\validate_all.py`: `302/302 PASS`
- `git diff --check`: `PASS`
- `git diff --cached --check`: `PASS`

These are attributed observations against the accepted implementation. This
LOCK validates its own current eight-file docs/map diff separately below.

## Committed source identity

All map claims are derived from committed `HEAD` source.

| Source | Physical lines | Git blob object id |
| --- | ---: | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | 3,150 | `0f1168d2f7741172cda6e7327688e8ecc3c52dca` |
| `test/widget/new_project_wizard_screen_test.dart` | 2,540 | `e12d41c556e635278ff981115fe434d9f5706561` |

Physical lines use `(Get-Content -LiteralPath <path>).Count`. Object
identities use `git rev-parse HEAD:<path>`.

## CODE_MAP_PREFLIGHT and qualifications

Both targets entered implementation with existing `MAINTAINED` maps. Material
accepted production and focused-test changes made both dispositions
`UPDATE_REQUIRED`. This LOCK refreshes only those maps from committed `HEAD`.

| Source | Qualification | Committed behavior requiring refresh |
| --- | --- | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `AUTO — 5+ independently testable behaviors` | Candidate/current-style ownership, immutable shape/size/rotation state, keyed controls, shape-aware painter geometry, selected outline, responsive size, geometric hit testing, dirty branches, retention, and preserved layering/zero-write behavior. |
| `test/widget/new_project_wizard_screen_test.dart` | `SCORE 11/12 — 52-test multi-family marker/photo/contour/navigation/responsive protected-boundary surface` | New candidate-style snapshots, keyed/semantic controls, inheritance/isolation/invariance tests, painter geometry, size floor/ratios, edge/rotated target interaction, overlap resolution, and navigation/resize/photo retention extend the existing Wizard families. |

### Production automatic qualification

The 3,150-line production file still qualifies automatically because it owns
far more than five independently testable behaviors across Step 1, photo,
contour, component marker state/interaction, rendering/hit geometry,
navigation/progress, cancellation, responsive behavior, and protected
zero-write boundaries.

### Test score recalculation

The current committed test is 2,540 physical lines and contains 52 widget
tests. The recalculated worksheet is recorded here rather than copied from the
prior map:

| Dimension | Score | Current committed evidence |
| --- | ---: | --- |
| Physical size | 2 | 2,540 physical lines. |
| Independent responsibilities | 2 | Platform/pickers, route/folder harness, shared navigation, contour, photo, marker style/geometry, catalogue, retention/progress, responsive, and protected-boundary families. |
| Canonical / protected boundaries | 1 | One explicit read-only `UI_LOCAL` + `ZERO_WRITE` protected boundary; no writer coexists in the test. |
| Regression surface | 2 | 52 tests across more than three behavior families. |
| Whole-file analysis tax | 2 | Foundation, contour, placement, photo-first, and marker-visual passes repeatedly required broad suite reconstruction within approximately 90 days. |
| Blast-radius ambiguity | 2 | Safe marker changes require reconstructing controls/current style, private candidate snapshots, painter geometry, raw pointer helpers, retention/layering, responsive gestures, dirty state, and the zero-write traversal. |
| **Total** | **11/12** | Qualification threshold exceeded with all non-size evidence grounded in committed source/test and durable pass history. |

Both refreshed map headers and only their two matching
`CODE_MAP_INDEX.md` Status cells are `REVIEW_REQUIRED`.

## Committed behavior recorded by the maps

1. Each immutable `_WizardComponentCandidate` owns a stable local `draftKey`,
   editor-normalized center, visual shape, finite size scale clamped to
   `0.50..2.50`, and finite rotation normalized to `[-π, π)`.
2. The Wizard parent owns candidates, selection, the next/current shape-size-
   rotation style, navigation, and dirty state; no provider, singleton,
   route handoff, child authority, or canonical model receives them.
3. Exactly four visual choices exist: `Ümar`, `Ruut`, `Ristkülik`, and
   `Ümardatud ristkülik`.
4. No-selection controls mutate only current style and do not dirty the draft.
   Selection loads a candidate's complete style without dirtying it.
5. Effective selected style changes replace only that immutable candidate,
   become current for the next candidate, and dirty the Wizard draft.
6. New candidates inherit complete current style; selected deletion clears
   selection while retaining that style.
7. Rendered minor size is `max(8.0, shortestCanvasSide * 0.035 * sizeScale)`;
   fixed aspect ratios are `1.0`, `1.0`, `1.8`, and `2.2`.
8. Rotation controls use `−15°`, `+15°`, and reset. Circle ignores rotation
   visually while preserving its stored value.
9. `_WizardComponentMarkerGeometry` derives each shape path, center rotation,
   complete rotated bounds, and a centered target covering those bounds or at
   least `56×56`, whichever is larger.
10. Selected highlighting follows the actual rotated marker path. Overlapping
    targets choose the closest center and preserve insertion order on ties.
11. Dragging changes only editor-normalized position and preserves stable key,
    shape, size, and rotation. Add, effective selected style, move, and delete
    dirty the draft.
12. Photo remains the inert bottom layer, closed contour the inert middle
    guide, and editable candidates the top layer; no-photo operation remains
    available.
13. Candidate values, selection, and current style survive Step 4/5 and
    earlier-step round trips, wide/compact and canvas resize, and photo
    transform/replacement/removal. Responsive pixels recompute without stored
    candidate mutation.
14. Step 4 remains optional, ungated, and visited-only `Vaadatud`; step order,
    numbering, other gates, placeholders, cancellation, and final zero-write
    behavior remain unchanged.
15. The 52-test suite covers the marker contract plus existing Step 1,
    photo, contour, navigation/progress, responsive, and protected-boundary
    behavior.

## Write and protected boundaries

- No Dart, test, accepted scope artifact, third map, package, asset, schema,
  tool, `_incoming`, or scratch file is changed by this LOCK.
- The implementation and LOCK are `UI_LOCAL` + `ZERO_WRITE`.
- Candidate centers and visual style remain private Wizard draft values;
  derived pixels, paths, rotated bounds, and hit targets are presentation-only.
- Candidate centers are editor-normalized values, not canonical
  `board_normalized` coordinates.
- Shapes are generic visual proposals only. They establish no component
  identity, type, value, designator, package, footprint, pin, pad, contact,
  polarity, board side, net, measurement, diagnosis, or electrical meaning.
- Photo and contour state remain read-only to this marker slice. There is no
  snapping, grid, contour containment, or geometry conversion.
- `ProjectCreator`, project state, providers, persistence, filesystem writes,
  canonical events/facts/projections, schemas, validators, writers,
  materializers, Project ZIP, AI/OCR/CV, router, Home, Board Canvas, packages,
  assets, tools, and protected surfaces remain unchanged.
- Code maps are descriptive and non-authorizing.

## Map, ledger, and verdict-block freeze anchors

All SHA-256 and byte-length values below are local `worktree` observations for
the bounded Phase 1 -> Phase 2 comparison in this checkout. They are not
presented as committed Git-blob identities.

The PowerShell measurement reads each file with `[IO.File]::ReadAllBytes`,
rejects a UTF-8 BOM, decodes with
`New-Object System.Text.UTF8Encoding($false)`, preserves existing line endings
without normalization, re-encodes with the same UTF-8 encoder, and calculates
SHA-256 with
`[System.Security.Cryptography.SHA256]::Create().ComputeHash(<bytes>)`.

For each map body, take the raw substring from the first character of
`## File purpose` through EOF.

| Map | Body bytes | Body SHA-256 |
| --- | ---: | --- |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | 18,324 | `03a40e951d6ec40e39c044e2047b400c7f2c79b9c558d3bb9b6135f2e6b76f26` |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | 16,572 | `822a3c9da4e4501fea7a1adfb2e7488bd72442a8f5b26c47db3f7ceb13a28f4a` |

For each complete map, require exactly one literal
`- Status: \`REVIEW_REQUIRED\`` substring and replace only that substring with
`- Status: <MAP_STATUS_CELL>`. The replacement excludes the line ending.

| Map | Masked-file bytes | Masked-file SHA-256 |
| --- | ---: | --- |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | 18,687 | `55bd590a5495352679ad248302f3661c77159bafaa3982234be2852f73526e9d` |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | 16,967 | `43df53fe54534c56afef41203ffd1b282faf7b7fb607f2cfe11caf050c07b6d5` |

For each matching `CODE_MAP_INDEX.md` row, split the raw row on literal `|`,
replace segment index `4` with exactly ` <MAP_STATUS_CELL> `, preserve the
single leading and trailing space, rejoin on literal `|`, encode raw UTF-8
without BOM or trailing newline, and calculate SHA-256.

| Source row | Masked-row bytes | Masked-row SHA-256 |
| --- | ---: | --- |
| `lib/features/project/screens/new_project_wizard_screen.dart` | 180 | `645c84b6246775d34ab5c99a52cc31a56edf9fe7a40511f79ee9e1b57730aae1` |
| `test/widget/new_project_wizard_screen_test.dart` | 150 | `076bf07bbfc16e0f6477e8a633eda7fe0b20ba869746ac6d776bbae507b35f75` |

For the unique matching `docs/AUDIT_INDEX.md` row, split the raw row on
literal `|`, replace segment index `3` with exactly ` <LOCK_STATUS_CELL> `,
preserve the single leading and trailing space, rejoin on literal `|`, encode
raw UTF-8 without BOM or trailing newline, and calculate SHA-256.

| Ledger row | Masked-row bytes | Masked-row SHA-256 |
| --- | ---: | --- |
| `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS` | 1,551 | `6401e6d9f71a60d5c28d2b682af8a7e7ce7f3f7c3c6a7fd39d3bcfc769c832b4` |

The designated verdict block uses the unique BEGIN and END HTML comments
directly below. The first ends in `VERDICT_BLOCK_BEGIN -->`; the second ends
in `VERDICT_BLOCK_END -->`.

Phase 1 requires one occurrence of each marker and an empty payload after
removing exactly one line ending immediately after the BEGIN marker and one
line ending immediately before the END marker. That payload is `0` UTF-8 bytes
with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

To freeze every artifact byte outside that payload, replace the complete raw
payload between the marker literals with
`<LOCK_VERDICT_BLOCK_INTERIOR>`, replace the value token on the unique
`Masked-artifact bytes` line with `<MASKED_ARTIFACT_BYTES>`, replace the value
token on the unique `Masked-artifact SHA-256` line with
`<MASKED_ARTIFACT_SHA256>`, and hash the resulting raw UTF-8 worktree text
without line-ending normalization.

- Masked-artifact bytes: `21318`
- Masked-artifact SHA-256: `b6d2e3a38036dc61514151c89d650d9248f31bb3e1e26dc7b88d2481deb152e1`

## Bounded promotion and verdict-recording contract

A clean final map/LOCK audit may authorize only:

- `REVIEW_REQUIRED` -> `MAINTAINED` on the two map `Status` header lines;
- `REVIEW_REQUIRED` -> `MAINTAINED` in the two matching index Status cells;
- returned verdict text inside the designated LOCK verdict-block markers; and
- a mechanical mirror of that returned result in the unique matching ledger
  Status cell.

Exact promotion maps:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`

Exact promotion index rows:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No clean promotion changes a map body, qualification field, another metadata
field, another index or ledger cell, the ledger Description, a route owner, a
runtime/test file, the accepted scope artifact, or any other content. No extra
pass is created for mechanical promotion or verdict recording.

## Route

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS
Next: NEEDS_USER_DECISION
```

The selected `SCOPE -> EHITUS -> LOCK` cycle returns to the non-executable
decision sentinel. No executable successor is armed.

## LOCK validation evidence

The complete eight-file LOCK diff uses:

```text
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --porcelain=v1 -uall
```

Recorded results:

- `py -3 tools\validate_all.py`: `PASS`, exit `0`, `302/302`, with only
  expected missing-optional-photo warnings
- `git diff --check`: `PASS`, exit `0`
- `git diff --cached --check`: `PASS`, exit `0`
- exact authorized docs/map set: `PASS`, eight files
- empty staged set: `PASS`
- empty runtime/test diff: `PASS`
- both maps and matching index rows `REVIEW_REQUIRED`: `PASS`, two/two
- route LOCK_PASS -> `NEEDS_USER_DECISION`: `PASS`, all three route owners
- all published freeze anchors reproduce: `PASS`
- exactly one empty designated verdict block and one new ledger row:
  `PASS`

## Independent lock/map audit contract

The final auditor compares both complete maps and index rows against committed
`HEAD`, reproduces every freeze anchor, checks the exact eight-file diff and
attributed implementation/manual-smoke evidence, and returns:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
MAP_BODY_FREEZE_RESULT: PASS / FAIL
MASKED_MAP_FREEZE_RESULT: PASS / FAIL
INDEX_ROW_FREEZE_RESULT: PASS / FAIL
LEDGER_ROW_FREEZE_RESULT: PASS / FAIL
VERDICT_BLOCK_FREEZE_RESULT: PASS / FAIL
QUALIFICATION_RESULT: PASS / FAIL
PROMOTION_AUTHORIZATION: YES / NO
PROMOTION_MAPS: exact paths or NONE
PROMOTION_INDEX_ROWS: exact source rows or NONE
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact paths or NONE
IMPLEMENTATION_EVIDENCE_RESULT: PASS / FAIL
MANUAL_SMOKE_RESULT: PASS / FAIL
CANDIDATE_MODEL_RESULT: PASS / FAIL
CURRENT_STYLE_RESULT: PASS / FAIL
SHAPE_RESULT: PASS / FAIL
SIZE_RESULT: PASS / FAIL
ROTATION_RESULT: PASS / FAIL
HIT_TEST_RESULT: PASS / FAIL
DIRTY_STATE_RESULT: PASS / FAIL
RETENTION_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
FINDINGS: ranked findings or NONE
```

The returned verdict belongs only inside the markers below.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

```text
MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_AUDIT_VERDICT: ACCEPT_AS_IS
PROMOTION_AUTHORIZATION: YES
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

IMPLEMENTATION_EVIDENCE_RESULT: PASS
MANUAL_SMOKE_RESULT: PASS
CANDIDATE_MODEL_RESULT: PASS
CURRENT_STYLE_RESULT: PASS
SHAPE_RESULT: PASS
SIZE_RESULT: PASS
ROTATION_RESULT: PASS
HIT_TEST_RESULT: PASS
DIRTY_STATE_RESULT: PASS
RETENTION_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:
- NIT-1: the masked-artifact “value token” rule is under-specified about
  surrounding backticks; the published anchor is correct and independently
  reproduced.
- NIT-2: the test map is 241 lines, above the 120–220 target band but below
  the 300-line action threshold.
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, map/index, and route-owner files were checked
- no touched file asserts this LOCK's own acceptance, staging, commit, push,
  or audit-pipeline position
- implementation audit/manual-smoke evidence is explicitly attributed to the
  already pushed two-file implementation rather than this docs/map diff
- generic audit -> bounded recording -> exact staging policy is distinguished
  from claims about this pass
- the new ledger Status is the neutral factual value `LOCK RECORD`; it carries
  no current audit or staging claim
- exactly one matching ledger row and exactly one designated verdict block
  exist
