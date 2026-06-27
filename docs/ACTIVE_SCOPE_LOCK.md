# Active Scope Lock

## Current docs-only design-source intake pass

`V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / DESIGN_SOURCE_INTAKE / PROTECTED_UI_DIRECTION

## Intake source

- Accepted/pushed Project Home dark EDA shell closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Accepted/pushed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Full implementation SHA: `5691e8de78b46cb45859337e089b84f206c2831b`.
- Prior accepted/pushed active-lock sync: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS` at `e6a5329` (`docs: arm Project Home dark EDA shell implementation`).
- Prior accepted/pushed scope-lock: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS` at `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Prior accepted/pushed design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Claude Code is temporarily unavailable for this intake.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.

## Allowed files for this intake

This intake may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS.md`

No runtime, test, asset, schema, writer, materializer, validator, projection, event, fact, sample, platform, generated, `_incoming`, or scratch file is authorized by this intake.

## Standalone HTML design source

Inspected design-source path:

- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark, standalone).html`

The standalone dark Project Home HTML bundle is `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

The standalone bundle may contain embedded image/font/script/style data. Those embedded resources are also `DESIGN_INPUT_ONLY` and must not be extracted, copied, staged, converted to Flutter assets, imported, bundled, or used as runtime dependencies.

Do not infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, route behavior, project identity facts, or AI/OCR/CV facts from the standalone HTML.

## Relationship to accepted implementation

- `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` remains accepted/pushed at `5691e8d`.
- `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` remains accepted/pushed at `aa4b907`.
- The current implemented Project Overview / Workbench Home dark EDA shell remains accepted as-is.
- This standalone HTML does not reopen, override, supersede, or invalidate the accepted implementation.
- This standalone HTML is future reference input only.

## Future design direction allowed only after separate route/scope

Future separate scopes may consider:

- cleaner Project Home / Workbench Home identity presentation;
- stronger BenchBeep-branded dark EDA visual direction;
- copy polish for mixed English/Estonian shell labels;
- improved project/workbench header hierarchy;
- more refined dark board/workspace visual composition;
- future logo/brand asset discussion, but only through a separate explicit asset scope;
- future Project Home/Workbench Home visual-polish scope, but only after a separate route decision and active-lock sync.

## Explicitly deferred

- Runtime implementation from this standalone HTML.
- Direct HTML/CSS/JS reuse.
- Embedded PNG/font extraction.
- Logo/runtime asset import.
- `pubspec.yaml` asset changes.
- Global dark theme.
- Board Canvas dark EDA migration.
- Color-coded nets.
- Board-level legend runtime behavior.
- Command menu.
- Context menu.
- Audio/save beep.
- Route/navigation changes.
- Canvas token migration.
- Schema/writer/materializer/validator/projection/event/fact changes.

## Explicitly forbidden

- Editing `lib/` or `test/`.
- Editing `_incoming`.
- Editing assets or `pubspec.yaml`.
- Arming implementation directly.
- Staging the standalone HTML.
- Copying the standalone HTML into docs or assets.
- Pasting large HTML, base64, embedded resource, script, style, image, or font content into docs.
- Using the standalone HTML as runtime truth.
- Adding runtime dependency on `_incoming`.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Board Canvas save/write behavior changes.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, route behavior, project identity facts, or AI/OCR/CV facts.

## Route

- Current route owner: `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Current docs-only intake pass: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS`.
- Route after this intake is accepted/pushed: `NEEDS_USER_DECISION`.
