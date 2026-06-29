# Active Scope Lock

## Current pass

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS`

## Current armed implementation pass

`none`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_HOME_STYLE

## Baseline

- Expected and verified HEAD/origin before this scope-lock: `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS` at `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS` at `6762bdc` (`feat(board-canvas): improve fit reset discoverability`).
- The Fit / Reset closeout released the Board Canvas implementation active lock and routed to `NEEDS_USER_DECISION`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files remain untouched.

## Scope-lock write allowlist

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS.md`

No runtime, test, schema, tool, asset, sample, platform, generated, or `_incoming` file is authorized in this scope-lock.

## Scope locked for future implementation

Future implementation may only improve BenchBeep Home / esileht dark-theme parity with the existing dark BenchBeep/workbench visual family.

Future implementation may allow visual-only polish such as:

- background treatment;
- card/surface treatment;
- text contrast and hierarchy;
- dividers and borders;
- button styling where needed for dark-theme parity;
- compact BenchBeep/workbench-style visual language.

Future implementation must preserve:

- BenchBeep Home as the launcher, not a marketing landing page;
- `Open existing` behavior;
- `Import project` behavior through the existing allowed import/open-project flow;
- existing Home, workbench, and back/home navigation behavior;
- BenchBeep as the user-facing app/product name;
- TraceBench as the repo/platform/project name;
- BoardFact as the data-fact/subsystem name;
- existing Project Overview, Board Canvas, Measure Sheet, and Add Component behavior.

## Required next active-lock sync

This scope-lock does not arm runtime implementation directly.

The next docs-only active-lock sync must inspect the exact live Home screen/widget owners before arming files for:

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`

The active-lock sync must list the smallest exact runtime/test allowlist after inspection and must not invent files or allow broad directories.

## Explicitly forbidden in this scope-lock

- Editing `lib/`.
- Editing `test/`.
- Editing `tools/`.
- Editing `schemas/`.
- Editing `assets/`.
- Editing `_incoming`.
- Editing runtime, writer, materializer, projection, ZIP, event, fact, schema, sample, platform, or generated files.
- Arming runtime implementation directly.
- Changing Board Canvas.
- Changing Measure Sheet.
- Changing Project Overview behavior.
- Changing Home launcher behavior, open/import behavior, route behavior, or navigation behavior.
- Adding save/write/canonical behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Writing `events.jsonl`.
- Mutating `known_facts`.
- Creating or implying canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Changing schema, writer, materializer, validator, projection, Project ZIP, samples, or `_incoming`.
- Treating `_incoming`, screenshots, mockups, or design-source files as runtime truth.
- Starting a full redesign, new navigation, command menu, context menu, audio/save beep, global theme migration, or canvas token migration.
- Broad staging.

## Route

- Current pass: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS`.
- Current armed implementation pass: `none`.
- Route after accepted/pushed: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This pass does not implement runtime behavior.
