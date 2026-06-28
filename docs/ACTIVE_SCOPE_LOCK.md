# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_RAIL_LABEL_FIT_SCOPE_LOCK_PASS`

## Current armed implementation pass

None. This docs-only scope-lock does not arm runtime or test implementation directly.

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_RAIL_COPY

## Baseline

- Expected and verified HEAD/origin before this scope-lock: `4ed76ef` (`docs: record Board Canvas remaining copy polish`).
- Accepted/pushed Board Canvas remaining-copy polish closeout: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_POST_AUDIT_PASS` at `4ed76ef`.
- Closeout full SHA: `4ed76ef99269e8e3e289ea034850a0f0a47617e5`.
- Accepted/pushed implementation: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS` at `e18c30f` (`feat(board-canvas): polish remaining copy`).
- Accepted implementation full SHA: `e18c30fc4618cca49d3f2471fb303b21324eee3e`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files remain untouched.

## Scope-lock allowlist

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_RAIL_LABEL_FIT_SCOPE_LOCK_PASS.md`

No runtime or test files are authorized by this scope-lock.

## Locked future target surface

Future implementation may only address Board Canvas left rail / compact tool rail label fit and closely related rail tooltip/semantic copy handling after a separate active-lock sync.

Candidate future implementation files, if still sufficient after live repo inspection in the active-lock sync:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not treat this scope-lock as runtime/test authorization.

## Reason for scope-lock

The accepted Board Canvas remaining-copy polish pass recorded non-blocking nits: some narrow rail labels may still truncate because of rail width. A future narrow polish pass may improve fit/legibility without broad layout redesign or product behavior changes.

## Candidate rail labels

Future implementation may inspect and, if needed, polish compact rail-visible labels such as:

- `Lisa komponent`
- `Mõõtmine`
- `Paigutused`
- `Ohutus`
- `Inspektor`
- `Tulevased tööriistad`
- `Rajakaart`
- `Paranduskaart`

Any shortened visible label must preserve full meaning through tooltip or accessible/semantic text where practical.

## Design source handling

The standalone dark Project Home HTML remains `DESIGN_INPUT_ONLY`.

- Repo-local accepted design path inspected for context only: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark, standalone).html`.
- Literal prompt path `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\BenchBeep Project Home (dark, standalone).html` was not present on disk.
- The repo-local path is already recorded by design-source intake docs as the accepted design-source reference location.

Design source status:

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, extract, or runtime-depend on the HTML. Do not extract fonts, images, scripts, CSS, colors, classes, assets, or embedded resources.

## Future implementation may consider

- Shortening rail-visible labels while preserving full meaning in tooltips.
- Keeping full text in tooltip/semantic copy where visible rail text must be compact.
- Using concise technician-facing labels such as `Lisa`, `Komponent`, `Mõõda`, `Tulekul`, `Rajad`, or `Parandus` only if safe and clear.
- Adjusting rail label max lines, text scale handling, spacing, or tooltip copy only if local and minimal.
- Preserving icon-first rail behavior.
- Preserving Board Canvas canvas dominance.
- Preserving accepted dark EDA visual styling.
- Updating focused Board Canvas widget tests only after a separate active-lock sync.

## Protected boundaries to preserve

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- No save/write behavior from Board Canvas.
- Existing pan/zoom/fit/reset behavior remains preserved.
- Existing tap-to-select behavior remains preserved.
- Existing selected-pin persistence behavior remains preserved.
- Existing inspector behavior remains preserved.
- Existing placement rendering behavior remains preserved.
- Existing measurement marker/summary behavior remains preserved.
- Existing visual-trace/provenance behavior remains preserved.
- Existing Add Component local UI-only behavior remains preserved.
- Existing Measure Sheet route/save path remains preserved.
- Existing Project Overview runtime behavior remains preserved.
- Existing Board Canvas dark EDA styling remains preserved.
- Existing Board Canvas copy-polish remains preserved except rail-fit-specific copy.
- BenchBeep / TraceBench / BoardFact naming boundaries remain preserved.
- No canonical data rename.
- No project fact changes.
- No board fact changes.
- No schema changes.
- No writer/service changes.
- No materializer/validator/projection changes.
- No Project ZIP changes.
- No `events.jsonl` writes.
- No `known_facts` mutation.
- No canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Explicitly forbidden in this scope-lock

- Runtime implementation.
- Editing `lib/`.
- Editing `test/`.
- Editing `_incoming`.
- Editing the standalone HTML.
- Extracting/importing/copying/bundling fonts, images, CSS, JS, colors, classes, assets, or embedded resources from the standalone HTML.
- Adding runtime dependency on `_incoming`.
- Adding logo/runtime assets.
- Editing `pubspec.yaml`.
- Global theme migration.
- Shared theme/token refactor.
- Broad app-wide copy migration.
- Board Canvas redesign.
- Rail behavior rewrite.
- Route/navigation rewiring.
- Project Overview changes.
- Measure Sheet changes.
- Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Schema/writer/materializer/validator/projection/event/fact/sample/platform/generated changes.
- Broad staging.

## Route

- Current pass: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Do not arm implementation directly in this scope-lock.
