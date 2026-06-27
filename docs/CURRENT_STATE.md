# Current State

## Current pass

`V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_POST_AUDIT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed HEAD verified before this closeout: `3674a69` (`feat(project-overview): polish dark EDA copy`), aligned with `origin/main`.
- Latest accepted/pushed implementation: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS` at `3674a69` (`feat(project-overview): polish dark EDA copy`).
- Full implementation SHA: `3674a69bc2ac44a0e61a1921b2ec6924d2d056fb`.
- Implementation files changed: `lib/features/project/screens/project_overview_screen.dart` and `test/widget/project_overview_screen_test.dart`.
- Manual smoke: PASS.
- Manual smoke evidence: Project Overview / Workbench Home opens normally; Estonian copy-polish is visible in the scoped shell labels; `Plaadi tööala (ainult vaatamine)`, `Teadaolevad faktid`, `Täitamata`, `Tulevased tööriistad`, `Kihid`, `Rajajoone värvid`, and `AINULT VAATAMINE` appear; board/workbench preview remains present; existing action/navigation buttons remained available; disabled/future tools remained inert; Board Canvas opens normally; Measure Sheet save path was unchanged; no Board Canvas save/write/canonical behavior appeared; no canonical nets, pin mappings, electrical proof, or facts were implied by copy.
- Temporary secondary review: ChatGPT Pro secondary review accepted staging after validation and user manual smoke PASS.
- Claude status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Latest accepted/pushed active-lock sync: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS` at `c169a4a` (`docs: arm Project Home dark EDA copy polish implementation`).
- Latest accepted/pushed copy-polish scope-lock: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS` at `10c4561` (`docs: lock Project Home dark EDA copy polish`).
- Latest accepted/pushed design-source intake: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS` at `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Prior accepted/pushed closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Prior accepted/pushed implementation: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Prior accepted/pushed active-lock sync: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS` at `e6a5329` (`docs: arm Project Home dark EDA shell implementation`).
- Latest accepted/pushed Project Home dark EDA shell scope-lock: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS` at `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Prior accepted/pushed design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS` at `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Prior accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_PASS` at `7a5994f` (`feat(board-canvas): deduplicate measure pin leg selector`).
- Prior accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_ACTIVE_LOCK_SYNC_PASS` at `a2f59b0` (`docs: arm Measure panel pin leg selector dedup implementation`).
- Prior accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_SCOPE_LOCK_PASS` at `0575545` (`docs: lock Measure panel pin leg selector dedup scope`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS` at `564582d` (`docs: record Measure panel pin leg selector`).
- Prior accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_PASS` at `d573933` (`feat(board-canvas): add visual pin leg selector`).
- Prior accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS` at `aed1698` (`docs: arm Measure panel pin leg selector implementation`).
- Prior accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS` at `521e5e4` (`docs: lock Measure panel pin leg selector scope`).
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS` at `7a84dcb` (`docs: record Board Canvas app visual polish`).
- Prior accepted/pushed Measure panel visual-density closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Prior accepted/pushed Measure panel target-capture closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25` (`docs: record measurement target capture`).
- Current route is this docs-only closeout for the accepted/pushed Project Overview / Workbench Home dark EDA copy-polish implementation.
- Route after this closeout is accepted/pushed: `NEEDS_USER_DECISION`.
- The implementation target surface was Project Overview / Workbench Home in `lib/features/project/screens/project_overview_screen.dart`, with focused tests in `test/widget/project_overview_screen_test.dart`.

## Current accepted product state

- `BenchBeep` is the user-facing app/product name.
- `TraceBench` remains the repo/platform/project name.
- `BoardFact` remains a data-fact/subsystem name, not the primary user-facing app name unless a specific surface earns it.
- App opens to the BenchBeep Home launcher.
- Home remains a board/workbench launcher, not a marketing landing page.
- `Open existing` opens the existing Workbench context.
- `Import project` uses the existing allowed import/open-project flow and does not route to the legacy start screen.
- Back/home navigation returns to BenchBeep Home.
- Workbench, Project Overview, Board Canvas, Measure Sheet, and Add Component behavior remain preserved.
- Project Overview / Workbench Home received the first dark EDA shell visual polish slice.
- Scope stayed on `ProjectOverviewScreen` / Workbench Home.
- Header was cleaned.
- `Töölaud nr 1` was added as display-only UI.
- Raw fixture/debug/projection metadata was removed from the visible main shell.
- Board/workbench preview remained dominant.
- Existing Project Overview route, navigation, and action behavior was preserved.
- Project Overview / Workbench Home received narrow dark EDA copy-polish.
- Scope stayed on `ProjectOverviewScreen` / Workbench Home.
- Remaining mixed English/Estonian visible shell labels in the scoped cluster were polished toward clearer Estonian copy.
- `Plaadi tööala (ainult vaatamine)`, `Teadaolevad faktid`, `Täitamata`, `Tulevased tööriistad`, `Kihid`, `Rajajoone värvid`, and `AINULT VAATAMINE` are accepted scoped labels.
- Read-only / non-writing meaning remained preserved.
- Disabled/future tool inertness remained preserved.
- Existing route/navigation/action behavior was preserved.
- Board Canvas was not migrated.
- Board Canvas behavior was not changed by Project Home copy-polish.
- Measure Sheet save behavior was not changed by Project Home copy-polish.
- Global dark theme was not started.
- Logo/runtime assets were not added.
- `_incoming` HTML/CSS and the standalone dark Project Home HTML remain `DESIGN_INPUT_ONLY`.
- No runtime dependency on `_incoming` exists.
- No canonical facts, measurements, nets, pin mappings, package identity, electrical proof, fault evidence, AI/OCR/CV facts, or write behavior were introduced.
- Standalone dark Project Home HTML intake is design input only: `RUNTIME_AUTHORITY: NONE`, `CANONICAL_SEMANTICS: NONE`, `IMPLEMENTATION_AUTHORIZATION: NONE`, and `ASSET_AUTHORIZATION: NONE`.
- Inspected standalone HTML path: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark, standalone).html`.
- Embedded image/font/script/style resources in that standalone HTML are also `DESIGN_INPUT_ONLY` and must not be extracted, copied, staged, converted to Flutter assets, imported, bundled, or used as runtime dependencies.
- The standalone HTML does not reopen, override, supersede, or invalidate the accepted Project Overview / Workbench Home implementation.
- Project Overview measurement entry reaches the accepted standalone Measure Sheet flow.
- Existing standalone Measure Sheet route and `/project/measure-sheet` direct/fallback compatibility remain preserved.
- Existing Measure Sheet save behavior remains inside the accepted Measure Sheet flow.
- Board Canvas Measure entry opens an integrated right-side contextual Measure panel in the workbench-shell UI.
- Canvas stays visible while the integrated Measure panel is open.
- Integrated Board Canvas Measure panel supports local UI-only target selection.
- Component visual appears before measured values.
- Measured values are shown as pin/leg rows with inline local draft value/unit controls.
- Integrated Measure panel visual density is polished: header is more compact, local/no-write copy is reduced, measured-value rows are denser and more readable, value/unit controls are more compact, and Continue in Measure Sheet is visually secondary.
- Pin/leg labels are more technician-facing where existing data supports it.
- From -> To context is separate, compact, lower priority, and display/provenance-only.
- Advanced technical/provenance details remain last, quiet, and secondary.
- Measure HTML was used as the primary right-panel workflow reference for the visual-density implementation.
- Board Canvas/app visual HTML was used only as `DESIGN_INPUT_ONLY` visual-language reference.
- `_incoming` HTML/design files are not runtime dependencies and are not canonical repo truth.
- Board Canvas/app visual language is polished.
- Board Canvas shell/chrome/status/read-only presentation is improved.
- Board Canvas remains the dominant visual surface.
- Right panel remains contextual and secondary.
- Existing Add Component and Measure panel visual alignment was polished only where owned by Board Canvas screen.
- Integrated Board Canvas Measure panel now has a local UI-only visual pin/leg selector.
- Duplicate standalone Local visual selector section was removed.
- Measured-value rows remain the primary row/value/unit interaction surface.
- Component visual preview remains the physical visual cue surface.
- Selected measured-value row and visual selector cue stay linked.
- Selected pin/leg state is clearer in the component preview.
- Technician-facing visual labels are improved.
- Missing pin/leg data degrades gracefully without inventing pins.
- Visual selector remains local UI-only.
- No visual pin/leg selection becomes confirmed pin mapping.
- Existing Board Canvas UI state remains local UI-only.
- Dark EDA Project Home / Board Canvas HTML/CSS remains `DESIGN_INPUT_ONLY` and has no runtime authority, canonical semantics, or implementation authorization.
- No disabled/future tool became functional.
- No global redesign or theme migration was introduced.
- Home, Project Overview, router, Measure Sheet, and canonical writer behavior remain unchanged.
- Continue in Measure Sheet compatibility remains preserved.
- Board Canvas does not provide canonical save/write behavior.
- Board Canvas does not write `events.jsonl` or mutate `known_facts`.
- Board Canvas does not import, call, route to, or wire `v2_save_measurement_writer.dart`.
- Accepted Menu System remains the narrow instrument-style menu/app-bar/breadcrumb affordance.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only.
- Board Canvas renderer remains read-only with `renderer writes: none`.

## Protected future direction carried forward

- Functional Board Canvas measurement save/write remains deferred unless a later separate writer scope explicitly authorizes it.
- Any future Board Canvas measurement write path must preserve human-authored append-only event semantics and must not add schema, writer, materializer, validator, projection, Project ZIP, event, or fact behavior unless separately scoped.
- Visual trace context remains visual-only and must not imply electrical proof or connectivity.
- Future Board Canvas/app visual polish may use the inspected Board Canvas HTML as design input only; that scratch HTML has `RUNTIME_AUTHORITY: NONE`, `CANONICAL_SEMANTICS: NONE`, and `IMPLEMENTATION_AUTHORIZATION: NONE`.
- Component focus, hover, preview, pin/leg selection, and value/unit/save-looking controls in Board Canvas remain local UI state unless separately scoped.
- Future visual pin/leg selector work may only be scoped as local UI-only selection/highlight/focus behavior inside the accepted integrated Board Canvas Measure panel.
- Future pin/leg selector work may only remain local UI-only unless separately scoped; the accepted deduplication removed the duplicate local selector surface while keeping measured-value rows primary and component visual preview as the physical cue surface.
- Visual pin/leg selection must not become confirmed pin mapping, a confirmed net, electrical relation, placement/coordinate semantics, package identity, or canonical fact.
- Future dark EDA / bench-instrument visual direction may use the inspected dark Project Home HTML/CSS only as design input: dominant board/canvas working surface, compact left rail/project navigation direction, contextual right Measure panel direction, read-only/no-write status visibility, technical typography and restrained chrome, dark canvas with clear board/footprint contrast, and preserved BenchBeep user-facing identity.
- Future Project Home dark EDA shell follow-up work may be considered only as narrow local visual polish for the Project Overview / Workbench Home surface.
- Some broader action labels remain English, such as `Measure Sheet`, `Add Component`, `Edit Component`, `Board Canvas`, `Reference Images`, `Project overview` app-bar, `renderer writes: none`, and `display-only shell`; these are deferred broader copy-polish candidates and are not blockers for this narrow accepted implementation.
- Future separate scopes may consider cleaner Project Home / Workbench Home identity presentation, stronger BenchBeep-branded dark EDA visual direction, broader copy polish, improved project/workbench header hierarchy, more refined dark board/workspace visual composition, future logo/brand asset discussion through a separate explicit asset scope, and future Project Home/Workbench Home visual polish after a separate route decision and active-lock sync.
- The inspected standalone dark Project Home HTML is possible future design-source input only and does not authorize implementation.
- Further Project Home dark polish, global dark theme, Board Canvas dark EDA visual migration, color-coded net rendering, board-level legend implementation, logo asset/runtime asset changes, Google Fonts/font asset changes, new route/navigation behavior, and runtime CSS/HTML reuse are future/deferred unless separately scoped.
- 5V/220V/GND/Signal labels in design-source files are visual prototype labels only and do not confirm nets, connectivity, electrical proof, measurements, pins, components, facts, coordinates, or Board Canvas write behavior.
- Any future implementation requires a separate route decision and active-lock sync that inspects live repo files and lists the smallest exact runtime/test allowlist.
- Command menu / Ctrl-K, context menus, audio/save beep, canvas token consumer migration, full redesign, logo polish, high-pin selector UX, new project creation, and broader menu behavior remain deferred unless separately scoped.
- Canonical board/write behavior, placement writes, Confirm/write, Edit Layout, schema, writer, materializer, validator, projection, Project ZIP, event, and fact changes remain protected surfaces.
- `_incoming`, screenshots, docs/sources, and mockups are design/reference input only, never runtime truth.
- Exact staging only; never use `git add .`, `git add -A`, or `git commit -am`.

## Active constraints

- This closeout is docs-only and may edit only the route/ledger docs and its new audit artifact.
- This closeout releases the prior implementation active lock and does not arm a new implementation pass.
- This closeout records no Claude audit verdict because Claude Code is temporarily unavailable.
- Review status for this closeout is `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- The accepted design-source boundaries remain unchanged: `_incoming` dark EDA HTML/CSS are design input only and have no runtime authority, canonical semantics, or implementation authorization.
- Prompt/audit gate policy from `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` remains accepted:
  - Codex final responses for pass work normally include a clearly separated `CLAUDE_AUDIT_PACKET`; temporary no-Claude passes explicitly use `NO_CLAUDE_REVIEW_PACKET` and must not claim Claude audit;
  - visual/product-surface work requires manual smoke before Claude audit and packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`;
  - `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set;
  - protected implementation requires active-lock sync before runtime/test work when the live active lock does not name the implementation pass and exact allowlist;
  - exact staging only remains required.

## Operational pointers

- Current/next route and bounded queue: `docs/PASS_QUEUE.md`
- Active surface/allowlist pointer when a route is armed: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance lookup: `docs/AUDIT_INDEX.md`
- Completed queue history: `docs/PASS_QUEUE_ARCHIVE.md`
- Stable product/architecture memory: `docs/PROJECT_MEMORY.md`
- Core invariants: `docs/TRUTH_INDEX.md`
- Model/helper routing: `docs/MODEL_ROUTING.md`
- Prompt/audit-packet policy: `docs/PROMPTING_PROTOCOL.md`
- Protected surfaces: `docs/PROTECTED_SURFACES.md`
- Memory/intake policy: `docs/MEMORY_PROTOCOL.md`

## History handling

Completed pass-by-pass history is intentionally not repeated in this operational handoff. Use `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for detailed provenance.
