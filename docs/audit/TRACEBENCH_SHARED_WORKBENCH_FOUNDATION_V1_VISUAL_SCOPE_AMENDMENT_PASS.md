# Shared Workbench Foundation v1 visual acceptance scope amendment

PASS_ID: `TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_VISUAL_SCOPE_AMENDMENT_PASS`
Lane A / `DOCS_SCOPE_AMENDMENT_ONLY`. Entry baseline:
`073d53dfb4865e0f02df5b844b418bb3f0ef2324`.

## Authority, supersession and historical evidence

The human decision of 2026-10-25 requires a coherent Board Canvas ->
WorkbenchShell -> Photos -> Project Overview visual system, using the actual
warm black/gold Board Canvas Workbench screenshot as the visual reference.
The previous warm-Photos/cool-Shell temporary mismatch is withdrawn as a final
Foundation v1 acceptance outcome. Strategy C and separately audited scopes remain.

This amendment supersedes only the original scope's six-path size, shell/
Overview freeze, WorkbenchPage-only theme application restriction to the extent
needed for isolated shell chrome, and temporary visual-mismatch acceptance.
The human-selected Option A also supersedes the Canvas-host freeze only for the
opened `board_canvas_project_menu` popup and necessary local shared-theme import.
Only that opened navigation popup may change visually. The closed instrument
bar and all other Canvas appearance and behavior remain unchanged.
All compatible preservation, contrast, no-write, tooling and validation clauses
remain binding. The original artifact
`docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_SCOPE_LOCK_PASS.md`,
its filled verdict, findings and existing ledger row remain byte-identical
historical evidence; scope acceptance did not certify implementation appearance.
Its accepted LOW F1 controls provisional Code Map qualification.

The human reports visual acceptance FAIL for the existing six-file child draft,
prior automation 851/851, and no initiated Claude implementation audit. Local
prior logs support 851/851; this is attributed child evidence, not a test result
of this docs amendment and not a visual PASS. Preserve useful foundation work.
The current docs authority derives from the human amendment instruction,
AGENTS/POHIKIRI, the three operational owners, AUDIT_CONTRACT and the existing
docs-only scope-revision precedent. No protected semantic change is authorized.

## Exact current five-doc material

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_VISUAL_SCOPE_AMENDMENT_PASS.md` (new)

Only leading route fields/new current sections, three predecessor heading
labels, one neutral ledger row and this artifact may change. Preserve all
predecessor bodies, old ledger rows/cells/separators and historical artifacts.
No runtime, test, map/index, tool, fixture, asset, package or platform change
belongs to this docs phase. The external smoke harness is also unchanged here.

## Isolated worktree and preservation contract

Entry primary checkout: `C:\dev\TraceBench`, main, correct
`https://github.com/Fuuduuu/TraceBench.git` remote, HEAD == origin/main == the
baseline above, divergence 0/0, staged/unmerged empty, exactly the six original
child paths modified/new. All six matched the prior validated local snapshot.

The Codex managed-worktree tool returned `Not a git repository` for the chat's
project-memory mirror. The standard Git fallback created a clean detached
worktree at `C:\dev\TraceBench-foundation-visual-scope` using:
~~~powershell
git --no-pager -C C:\dev\TraceBench worktree add --detach C:\dev\TraceBench-foundation-visual-scope 073d53dfb4865e0f02df5b844b418bb3f0ef2324
~~~
The primary main branch and checkout remain the implementation owner. Detached
baseline identity is intentional isolation, not another main checkout. The
clean worktree contains committed source; it does not contain the two new Dart
files or other child draft changes. Do not copy the child into this docs diff.

Local external entry manifests capture every one of the 1080 primary tracked/
nonignored files, primary status and tracked diff, six complete child files,
and all 1078 clean-isolation entry files. Completion requires identical primary
raw bytes/status/tracked diff and an isolated diff containing only five docs.
Do not stash, reset, clean, restore, discard or overwrite the primary draft.

The following are local `worktree` SHA-256/byte observations, not durable
cross-clone anchors. They freeze the pre-existing child during this amendment.
Exact measurement command (PowerShell, primary checkout):
~~~powershell
$paths = @(
  'lib/shared/theme/app_theme.dart'
  'lib/features/board_canvas/theme/board_canvas_palette.dart'
  'lib/shared/widgets/workbench_page.dart'
  'lib/features/photos/screens/photo_list_screen.dart'
  'test/widget/photo_list_screen_test.dart'
  'test/widget/workbench_page_test.dart'
)
foreach ($path in $paths) {
  $fullPath = Join-Path 'C:\dev\TraceBench' $path
  $item = Get-Item -LiteralPath $fullPath
  $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $fullPath).Hash.ToLowerInvariant()
  "$path`t$($item.Length)`t$hash"
}
~~~

| Preserved child path | Representation | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| `lib/shared/theme/app_theme.dart` | `worktree` | 17985 | `b3c6d6786059f48274b228bb05b64660d1854de34e1235514ca4f91feab0c9de` |
| `lib/features/board_canvas/theme/board_canvas_palette.dart` | `worktree` | 854 | `1f25280539ba0469604231532e6dd713565032f4b462c1f5d1625e1b3310b556` |
| `lib/shared/widgets/workbench_page.dart` | `worktree` | 2493 | `ef7779de556ff94cc3f81432a57e6c7116d601a1302a95c0a64319a7c02b4151` |
| `lib/features/photos/screens/photo_list_screen.dart` | `worktree` | 6136 | `c253389522068a11350f8a48a1770b6eaf671b6869f03538d3e3e40e76156056` |
| `test/widget/photo_list_screen_test.dart` | `worktree` | 18793 | `f9d80987cd2e2ea3634a8da48d9f942e177bc7195d12684461df00d61c5d9916` |
| `test/widget/workbench_page_test.dart` | `worktree` | 18911 | `5cd43f78a5a5e11c45cc3ec30d3a59b39eff3b0fe58579d501b8b6d9ce56bd75` |

## Exact resumed implementation boundary: eleven paths

Reserve the same single `TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_IMPL_PASS`,
Lane A / FLUTTER_PRESENTATION_FOUNDATION, as a continuation of its retained
draft. Do not repeat or discard the six-file work. No second implementation
child, RECON, architecture review, automatic map pass or extra preparatory pass.

1. `lib/shared/theme/app_theme.dart` (existing child)
2. `lib/features/board_canvas/theme/board_canvas_palette.dart` (existing child)
3. `lib/shared/widgets/workbench_page.dart` (existing child)
4. `lib/features/photos/screens/photo_list_screen.dart` (existing child)
5. `test/widget/photo_list_screen_test.dart` (existing child)
6. `test/widget/workbench_page_test.dart` (existing child)
7. `lib/features/project/widgets/workbench_shell.dart` (added)
8. `lib/features/project/screens/project_overview_screen.dart` (added)
9. `test/widget/workbench_shell_test.dart` (added)
10. `test/widget/project_overview_screen_test.dart` (added)
11. `lib/features/board_canvas/screens/board_canvas_screen.dart` (opened navigation popup only)

No twelfth repository path is authorized. These owners contain the theme,
frame, Photos, shared chrome/navigation rendering, Overview and focused tests;
no router/app/global-theme/helper-file change is required. Stop and report if
implementation proves that another path or protected behavior is necessary.

### Changed zones and implementation sufficiency

- Shared theme/page: retain reusable warm values and complete dark ThemeData,
  accessible role/state styling, isolated builders, bounded width, caller-owned
  slots, empty content and one scroll owner. Refine typography and panel/control
  hierarchy using existing Flutter Material; no parallel design-system framework.
  Keep the entire baseline BenchBeepVisualTokens class, darkInstrument and
  buildTheme() bytes/behavior unchanged. Shared code imports no feature.
- Canvas palette: only the already justified 13 exact const aliases; preserve
  every original literal value/name/type, the fixed-literal plus alias tests,
  and every Canvas pixel outside the opened navigation popup, rendering, closed
  instrument chrome, controls, selection/drafts and workflows.
- Canvas host: only the existing `board_canvas_project_menu` opened popup
  background/border, text/icon colours, checked/selected presentation, hover and
  keyboard-focus states, and contrast/accessibility styling may change. A local
  shared-theme import is allowed only as necessary for those popup styles.
  Preserve the popup key/tooltip, every `workbench-destination-<id>` item key,
  all twelve destination entries/order/labels/locations, checked semantics and
  existing `context.go` routing. Do not restyle its closed trigger or ancestor
  theme. Closed instrument bar, Canvas rendering/controls/painters/geometry and
  all workflows remain visually and behaviorally unchanged. All thirteen palette
  values and the entire Canvas test file, including P0/C0/M0/I0, remain fixed.
  Add any popup-style regression assertions only inside the already listed
  `test/widget/workbench_shell_test.dart`; no additional test path.
- Shell: change only WorkbenchShell chrome, _WorkbenchBreadcrumb,
  _BreadcrumbSeparator, _WorkbenchNavigation and _WorkbenchDestinationTile
  presentation. Apply warm theme/roles narrowly to shell-owned header/navigation/
  drawer controls. Keep the router-supplied legacy child in its original ambient
  theme; wrapping the complete Scaffold and implicitly restyling children fails.
  Freeze WorkbenchShellColors values and WorkbenchDestinationSurface declaration
  byte-identically. Their six legacy consumers retain their content presentation.
- Overview: opt into the shared warm content boundary; rework only local panel,
  action, tag, typography and interaction-state presentation. Keep one scroll
  owner, existing data/filter/clamp math, preview geometry and honest read-only
  meaning, counters, exactly one unchanged freshness banner, three workflow
  routes and all four disabled future actions. It remains a summary, not a
  second Board Canvas or an authoring surface.
- Photos: distinguish record heading, path/metadata, counts and advanced detail
  groups; use coherent panel spacing/weight rather than colour substitution.
  Preserve every original field, plain exact path Text run, order, relationship,
  mode-hidden detail, empty/no-project copy and exactly one unchanged freshness
  banner. Empty fresh Photos still contains no Card. No import/file loading,
  search, editor, alignment or canonical action is added.
- Tests: retain all existing helpers/fakes and behavioral/no-write oracles.
  Existing shell/Overview expectations may be retargeted only for authorized
  visual colour/typography/chrome structure; do not delete or weaken route,
  provider/element/State identity, Home close/mode, geometry, freshness, counters,
  inert-control, writer/fact/event/file guards. Append focused visual/state/theme
  isolation coverage within the four listed test files. Preserve all six original
  Photos cases/helper bytes and the entire frozen Canvas test file.

The human explicitly authorizes this coherent future multi-zone presentation
combination. It changes global secondary chrome but only Photos/Overview content.
All twelve destination entries, order, IDs, labels/paths and active-parent mapping,
all 15 real routes/two redirects, gate order and Canvas shell bypass stay fixed.
Keep Home's existing closeProject-before-go behavior and separate mode lifetime;
no new Session mutation. Preserve shell 1228/244 and Overview 960 responsive
contracts; validate routed six-width monotonic behavior and accessible scaling.

Preserve all eleven existing WorkbenchShell/widget-surface keys (ten literal
keys plus the destination-item key template), including conditional presence:

1. `workbench-destination-surface`
2. `workbench-shell`
3. `workbench-shell-app-bar`
4. `workbench-compact-menu-button`
5. `workbench-home-button`
6. `workbench-beginner-mode-button`
7. `workbench-compact-drawer`
8. `workbench-compact-navigation`
9. `workbench-wide-navigation`
10. `workbench-breadcrumb`
11. `workbench-destination-${destination.id}`

Preserve existing wide/compact/drawer lifetime and Canvas-route absence semantics
for shell-only widgets: destination surface, shell Scaffold/AppBar, breadcrumb,
wide navigation, compact menu/drawer/navigation remain absent on Canvas. Home,
beginner-mode and destination-item keys are reused by Canvas; do not assert
their absence globally. Opening the Canvas popup retains its twelve item keys.

## First-stage visual acceptance and later content modernization

Reference: the actual human-supplied `Screenshot 2026-10-24 115721.png` Board
Canvas Workbench capture (with the supporting actual Canvas screenshots), not
synthetic geometry or an Overview thumbnail. Source palette/renderer at the
baseline anchors its existing appearance. The local reference is visual input,
not a runtime asset to copy, package or edit. If unavailable for human review,
report unavailable rather than substitute a synthetic reference.

Verified local external reference paths (not repository assets):

- Actual human Canvas screenshot:
  `C:\Users\TRUMPIT\Pictures\Screenshots\Screenshot 2026-10-24 115721.png`.
  Raw local-file (`worktree` representation) SHA-256:
  `8a34b39ad683443c7607c6466d81f4f427539a028179248d438ee983adbe0547`.
  Reproduce: `(Get-FileHash -Algorithm SHA256 -LiteralPath 'C:\Users\TRUMPIT\Pictures\Screenshots\Screenshot 2026-10-24 115721.png').Hash.ToLowerInvariant()`.
- External smoke harness:
  `C:\Users\TRUMPIT\AppData\Local\Temp\TraceBench-foundation-impl-rhi2bor1\windows_smoke.dart`.
  Verified present and inspected locally; preserve its bytes during this patch.

These machine-local observations identify the actual input and external defect
owner; synthetic preview content cannot substitute for this screenshot.

Acceptance requires a visibly coherent transition across real Canvas, shared
shell, Photos and Overview: warm near-black surfaces, cream hierarchy, gold
navigation selection/controls, compact instrument-style headers, clear section
weights, coordinated panel outlines/spacing and understandable disabled/focus
states. Consolidate redundant global title/breadcrumb chrome inside the existing
shell owner while retaining one shell AppBar, breadcrumb context/key and all
navigation semantics. Do not add page AppBars or copy Canvas workflow modules.

The remaining legacy destination content is deliberately outside this first
stage. Its inherited content appearance is preserved even as shared outer chrome
becomes warm. Modernizing those contents requires later human-selected bounded
scopes; none is reserved here. This distinction replaces the withdrawn agreement
that a cool shell was an acceptable final wrapper around warm Photos.

All original contrast contracts remain: normal text >=4.5:1; essential boundaries
>=3:1 against relevant inside/outside surfaces after alpha compositing; accessible
outline; no low-contrast Canvas dim body text; warning F6C453 and danger
EAA6A6/FCA5A5 with 211417/493039 tints; dark foreground on gold fills. Test actual
text/background, border/surface and enabled/disabled/hover/focus/pressed/selected
roles, including shell navigation, Overview actions/tags, Photos metadata and
freshness secondaryContainer/onSecondaryContainer, tertiaryContainer/
onTertiaryContainer and surface/outline/onSurface. Retain non-colour cues,
keyboard semantics and 1.5x wrapping. Do not copy inaccessible Canvas rules
as essential borders to achieve superficial pixel similarity.

## External harness prerequisite and human gate

The external `windows_smoke.dart` Controls branch substitutes Controls for the
MaterialApp.router builder's router child, putting those controls outside the
Navigator/Overlay ancestry. Correct this in the external harness during future
smoke preparation by mounting controls below a real Navigator/Overlay. Do not
add an Overlay owner to WorkbenchPage or change production routes to compensate.
No harness correction or other runtime work occurs in this docs phase.

Clearly separate external controls/synthetic fixture labels from the production
preview. Compare the real Board Canvas on a suitable actual project; synthetic
harness data and Overview's simplified preview are not its appearance oracle.
A fresh human smoke must cover Canvas -> Photos -> Overview round trips,
wide/compact including 959/960/1227/1228/1229/1500, all 12 destinations and
workflow-parent navigation, Home/mode semantics, empty/populated, beginner/
advanced, tri-state freshness, long fields/scroll, keyboard focus, 1.5x text,
and popup/dialog/disabled/selected states in the corrected external preview.
Also inspect the actual opened Canvas navigation popup for warm background/
border, readable text/icons/check, hover/focus/selection, twelve unchanged
entries and unchanged routing, then confirm its closed bar and Canvas remain
unchanged. Focused shell-suite assertions cover that bounded popup style seam.
The human's FAIL remains the visual result until a fresh explicit PASS.
Only then may the implementation packet marked USE ONLY AFTER MANUAL SMOKE PASS
be used. A scope audit approves this docs contract only, not the frozen runtime.

## Code Map preflight and lifecycle

Registry verified: 58 maps/58 rows; 56 MAINTAINED, 0 REVIEW_REQUIRED, 2 RETIRED.
The original six targets have no current deterministic map/index entry. At the
committed baseline the original four are below qualification or simple holders;
the two new files are absent. The main checkout's six-file unfinished local
work is excluded from current map creation by CODE_MAP_STANDARD. Requalify each
actual accepted committed result independently, especially WorkbenchPage under
accepted LOW F1; no provisional AUTO statement grants a map or new path.

| Added target | Current map qualification/status | Verified anchor count | Current docs disposition | Future material-change disposition |
| --- | --- | ---: | --- | --- |
| workbench_shell.dart | AUTO, MAINTAINED | 42 | REVIEWED_NO_CHANGE | UPDATE_REQUIRED |
| project_overview_screen.dart | AUTO, MAINTAINED | 34 | REVIEWED_NO_CHANGE | UPDATE_REQUIRED |
| workbench_shell_test.dart | SCORE 8/12, MAINTAINED; 11 declarations | 41 | REVIEWED_NO_CHANGE | UPDATE_REQUIRED |
| project_overview_screen_test.dart | SCORE 7/12, MAINTAINED; 19 declarations | 32 | REVIEWED_NO_CHANGE | UPDATE_REQUIRED |
| board_canvas_screen.dart | AUTO, MAINTAINED; 6569 lines, 3+ responsibilities | 77 | REVIEWED_NO_CHANGE | UPDATE_REQUIRED |

Each map is at `docs/code_maps/<complete source path>.md`. All 226 literal
responsibility-table anchors resolve in current committed source: the original
four maps contribute 149 and the added Canvas host map contributes 77. Host
zone 11, Instrument bar/local chrome, and impact row Instrument/navigation bound
the added seam: `_buildScaffold`, `board_canvas_project_menu` and
`workbenchDestinations`. Other zone-11 rail/mode/focus/status responsibilities
remain frozen. The current host map accurately describes the single instrument
bar/transient navigation and remains unchanged in this docs patch.
CODE_MAP_STANDARD applies AUTO qualification and UPDATE_REQUIRED to the future
material popup/theme-dependency change; no missing/stale-map blocker is present.
The five maps must later reflect accepted committed visual/theme/test drift in
a separately human-authorized docs-only decision; no map/index edit or automatic
map-maintenance child is authorized here.
Original six current map dispositions: NOT_APPLICABLE. Inspect-only mapped
app/app, app/router, Canvas test, ProjectGate test and ProjectSession remain
REVIEWED_NO_CHANGE; their contracts and sources are frozen.

Changed Dart responsibility zone now: none. Future exact symbol zones are listed
above; direct dependencies are Flutter Material theme/layout, existing provider
reads, KnownFacts/PhotoFact/placements, unchanged freshness banner and existing
router navigation. Presentation/derive paths ZERO_WRITE, navigation/mode/scroll
UI_LOCAL, existing Home close PROJECTION_STATE only. No canonical write added.
[D] current call sites prove the owner split. [P] future theme blast radius is
shell chrome across secondary pages, Photos/Overview content and the opened
Canvas navigation popup alone; preserve
legacy child inheritance and legacy token/wrapper bytes to bound that radius.

## Baseline identities

These are durable `blob` object IDs for the entry baseline. Reproduce with
`git --no-pager rev-parse 073d53dfb4865e0f02df5b844b418bb3f0ef2324:<path>`;
read bytes with `git --no-pager cat-file blob <baseline>:<path>`.
ABSENT_AT_BASELINE denotes a planned new file, not a missing dependency.

| Source/evidence path | Representation | Baseline object identity |
| --- | --- | --- |
| `lib/shared/theme/app_theme.dart` | `blob` | `a7cf385a6281eeb58227c610366f05f24c01547a` |
| `lib/features/board_canvas/theme/board_canvas_palette.dart` | `blob` | `4e3162c349c2c5facb8fdfa2e89767b2dc384126` |
| `lib/shared/widgets/workbench_page.dart` | `blob` | `ABSENT_AT_BASELINE` |
| `lib/features/photos/screens/photo_list_screen.dart` | `blob` | `d75740550154c8e887c4b8cd029492d9156584bc` |
| `test/widget/photo_list_screen_test.dart` | `blob` | `ba3a7d84124beeb639f15ed308e970fc3cc1aa1a` |
| `test/widget/workbench_page_test.dart` | `blob` | `ABSENT_AT_BASELINE` |
| `lib/features/project/widgets/workbench_shell.dart` | `blob` | `94955248075b212d16a498ffd1d2cfb956606717` |
| `lib/features/project/screens/project_overview_screen.dart` | `blob` | `53b188a991e7ee10d0e56f9e6141979dc69ee410` |
| `test/widget/workbench_shell_test.dart` | `blob` | `7a0c12cebcb4befe5cda8213a0927e915d70918d` |
| `test/widget/project_overview_screen_test.dart` | `blob` | `97ed74701245f615827f1db91832919694dbb343` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `blob` | `e0dd607c47d68038c36a8438a10b04963e71a41b` |
| `test/widget/board_canvas_screen_test.dart` | `blob` | `9eac9aff9193b57649ef450375824519b9113cb3` |
| `lib/app/app.dart` | `blob` | `35af744b1f9ebbf337110600e2998886f5263af0` |
| `lib/app/router.dart` | `blob` | `d01b9ab5df3ad61ad79b3f4ed57cd743b4daa1f5` |
| `lib/features/project/widgets/project_gate.dart` | `blob` | `98a3cc662e8b74f2466ec983e742c839fa6e9ecf` |
| `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_SCOPE_LOCK_PASS.md` | `blob` | `283343b9959471ad987bd73177fa122ac2c88497` |

## Frozen surfaces and stops

Freeze all primary-checkout bytes during this amendment, all nonallowlisted
isolated bytes, original scope/verdict/ledger/history, all maps/index and all
runtime/tests/packages/tools/fixtures/assets/platform outputs. Future child
freezes global app/buildTheme/BenchBeepVisualTokens/ProjectGate, router and exact
inventory/mapping/callback semantics, WorkbenchShellColors and legacy surface,
other destination content, Canvas host except its opened navigation popup and
necessary local shared-theme import, all Canvas workflow/rendering/geometry/modules and
P0/C0/M0/I0 oracles, writers/Session/providers/canonical events/facts/projections,
ZIP/evidence/repair semantics, all packages, fonts/assets, schemas and tools.
Only the original 13 value-identical palette aliases and the narrowly bounded
opened navigation popup are Canvas exceptions. All thirteen values, closed
instrument bar, other Canvas pixels and the entire Canvas test file stay fixed.

Stop for a twelfth runtime/test path, sixth current docs path, failed anchor/
map conflict, changed palette/global theme/legacy inheritance, missing field,
weakened oracle, new canonical action, required-map obligation that cannot follow
the accepted-committed lifecycle, unavailable locked packages, unexpected files,
or inability to preserve the primary draft. Report exact paths/commands; never
silently revert. No dependency restore/pub get, install or network authorization.

## Validation and activation sequence

Current docs validation: exact five-doc material, baseline/remote/main and clean
isolation entry (detached), primary 1080-file/status/diff freeze, isolated foreign
bytes, inverse owner/ledger/history proof, original artifact identity, map/index
parity/226 anchors, literal palette and exact-eleven set, both git --no-pager diff
checks, doctor, binding temporary-output validate_all, LF/trailing-space/EOF and
SELF_REFERENCE_AUDIT. No Flutter/analyzer/native smoke run belongs to this phase.

Future child: preserve/reuse the retained draft, refresh process PATH and use
Flutter 3.44.9 / Dart 3.12.2 at C:\dev\flutter-tracebench\bin if available.
Run baseline shell/Overview/gate evidence before added-path production edits.
Run focused four allowed widget suites, Photos end-to-end and freshness widget/
end-to-end, unchanged ProjectGate and full Canvas, full Flutter and analyzer,
doctor, temporary-output validate_all, both Git checks and raw freeze. Only the
three inherited analyzer infos are permitted; report actual exit/diagnostics.
Use `--no-pub` for every Flutter command and `python -X utf8 -B`; stop on missing
locked Pub packages. Do not restore them without separate authorization.

Temporary-output validator (scope and resumed child):
~~~powershell
$env:PYTHONDONTWRITEBYTECODE = '1'
@'
import runpy,tempfile
from pathlib import Path
ns = runpy.run_path('tools/validate_all.py', run_name='foundation_amendment_validation')
with tempfile.TemporaryDirectory(prefix='tracebench-foundation-amendment-validation-') as temporary:
    for fixture in ns['VALIDATION_FIXTURES']:
        fixture['known_facts_out'] = Path(temporary) / (fixture['name'] + '.json')
    raise SystemExit(ns['main']())
'@ | python -X utf8 -B -
~~~

Independent scope audit uses scope-lock-post-audit on only these five docs.
Exactly one empty verdict block below and the neutral new AUDIT_INDEX Status
cell (`—`, not a map-review status) are
the only later recording coordinates after independent result and express
bounded recording authorization. Markers, Description and all other bytes freeze;
prove inverse SHA-256/raw-byte equality and verdict/ledger agreement.

After accepted bounded recording, human-only exact staging/commit in the isolated
checkout creates the docs-only commit. With primary HEAD still at baseline,
unchanged six-file bytes/status, empty staged/unmerged sets and disjoint paths,
the human may fast-forward primary main to that exact docs commit using
`git --no-pager -C C:\dev\TraceBench merge --ff-only --no-autostash <accepted-docs-commit>`.
Immediately before and after that integration, verify all six original files
against their raw-byte/SHA-256 snapshot, compare the exact tracked six-path
`git --no-pager diff --binary -- <six-original-paths>` output and porcelain
status, and verify staged/unmerged sets remain empty. Stop on any difference;
the docs-only commit may change docs, never the protected implementation diff.
Only after that verification may the human push main. Git must refuse rather
than be forced if any precondition differs. No auto-stash or cleanup. If the
fast-forward cannot preserve the draft, stop for a human Git procedure.
No such integration/staging/commit/push occurs in this docs phase.

Only independently accepted, recorded, human-committed/pushed and integrated
amendment authority permits continuation of the same eleven-path child. Verify the
then-current docs commit and origin alignment, not the superseded entry HEAD.
No routine active-lock sync is needed. After that single child: NEEDS_USER_DECISION.

## TOOL_SKILL_CHECK and self-reference

- relevant skill/tool/helper found: three repo skills, Git worktrees/rg/Python,
  maintained maps, doctor, temp-output validator and existing regression helpers.
- capability actually used: tracebench-scope-lock and tracebench-prompt-authoring;
  using-git-worktrees with documented unavailable native context and safe fallback;
  raw/blob/inverse verification and local docs validation.
- why applicable: one bounded docs-only visual scope amendment preserving a
  foreign implementation draft and preparing its real-diff scope audit.
  Audit-reconciliation does not apply; no pushed implementation verdict exists.
- external tool required: NO. No network/install/cloud or additional MCP required.

SELF_REFERENCE_AUDIT checks only new current sections, this artifact and the new
ledger row; generic future gate instructions and attributed prior-child evidence
are distinct from this amendment's own pipeline position. Old history is fixed.

## Independent scope verdict

<!-- SHARED_WORKBENCH_FOUNDATION_V1_VISUAL_AMENDMENT_VERDICT_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES — after Phase 2 recording
PHASE_2_RECORDING_AUTHORIZATION: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_VISUAL_SCOPE_AMENDMENT_PASS.md

Findings: 0 blockers, 1 LOW, 2 NITs.

LOW G1: The existing AUDIT_INDEX Description still mentions ten implementation paths and four mapped targets. The accepted binding artifact and operational route supersede those numbers: exactly eleven paths and five maintained-map obligations. Do not edit the Description.

NIT G2: Keep the isolated detached worktree until the accepted docs commit has been fast-forwarded into primary main and successfully pushed.

NIT G3: During later implementation, style the Canvas popup without wrapping the closed trigger in a full Theme. Preserve exactly twelve CheckedPopupMenuItem entries, existing keys, selection semantics and navigation.

<!-- SHARED_WORKBENCH_FOUNDATION_V1_VISUAL_AMENDMENT_VERDICT_END -->
