# Current State

## Current pass

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed HEAD verified before this closeout: `6762bdc` (`feat(board-canvas): improve fit reset discoverability`), aligned with `origin/main`.
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS` at `6762bdc` (`feat(board-canvas): improve fit reset discoverability`).
- Implementation full SHA: `6762bdcb35287b9d7c393d5b2ec9e21e911df2f3`.
- Implementation files changed: `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Manual smoke: PASS.
- Review status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Claude Code was unavailable for this implementation; this state does not claim Claude audit or Claude acceptance for this pass.
- Accepted behavior: compact `Sobita` viewport recovery control, clearer tooltip `Sobita / taasta vaade`, semantic label/hint for fit/reset recovery, and preserved existing fit/reset behavior.
- Implementation validation evidence: `dart format` passed; `flutter test test/widget/board_canvas_screen_test.dart` passed (+97); `flutter test test/widget/project_overview_screen_test.dart` passed (+20); `flutter test test/widget/measure_sheet_screen_test.dart` passed (+27); full `flutter test` passed (+341); `python tools/validate_all.py` passed with 273 tests OK and existing optional-photo warnings only; `git diff --check` passed; `rg "v2_save_measurement_writer"` on the two implementation files returned no matches.
- Latest accepted/pushed active-lock sync: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS` at `b2d0a61` (`docs: arm Board Canvas fit reset discoverability`).
- Active-lock sync full SHA: `b2d0a61a0cfaed3581725d8dd30d4e1f24b02e9e`.
- Latest accepted/pushed route sync: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ROUTE_SYNC_PASS` at `8f45065` (`docs: sync Board Canvas fit reset route`).
- Latest accepted/pushed scope-lock: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS` at `b254d43` (`docs: lock Board Canvas fit reset discoverability`).
- Scope-lock full SHA: `b254d437e8577bf5cbfd649b4a92dc99893f0fb5`.
- Latest accepted/pushed closeout before the scope-lock: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_POST_AUDIT_PASS` at `1740e8a` (`docs: record Board Canvas rail label fit`).
- Closeout full SHA: `1740e8a541cdb9fb03f3d1c0574fb2322d42810f`.
- Latest accepted/pushed implementation before the scope-lock: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS` at `e855d5d` (`feat(board-canvas): polish rail label fit`).
- Implementation full SHA: `e855d5d4db8254923cdc1887e6a23b5e29a0c396`.
- Implementation files changed: `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Manual visual smoke: PASS.
- Review status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Claude Code was unavailable for the rail-label implementation; this state does not claim Claude audit or Claude acceptance for that pass.
- GPT Pro secondary review accepted the rail-label runtime implementation for staging after user manual visual smoke PASS and recorded validation evidence.
- Accepted behavior: Board Canvas left rail label fit improved; visible truncation `Pa...` / `Tul...` was removed; compact labels are `Lisa`, `Rajad`, and `Parandus`; visible `Tulevased tööriistad` section header text is hidden while full meaning remains available through tooltip/semantic copy; selected rail icon/tile uses compact glow and no longer stretches into a wide rail-width rectangle; icon-first dark EDA style is preserved.
- Implementation validation evidence: `dart format` passed; `flutter test test/widget/board_canvas_screen_test.dart` passed (+97); `flutter test test/widget/project_overview_screen_test.dart` passed (+20); `flutter test test/widget/measure_sheet_screen_test.dart` passed (+27); full `flutter test` passed (+341); `python tools/validate_all.py` passed with 273 tests OK and existing optional-photo warnings only; `git diff --check` passed; `rg "v2_save_measurement_writer"` on the two implementation files returned no matches.
- Current route is this docs-only closeout for the accepted/pushed Board Canvas Fit / Reset discoverability implementation.
- Route after this closeout is accepted/pushed: `NEEDS_USER_DECISION`.
- The Board Canvas Fit / Reset discoverability implementation active lock is released; no new implementation pass is armed.
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_POST_AUDIT_PASS` at `4ed76ef` (`docs: record Board Canvas remaining copy polish`).
- Closeout full SHA: `4ed76ef99269e8e3e289ea034850a0f0a47617e5`.
- Prior accepted/pushed implementation: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS` at `e18c30f` (`feat(board-canvas): polish remaining copy`).
- Implementation full SHA: `e18c30fc4618cca49d3f2471fb303b21324eee3e`.
- Implementation files changed: `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Manual smoke: `PASS_WITH_NITS`.
- Manual smoke evidence: Board Canvas opens normally; Estonian labels are visible and natural enough for this pass; Board Canvas visible shell/control copy was polished toward Estonian; product/platform identity remains correct; diagnostic copy intentionally preserved where precision is safer; read-only/no-write badge remains visible and clear; Board Canvas still visually matches the accepted dark EDA style; pan/zoom/fit/reset still work; tap-to-select still works; selected pin remains active after selection; hover does not steal selected pin state; Inspector still works; measurement markers/summary still work; Add Component remains local/UI-only; Measure Sheet route/save path is unchanged; Project Overview still opens and looks unchanged; no Board Canvas save/write/canonical behavior appears.
- Accepted nits: some narrow rail labels may still truncate because of rail width; some diagnostic/product labels intentionally remain English, including `Board Canvas`, `BenchBeep · TraceBench platform`, `renderer writes: none`, `Beep`, and other technical provenance/debug labels where precision is safer.
- Temporary secondary review: ChatGPT Pro temporary secondary review accepted staging after validation and user manual smoke `PASS_WITH_NITS`.
- Claude status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Prior accepted/pushed active-lock sync: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS` at `3f3b488` (`docs: arm Board Canvas remaining copy polish implementation`).
- Active-lock sync full SHA: `3f3b488b2b2bc0e42cac23d1526ed6d4b4379a19`.
- Prior accepted/pushed scope-lock: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS` at `375b8da` (`docs: lock Board Canvas remaining copy polish`).
- Scope-lock full SHA: `375b8da706b21d0e4cfd1f7a6ed056f43a92ef47`.
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS` at `aa20c78` (`docs: record Board Canvas dark EDA style alignment`).
- Prior accepted/pushed implementation baseline: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS` at `725b8b8` (`feat(board-canvas): align dark EDA shell`).
- Full implementation SHA: `725b8b86986bb419c35801b84dbdd9d18227af68`.
- Implementation files changed: `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Manual smoke: PASS.
- Manual smoke evidence: Board Canvas opens normally; Board Canvas visually aligns better with Project Overview / Workbench Home dark EDA family; Board Canvas no longer feels overly green; shell/rail/footer are dark-neutral and coherent; Canvas/grid remains green EDA family and readable; right/context panel sections are clearly separated; measured pin/value rows are easy to distinguish; selected pin row is visually distinct; inactive pin rows are readable but secondary; input controls and unit dropdowns have visible boundaries; Beep action is readable; left rail active/disabled/menu states are clear; Add Component remains local/UI-only; selected pin remains visibly active after tap/click; hover does not steal active state from the selected pin; selecting another pin moves active state to the new pin; right/context panel shows selected pin context correctly; pan/zoom/fit/reset still work; tap-to-select still works; Inspector still works; measurement markers/summary still work; Measure Sheet route/save path is unchanged; Project Overview still opens and looks unchanged; no Board Canvas save/write/canonical behavior appears.
- Temporary secondary review: ChatGPT Pro temporary secondary review accepted staging after validation and user manual smoke PASS.
- Claude status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Latest accepted/pushed active-lock sync: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS` at `bb35cc2` (`docs: arm Board Canvas dark EDA style alignment implementation`).
- Latest accepted/pushed scope-lock: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS` at `df38722` (`docs: lock Board Canvas dark EDA style alignment`).
- Scope-lock full SHA: `df38722b774f2d8db9a0d0f64715f4c2cff95c65`.
- Prior accepted/pushed Project Home closeout: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_POST_AUDIT_PASS` at `7f11471` (`docs: record Project Home dark EDA copy polish`).
- Prior accepted/pushed Project Home implementation: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS` at `3674a69` (`feat(project-overview): polish dark EDA copy`).
- Prior Project Home implementation full SHA: `3674a69bc2ac44a0e61a1921b2ec6924d2d056fb`.
- Prior Project Home implementation files changed: `lib/features/project/screens/project_overview_screen.dart` and `test/widget/project_overview_screen_test.dart`.
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
- Prior Board Canvas rail label fit closeout is accepted/pushed; its implementation active lock remains released.
- Design source handling: the standalone dark Project Home HTML remains `DESIGN_INPUT_ONLY`; the repo-local accepted path is `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark, standalone).html`, and it is not runtime truth or an asset/source dependency.
- The latest accepted Project Home implementation target surface was Project Overview / Workbench Home in `lib/features/project/screens/project_overview_screen.dart`, with focused tests in `test/widget/project_overview_screen_test.dart`.

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
- Board Canvas dark EDA shell/style alignment is accepted.
- Scope stayed on `BoardCanvasScreen` and focused Board Canvas widget tests.
- Board Canvas shell, rail/panels, footer/status strip, canvas/grid palette, badges, row/panel hierarchy, and selected-pin feedback were refined toward the accepted Project Overview / Workbench Home dark EDA family.
- Board Canvas copy was polished where local and safe, including read-only/no-write language and selected shell labels.
- Selected pin state remains visibly active after explicit selection.
- Hover no longer steals selected pin state.
- Board Canvas read-only/no-write meaning remains visible and preserved.
- Existing pan/zoom/fit/reset, tap-to-select, Inspector, placement rendering, measurement marker/summary, visual-trace/provenance, Add Component local UI, route/navigation, and Measure Sheet save path remain preserved.
- No Project Overview runtime files were changed by Board Canvas dark EDA style alignment.
- No logo/runtime assets were added.
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
- Board Canvas remaining visible English/mixed shell/control copy was polished toward concise Estonian where safe.
- Scope stayed on `BoardCanvasScreen` and focused Board Canvas widget tests.
- Accepted copy changes include local shell/control labels such as `Mõõtmine`, `Lisa komponent`, `Paigutused`, `Ohutus`, `Inspektor`, `Valmis`, `Näita kõiki` / `Peida kõik`, `Komponendi vaade`, `Mõõdetud väärtused`, `Jätka mõõtelehel`, and related local tooltips/section labels where safe.
- Product/platform/diagnostic copy was intentionally preserved where precision was safer, including `Board Canvas`, `BenchBeep · TraceBench platform`, `renderer writes: none`, `Beep`, `From -> To context`, provenance/debug field labels, and no-write diagnostic wording where applicable.
- Accepted remaining-copy polish nits: some narrow rail labels may still truncate because of rail width, and some diagnostic/product labels intentionally remain English.
- Board Canvas rail label fit / truncation polish is accepted: awkward `Pa...` / `Tul...` truncation is gone, compact visible labels are preserved, full meaning remains in tooltip/semantic copy, and selected rail state is a compact glowing icon/tile rather than a wide rail-width rectangle.

## Protected future direction carried forward

- Future Board Canvas dark EDA follow-up refinements, if separately scoped, must keep Board Canvas as the dominant working surface, keep the right panel contextual/secondary, preserve clear read-only/no-write status, and prefer Board Canvas-only runtime edits unless a later active-lock sync authorizes a tiny focused test/helper.
- Future candidate Board Canvas visual-refinement implementation files, if still sufficient after a later active-lock sync inspection: `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Future broader copy polish, if separately scoped, must keep diagnostic/product terms precise and must not blur BenchBeep / TraceBench / BoardFact naming boundaries.
- Any further Board Canvas copy/runtime refinement beyond the rail-label-fit scope requires a new route decision and active-lock sync.
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

- The accepted Board Canvas remaining-copy polish closeout was docs-only, released its prior implementation active lock, and did not arm a new implementation pass.
- The accepted Board Canvas remaining-copy polish closeout recorded no Claude audit verdict because Claude Code was temporarily unavailable.
- Review status for that accepted closeout remains `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- The accepted Board Canvas rail label fit closeout was docs-only, released its prior implementation active lock, and did not arm a new implementation pass.
- Review status for the accepted rail label fit implementation remains `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- The accepted Board Canvas Fit / Reset discoverability scope-lock was docs-only, did not arm runtime implementation directly, and routed to the active-lock sync.
- The accepted Board Canvas Fit / Reset discoverability active-lock sync was docs-only, armed `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS`, and was pushed at `b2d0a61`.
- The accepted Board Canvas Fit / Reset discoverability implementation was pushed at `6762bdc` and changed only `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- This closeout records manual smoke PASS and temporary review mode `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`; it does not claim Claude audit or Claude acceptance.
- The Board Canvas Fit / Reset discoverability implementation active lock is released by this closeout; no new implementation pass is armed.
- Current route after this closeout is accepted/pushed: `NEEDS_USER_DECISION`.
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
