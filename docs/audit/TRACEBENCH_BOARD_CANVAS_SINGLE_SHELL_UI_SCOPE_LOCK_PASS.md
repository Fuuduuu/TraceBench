# Board Canvas Single Shell UI scope

## Identity and authority

- Scope PASS_ID: `TRACEBENCH_BOARD_CANVAS_SINGLE_SHELL_UI_SCOPE_LOCK_PASS`
- Scope Lane / Mode: `A` / `DOCS_SYNC` / `SCOPE_AUTHORING_ONLY`
- Reserved implementation PASS_ID: `TRACEBENCH_BOARD_CANVAS_SINGLE_SHELL_UI_IMPL_PASS`
- Implementation Lane / Mode: `A` / `FLUTTER_PASS`
- Scope-authoring baseline: `main`, `HEAD == origin/main == 6fd9692409fc491c64f26f306f584b531ecae3c1`
- Completed Photo Alignment: `36cd8d9d4a3751ce9760bb1cc649c497b754760b`
- Current authority: the human's explicit scope-authoring request and `docs/ACTIVE_SCOPE_LOCK.md`.

This artifact reserves UI chrome/layout/navigation consolidation only. The
scope does not implement or reopen the approved design. Implementation starts
after independent scope acceptance and exact human scope commit/push, without
an intervening sync pass. Recheck that accepted scope commit and aligned Git
state at implementation start; the source baseline remains the commit above
unless the human supplies a newly accepted baseline.

## Exact current documentation set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md` — this scope's row only
5. `docs/audit/TRACEBENCH_BOARD_CANVAS_SINGLE_SHELL_UI_SCOPE_LOCK_PASS.md`

The scope-lock workflow and `docs/PROMPTING_PROTOCOL.md` call for a scope
record. `docs/AUDIT_CONTRACT.md` requires a ledger row for a new artifact,
one empty designated verdict block, and bounded post-audit recording. There is
no other evidence file, map pass, source edit, or historical cleanup here.

## Approved design and source reconciliation

Design authority: `C:\dev\Board Canvas Single Shell - Design Review (standalone).html`,
title **Board Canvas Single Shell — Design Review**, already approved by the
human. Its embedded HTML template was read directly as visual/product input.
Keep the external file unchanged; do not copy its HTML/CSS/JavaScript, assets,
fonts, sample project values, or design PASS_ID into runtime or repo assets.

The human's narrower task and committed source outrank extra design suggestions:

- Preserve the current palette; this is not a new theme or visual system.
- The current Canvas toolbar constant is 36 px; the design's current-state
  44 px and area-gain figures are illustrations, not measured baseline evidence.
- Use an approximately 44 px instrument bar; no duplicate outer title,
  breadcrumb, destination header, or permanent global sidebar on `/project`.
- Keep `Algaja | Edasijõudnu` legible and accessible. Compact adaptations must
  retain meaningful mode labels; do not rely on unexplained A/E abbreviations.
- Overflow contains existing actions only. New export/settings flows, new
  shortcuts, hover-intent behavior, and new unsaved-draft confirmations are
  excluded. An existing close-project action may reuse Home's exact behavior.
- Secondary-shell bar restyling from the design's final slice is excluded.
  Secondary routes keep the existing shared shell unchanged.
- Six active panel tools and two inactive future tools remain as implemented.
  `Rajad` and `Parandus` stay inactive; neither becomes new functionality.
- Compact rail sizing is presentation-only within the host. Preserve the
  existing rich/compact Canvas behavior and tool reachability; do not import
  the illustration's 1180/1040 breakpoints as unverified runtime requirements.

## Exact future implementation allowlist and owner closure

| Exact file | Allowed responsibility and direct evidence |
| --- | --- |
| `lib/app/router.dart` | `buildTraceBenchRouter` / `ShellRoute` composition: keep `ProjectGate` outermost, omit only the shared `WorkbenchShell` around the active primary Canvas destination. Preserve every builder, path, name, redirect, Home/Wizard seam, and navigation stack. |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `_buildScaffold`, toolbar constants/imports, private instrument-bar/menu presentation, and local responsive framing/tool reachability. Reuse the existing public destination model and existing Home/mode actions; retain Canvas internals and callback semantics. |
| `test/widget/project_gate_test.dart` | `_projectDestinations`, `_pumpRouter`, loaded/null route matrices, aliases, and nested push/pop expectations across the new chrome boundary. Preserve gate/session/file/writer assertions. |
| `test/widget/workbench_shell_test.dart` | `_pumpRouter`, destination controls, workflow/alias and cross-shell navigation tests; preserve secondary-shell identity, responsive, Home, mode, and mutation guards. |
| `test/widget/board_canvas_screen_test.dart` | `_harness`, `_routerHarness`, toolbar, routed width, local-panel/focus, freshness, menu and no-write UI contracts. Preserve existing photo/writer/rendering regression assertions. |

All five files exist at the baseline. No sixth file or new component file is
authorized. The human explicitly approves this coherent multi-zone combination
for the single UI result; it grants no adjacent refactor or canonical scope.

Source-verified inspect-only owners:

- `lib/features/project/widgets/workbench_shell.dart`: public
  `WorkbenchDestination`, `workbenchDestinations`, `activeWorkbenchDestination`;
  existing Home and beginner-mode actions; secondary shell chrome. Import/reuse
  the public model, not a second hard-coded inventory. No production edit needed.
- `lib/features/project/widgets/project_gate.dart`: `ProjectGate.build` reveals
  the child only for loaded state. Preserve recovery outside either shell.
- `lib/app/app.dart`: caller/router lifetime remains unchanged.
- `lib/shared/session/beginner_mode_provider.dart`: existing `StateProvider<bool>`;
  only its existing UI-local value is selected by the relocated mode control.
- `lib/shared/session/project_session.dart`: existing `closeProject()` clears
  loaded state/dedup sets and increments generation. Home keeps this exact
  call followed by `context.go('/')`; no new session behavior or owner edit.
- `lib/shared/models/project_state.dart` and `project_manifest.dart`: existing
  manifest `projectName`/`projectId` are read-only project-chip inputs; no model edit.
- `lib/shared/widgets/projection_stale_banner.dart`: existing freshness display
  remains under the bar; no new refresh action or semantic claim.
- Board Canvas palette, rendering/geometry/part owners, photo panel/services/
  transform/read model/aligned layer, all writers, schemas, and tools are frozen.

The router must distinguish the active matched destination, including nested
`push`/`pop`, rather than blindly treating every `/project` prefix or stale
route-information URI as primary. Keep the existing navigator topology unless
the minimal wrapper change requires a local correction within `router.dart`.
Do not introduce another router, provider scope, or secondary shell. Existing
secondary-to-secondary shell identity remains a regression contract; old tests
requiring the outer shell on Canvas must be updated to the approved exception.

## Locked UI and navigation result

For loaded primary `/project`, Board Canvas is the workbench shell:

- One compact approximately 44 px instrument bar with Home, compact project
  identity/navigation chip, existing write-safety indication, labelled mode
  control, and overflow limited to existing actions.
- Remove the outer 244 px Project sidebar, separate `BenchBeep Workbench`
  header, breadcrumb row, and redundant destination-level Canvas title row.
- The existing `ProjectionStaleBanner` remains conditional, immediately below
  the bar and above the complete work area; it must not disappear into silence.
- The Canvas tool rail is the only persistent vertical rail in wide normal
  mode. Keep Measure, Photos, Add, Inspector, Components/placement focus,
  Safety, and inactive Traces/Repair distinct from global navigation. Preserve
  existing focus-mode hide/restore behavior and all current tool callbacks.
- Canvas receives the reclaimed space; right contextual panel, human-confirmation
  boundary notice, bottom status, `renderer/painter writes: none`, and the
  existing `Renderdus loeb · Salvesta võib kirjutada` meaning remain intact.
- Wide global navigation is a compact popover/menu. Compact navigation may be
  a transient drawer/overlay; opening it does not create a second persistent
  rail. Close on selection/dismissal and preserve keyboard/tooltip accessibility.
- Compact Canvas remains usable with all existing tools reachable, no duplicate
  headers, no RenderFlex overflow, and no lost safety/mode/navigation access.
- Retain loaded zero-component, Wizard-intake, primary-photo alignment, no-photo,
  and normal-component branches. UI changes do not alter their authoring gates.

Reuse all twelve existing model entries and their order:

| Destination | Existing route |
| --- | --- |
| Board Canvas | `/project` |
| Project Overview | `/project/overview` |
| Components | `/project/components` |
| Measurements | `/project/measurements` |
| Pins | `/project/pins` |
| Not populated / Täitamata | `/project/not-populated` |
| Photos | `/project/photos` |
| Reference Images | `/project/reference-images` |
| Graph | `/project/graph` |
| Events | `/project/events` |
| Known Facts | `/project/known-facts` |
| Report | `/project/report` |

Preserve all fifteen real router targets, including Add/Edit Component and
Measure Sheet, plus `/project/board-canvas` and `/project/measurements/new`
redirects. Secondary `/project/*` pages retain the existing shared shell and
return-to-Canvas entry. Home is a separate action, not a new destination.

## CODE_MAP_PREFLIGHT and explicit deferment

Current source changes: none. Source/tests were inspected only to reserve the
zones above. Index lookup shows all six maps below as `MAINTAINED`; the Canvas
pair is materially stale after committed Photo Alignment despite that label.
No current map status or index row is changed or treated as freshness proof.

| Source target | Map path | Relevant inspected / future changed zone | Disposition |
| --- | --- | --- | --- |
| `lib/app/router.dart` | `docs/code_maps/lib/app/router.dart.md` | Route factory, gate/shell composition and canonical Canvas; routes/aliases frozen | `UPDATE_REQUIRED` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` | `_buildScaffold`, local chrome/responsive framing, rail and freshness placement; canonical/photo internals frozen | `UPDATE_REQUIRED` |
| `test/widget/project_gate_test.dart` | `docs/code_maps/test/widget/project_gate_test.dart.md` | Loaded/null route matrix, shell identity and nested navigation | `UPDATE_REQUIRED` |
| `test/widget/workbench_shell_test.dart` | `docs/code_maps/test/widget/workbench_shell_test.dart.md` | Shared navigation and Canvas/secondary boundary evidence | `UPDATE_REQUIRED` |
| `test/widget/board_canvas_screen_test.dart` | `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` | Toolbar/responsive and shell assertions; all domain test families preserved | `UPDATE_REQUIRED` |
| `lib/features/project/widgets/workbench_shell.dart` | `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md` | Public destination/Home/mode ownership unchanged; caller description must reflect primary Canvas bypass | `UPDATE_REQUIRED` |

The dispositions describe expected maintenance after committed implementation,
not edits now. Direct dependencies, test helpers, and exclusions are bounded by
the exact owner-closure and test sections. `[D]` Router wrapper removal changes
the three suites' currently explicit outer-shell expectations; `[D]` the public
destination model can be consumed without editing its owner. `[P]` offstage
stack/lifecycle effects require the locked nested-navigation tests. No speculative
claim expands writes. No new Dart target needs qualification in this scope.

The human's committed bounded deferment remains authoritative: known stale
maps are navigation aids only and are not an implementation blocker for this
UI pass. Verify used claims against committed source/tests and actual diff;
source wins on conflict. Do not refresh maps, add map files, alter statuses,
or edit the registry during scope or implementation. One combined refresh
covers Photo Alignment and Single Shell UI after the latter is committed.
No map-maintenance PASS_ID or intervening prerequisite is created here.

## Write classification and protected boundaries

Allowed new work is `UI_LOCAL` (menus, mode selection, navigation and layout)
plus `ZERO_WRITE` rendering. Relocated Home retains the pre-existing
`PROJECTION_STATE` session-close effect; it performs no event append or file
write. There is no new project/session state, persistence, export, setting,
canonical event, filesystem operation, destination, or draft storage.

Board Canvas contains existing protected writer orchestration; file inclusion
does not authorize those zones. Freeze existing create/edit/placement/measurement
confirm/save methods, generation capture and application, photo import/alignment
callbacks and solvers, primary-source identity, event allocation/retry behavior,
Canvas coordinate transforms, painters, evidence interpretation, and schemas.
Opening/closing chrome, changing mode, resizing, or navigating cannot submit a
writer, mutate events/facts/files, or promote freshness. Preserve Photo Alignment
first-confirm/later-confirm/cancel behavior and pending-session guards unchanged.

`docs/POHIKIRI.md`, `docs/PROTECTED_SURFACES.md`, and existing semantic owners
remain binding. Any required protected change stops this UI pass; do not widen
the lock, silently fix unrelated runtime issues, or reclassify a write as UI.

## Implementation test and manual-smoke contract

Use the existing three allowlisted suites and their seeded sessions, fail-on-call
writers, file snapshots, routed/direct harnesses, and photo regression seams.
Add focused failing UI/routing checks before changing production behavior.
Only obsolete chrome/layout expectations may change; retain their underlying
state, event, file, recovery, alias, and writer protections.

1. Loaded `/project` renders one instrument bar, one Canvas shell and one outer
   gate, with no `WorkbenchShell`, outer Project sidebar, breadcrumb, or
   redundant destination header. Null-project recovery remains shell-free.
2. Home uses the unchanged close-then-go action: project cleared, generation
   invalidated, beginner mode preserved, no event/file write.
3. Both labelled modes function through the existing provider, survive
   navigation, and add no persistent state or writer call.
4. Exercise all twelve project-menu destinations at wide and compact sizes;
   assert exact routes, active selection, menu dismissal, no permanent global
   rail, no event/fact/freshness/file changes, and zero writer calls.
5. Preserve fifteen loaded/null route cases, both aliases, secondary shared
   shell identity where applicable, and `/project` -> push Overview -> pop
   behavior. Verify the top destination receives the correct shell throughout.
6. Keep all existing Canvas tools reachable and two future tools inactive;
   right-context contents, hidden default, selection, focus/restore, and
   human-confirmation notice remain functional.
7. Stale/unknown freshness banners remain immediately under the bar; bottom
   renderer/write-safety status and explicit confirmation boundaries survive.
8. Before production edits, capture `board_canvas_workbench_canvas_zone` size
   in the original routed fixture at 1440x860 and 1500x900. Record the fixture,
   viewport, banner, focus, and context settings so the comparison is repeatable.
   Compare the final layout at identical settings and prove a positive usable-
   area gain. Do not assert the design's unverified 50 percent or retain a
   duplicate old shell implementation merely to manufacture a baseline.
9. Cover 390x844 and widths 899/900, 959/960, 1227/1228/1229, and 1500 at a
   suitable desktop height. Include any new presentation cutover boundaries,
   long project labels, open/dismissed navigation, and open context panel.
   Assert one chrome hierarchy, reachable tools/status/modes, and no overflow.
10. Preserve zero-component, Wizard/photo, alignment, placement, pan/zoom/fit,
    writer, and in-flight project-switch regressions. New chrome interaction
    itself produces no canonical event or filesystem mutation.

Later implementation commands, run sequentially after formatting the exact
five files (no formatter sweep):

```powershell
dart format lib/app/router.dart lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/project_gate_test.dart test/widget/workbench_shell_test.dart test/widget/board_canvas_screen_test.dart
flutter analyze --no-pub
flutter test --no-pub test/widget/project_gate_test.dart test/widget/workbench_shell_test.dart test/widget/board_canvas_screen_test.dart
flutter test --no-pub
py -3 tools\doctor.py
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
```

Record exact five-path material, preserved out-of-scope bytes, empty staged and
unmerged sets, and actual validation outcomes. Human Windows smoke covers wide
and compact chrome, all navigation destinations, Home, both modes, context and
focus, stale status, primary-photo alignment reachability, and usable Canvas
area. Scope smoke is `NOT_APPLICABLE`; implementation smoke is required before
the independent implementation audit. Mark its handoff
`USE ONLY AFTER MANUAL SMOKE PASS`; automation cannot claim human smoke.

## TOOL_SKILL_CHECK

- Found/used: `tracebench-scope-lock` for the reservation and
  `tracebench-prompt-authoring` for the executable contract/audit handoff.
- Tools/helpers: local Git, Python read-only HTML-template extraction and freeze
  checks, `tools/doctor.py`, `tools/validate_all.py`, and existing test fixtures.
- Applicable because this task authors one future exact scope from committed
  ownership. Audit reconciliation and implementation skills are not this phase.
- External tool required: `NO`; no plugin, helper agent, or installation needed.

## Scope validation and stops

Run doctor, full repository validation, both diff checks, route-tuple and
allowlist checks, one-row/artifact linkage, empty-verdict-block validation, and
full out-of-scope freeze checks. Validator-generated fixture outputs may be
redirected to a temporary directory without editing validator source. Check
`CURRENT_STATE.md` size; historical compaction is outside this human-selected
minimum scope and does not insert an extra pass here.

Stop on baseline/route/material mismatch, a sixth current document or future
implementation file, a new runtime file, protected writer/schema/session/photo
semantics, destination expansion, secondary-shell redesign, new product
functionality, failed out-of-scope validation, or inability to preserve the
approved boundaries. No Codex staging, commit, push, reset, stash, clean, or
external design mutation is authorized.

## Independent audit recording

Apply `scope-lock-post-audit` from `docs/AUDIT_CONTRACT.md`. The auditor reviews
the actual five-document diff and verifies source claims without rediscovering
unrelated code. Only after its returned verdict, record that result inside the
block below and mechanically mirror it in this scope row's `Status` cell in
`docs/AUDIT_INDEX.md`. Freeze every other Phase-1 byte; compare the two forms
and exact material set before human staging. No other Phase-2 edit is permitted.

<!-- SINGLE_SHELL_SCOPE_VERDICT_BEGIN -->
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
SAFE_STAGING_SET: docs/ACTIVE_SCOPE_LOCK.md, docs/CURRENT_STATE.md, docs/PASS_QUEUE.md, docs/AUDIT_INDEX.md, docs/audit/TRACEBENCH_BOARD_CANVAS_SINGLE_SHELL_UI_SCOPE_LOCK_PASS.md
No BLOCKER, HIGH, MEDIUM, or LOW findings; three NIT/observation items deferred.
<!-- SINGLE_SHELL_SCOPE_VERDICT_END -->

## SELF_REFERENCE_AUDIT

This artifact and its ledger row describe scope, observed source ownership,
and conditional future gates. They assert no self-audit, acceptance, staging,
commit, or push result. The empty block is the sole later discretionary verdict
location; the one ledger Status cell is its mechanical mirror. Historical
Photo Alignment completion is preserved and grants no renewed writer authority.
