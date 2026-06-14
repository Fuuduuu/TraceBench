# V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / FLUTTER_UI_LAYOUT_POLISH` is the correct lane after `V2_WORKBENCH_HOME_SHELL_PASS` and after the implementation closeout was accepted.

## PASS metadata

- PASS_ID: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`
- Type: implementation
- Lane: `CODEX / FLUTTER_UI_LAYOUT_POLISH`
- Mode: narrow Workbench Home layout proportion polish

## AGENTS/skills usage note

- Read `AGENTS.md` and active governance docs (`docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/WORK_INTAKE_INDEX.md`).
- Repo-local skills used:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
- No MCP/plugin/tool install, dependency/configuration change, download, or external-tool setup was performed.

## Tool / plugin / download capability report

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- Flutter tooling: available and used for tests
- Python: YES
- plugin/MCP/plugin-install/download/update: NOT USED

## Manual user-surface feedback

- User message: “palju parem. Viimasel pildil panin täpsustused. Punased osad väiksemaks ja roheline osa suuremaks”.
- Interpretation: reduce header/context prominence, reduce right action rail and card footprint, and make the central workbench/read-only board area larger and dominant.

## Baseline/implementation summary

- Baseline is the accepted `V2_WORKBENCH_HOME_SHELL_PASS` at `3f133a5` (`feat(project-overview): add workbench home shell`).
- Current implementation pass applies only layout balancing to `lib/features/project/screens/project_overview_screen.dart` and matching widget-test guardrails.
- The top/context header and spacing were compacted.
- The central workbench/canvas/placeholder height and flex priority were increased.
- Right action rail width, card paddings, section gaps, and grouping spacing were compacted.
- Statistics chip visuals were reduced in visual weight.
- Secondary actions and future-tool presence were kept reachable/inert.

## Files changed

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS.md`

## Tests updated

- `test/widget/project_overview_screen_test.dart`:
  - added/updated assertion for wide layout dominance (`overview-workbench-zone` area wider than action panel)
  - retained existing action-route, reachability, inertness, and zero-event/read-only assertions

## Test coverage evidence

- Existing zero-event render/navigation assertions remain:
  - `overview shell does not mutate project events on render or measurement navigation`
  - route/action key presence checks
  - future tools `onPressed == null`

## Route/key preservation proof

- `overview-measurement-record-button` still routes via `/project/measure-sheet`.
- `overview-board-graph-button` still routes via `/project/graph`.
- Legacy compatibility contract remains preserved:
  - `/project/measurements/new` compatibility redirect to `/project/measure-sheet`.
- Existing action keys for add/edit/component graph/canvas/reference images remain present.

## Zero-event/read-only proof

- `test/widget/project_overview_screen_test.dart` validates no event-id change when invoking measurement action route from the overview shell.
- `ProjectOverviewScreen` still renders from in-memory `ProjectState` and does not call writer/event/model APIs.
- `Workbench` rendering remains read-only.

## Future tools inertness proof

- `overview-future-contour-button`, `overview-future-photo-button`, `overview-future-layers-button`, and `overview-future-trace-colors-button` remain present with `onPressed == null`.
- `test/widget/project_overview_screen_test.dart` asserts inertness for all four future-tool buttons.

## Scope drift check

- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` now point to:
  - Current pass: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`
  - Next: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_POST_AUDIT_PASS`
- `docs/AUDIT_INDEX.md` pointer was updated with current status set to this pass.
- Allowlist and forbidden surfaces match requirements for this layout pass.
- No Board Canvas renderer, writer/service/sequence/writer/event-schema/projection/materializer/validator edits were introduced.
- No project ZIP/reference-image runtime/AI/OCR/CV/Photo Markup/Repair Map/Visual Trace Shape Assist changes were introduced.

## Validation requirements

- `flutter test test/widget/project_overview_screen_test.dart`
- `flutter test`
- `py -3 tools\validate_all.py`
- `git diff --check`
- `git status --short --branch`
- `git diff --name-status`

## Route decision

- Current pass: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`
- Next recommended pass: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_POST_AUDIT_PASS`

## Verdict

PASS if layout compactness increases for non-focal UI regions, central workbench dominance increases, route/key contracts remain unchanged, future tools remain inert, zero-event/read-only behavior remains, and validation surfaces pass.

## safe_for_audit

YES

### exact explicit staging commands (if safe_for_audit == YES)

- `git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS.md lib/features/project/screens/project_overview_screen.dart test/widget/project_overview_screen_test.dart`
