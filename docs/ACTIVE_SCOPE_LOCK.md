# Active Scope Lock

## Current docs-only closeout pass

`V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT / PROTECTED_UI_PROJECT_HOME

## Closeout source

- Accepted/pushed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Full implementation SHA: `5691e8de78b46cb45859337e089b84f206c2831b`.
- Accepted/pushed active-lock sync: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS` at `e6a5329` (`docs: arm Project Home dark EDA shell implementation`).
- Accepted/pushed scope-lock: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS` at `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Accepted/pushed design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Claude Code is temporarily unavailable for this closeout.
- Review status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.

## Runtime/test active-lock release

The prior runtime/test implementation allowlist for `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` is released by this closeout.

This closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS.md`

No runtime, test, asset, schema, writer, materializer, validator, projection, event, fact, sample, platform, generated, `_incoming`, or scratch file is authorized by this closeout.

## Accepted implementation evidence

- Implementation files changed:
  - `lib/features/project/screens/project_overview_screen.dart`
  - `test/widget/project_overview_screen_test.dart`
- Manual smoke: PASS.
- Manual smoke evidence: Project Overview / Workbench Home opens normally; dark EDA shell visual polish is visible; raw/debug fixture IDs were removed from the main shell; `Töölaud nr 1` appears as display-only UI; board/workbench preview remains dominant; existing action/navigation buttons remained available; Board Canvas opens normally; Measure Sheet save path was unchanged; disabled/future tools remained inert; no Board Canvas save/write/canonical behavior appeared; no canonical nets, pin mappings, electrical proof, or facts were implied by visuals.
- Temporary secondary review: ChatGPT Pro secondary review accepted staging after validation and user manual smoke PASS.
- No Claude audit is claimed.

## Accepted behavior recorded

- Project Overview / Workbench Home received the first dark EDA shell visual polish slice.
- Scope stayed on `ProjectOverviewScreen` / Workbench Home.
- Header was cleaned.
- `Töölaud nr 1` was added as display-only UI.
- Raw fixture/debug/projection metadata was removed from the visible main shell.
- Board/workbench preview remained dominant.
- Existing route/navigation/action behavior was preserved.
- Board Canvas was not migrated.
- Global dark theme was not started.
- Logo/runtime assets were not added.
- `_incoming` HTML/CSS and the standalone dark Project Home HTML remain `DESIGN_INPUT_ONLY`.
- No runtime dependency on `_incoming` exists.
- No canonical facts, measurements, nets, pin mappings, package identity, electrical proof, fault evidence, AI/OCR/CV facts, or write behavior were introduced.

## Preserved boundaries

- Project Overview / Workbench Home visual polish remains local UI presentation only.
- Existing BenchBeep Home launcher behavior remains preserved.
- Existing `Open existing` behavior remains preserved.
- Existing `Import project` behavior remains preserved.
- Existing Back/Home behavior remains preserved.
- Existing Menu System behavior remains preserved.
- Existing Board Canvas behavior remains preserved.
- Existing Measure Sheet save behavior remains preserved.
- Existing `/project/measure-sheet` direct/fallback compatibility remains preserved.
- Existing Add Component behavior remains preserved.
- Existing disabled/future tool inertness remains preserved.
- BenchBeep remains the user-facing app/product name.
- TraceBench remains the repository/platform/project name.
- BoardFact remains the data-fact/subsystem name.

## Design source status

The dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not stage them. Do not edit them. Do not copy them into runtime assets. Do not import or bundle them. Do not depend on `_incoming` at runtime. Do not infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, route behavior, or AI facts from them.

## Explicitly forbidden

- Editing `lib/` or `test/` in this closeout.
- Editing `_incoming`, assets, samples, platform files, generated files, or unrelated docs.
- Arming a new implementation pass.
- Claiming Claude audit or Claude acceptance.
- Claiming Board Canvas save/write is accepted.
- Claiming canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual traces, From -> To context, prototype route labels, prototype net labels, or prototype legend labels into confirmed connectivity.
- Adding logo/runtime assets, Google Fonts, external font dependencies, global dark theme, Board Canvas dark EDA migration, global redesign, command menu, context menu, audio/save beep, or canvas token migration.

## Route

- Current route owner: `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Current docs-only closeout pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS`.
- Route after this closeout is accepted/pushed: `NEEDS_USER_DECISION`.
