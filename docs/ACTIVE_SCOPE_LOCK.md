# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current armed implementation pass

`V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS`

## Type

LANE_B_ADJACENT / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_BOARD_CANVAS_RAIL_COPY

## Baseline

- Expected and verified HEAD/origin before this active-lock sync: `c41fc58` (`docs: lock Board Canvas rail label fit`).
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_SCOPE_LOCK_PASS` at `c41fc58`.
- Scope-lock full SHA: `c41fc58593dde2659557b6913b11ca27093cf15d`.
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_POST_AUDIT_PASS` at `4ed76ef` (`docs: record Board Canvas remaining copy polish`).
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files remain untouched.

## Active-lock sync allowlist

This docs-only active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

No runtime or test implementation is authorized in this active-lock sync.

## Future implementation allowlist

`V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS` may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, docs, asset, schema, tool, sample, platform, generated, or `_incoming` file is authorized for the future implementation pass.

## Target surface decision

Future implementation may only address Board Canvas left rail / compact tool rail label fit and closely related rail tooltip/semantic copy handling.

Candidate labels or visible rail text may include, if present:

- `Lisa komponent`
- `Mõõtmine`
- `Paigutused`
- `Ohutus`
- `Inspektor`
- `Tulevased tööriistad`
- `Rajakaart`
- `Paranduskaart`

Live inspection confirmed these labels/tooltips live in `lib/features/board_canvas/screens/board_canvas_screen.dart`, and the focused rail assertions live in `test/widget/board_canvas_screen_test.dart`.

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
- Updating focused Board Canvas widget tests only for changed rail label, tooltip, semantic, fit, and protected-behavior assertions.

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
- Full semantic meaning remains available through tooltip/accessible text where rail label is shortened.
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

## Explicitly forbidden in this active-lock sync

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

## Explicitly forbidden in the future implementation pass

- Editing outside `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.
- Adding Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Writing `events.jsonl`.
- Mutating `known_facts`.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning shortened labels, tooltips, visual traces, or From -> To context into confirmed connectivity or semantics.
- Changing router, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, assets, samples, platform files, generated files, or unrelated docs.

## Route

- Current pass: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current armed implementation pass: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS`.
- This active-lock sync does not implement runtime behavior.
