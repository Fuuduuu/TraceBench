# LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS

Status: DRAFTED / PENDING CLAUDE AUDIT
Mode: docs-only legacy surface classification
Route: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`

## Baseline verification

- Initial gate commands were run before editing: `git status --short --branch`, `git log --oneline --decorate -8`, `git diff --name-status`, `git diff --cached --name-status`, and `git diff --check`.
- Tracked diff was clean before this pass.
- Cached diff was clean before this pass.
- Branch was aligned with `origin/main` before this pass.
- Live route docs showed `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_POST_AUDIT_PASS` closeout artifact was present in repo docs.

## Durable owner choice

This pass records the classification in `docs/PROJECT_MEMORY.md` instead of creating `docs/LEGACY_SURFACE_CLASSIFICATION.md`.

Reason: `docs/PROJECT_MEMORY.md` is the existing durable architecture/product-memory owner, and this pass write allowlist did not include `docs/FILE_MAP.md` for registering a new documentation file. Avoiding a new file prevents a file-map governance drift while still making the classification durable.

## Surfaces classified

The classification covers at least:

- BenchBeep launcher / app start
- Legacy/root project home
- New project wizard
- Project Overview / Workbench shell
- Board Canvas
- Board Graph
- Add Component standalone page
- Edit Component standalone page
- Measure Sheet
- Measurement list
- Component list
- Pin list
- Not populated list
- Events viewer
- Known facts JSON viewer
- Photos
- Reference Images
- Customer report / export
- `/project/measurements/new` redirect
- sample/demo project surfaces
- import/open/export lifecycle surfaces
- legacy unrouted measurement record screen discovered during read-only classification

Labels used exactly: `KEEP_CURRENT`, `KEEP_BUT_RESKIN_LATER`, `KEEP_AS_TEST_OR_DEBUG_ONLY`, `TRANSITIONAL_REPLACE_LATER`, `CANDIDATE_FOR_RETIREMENT`, `UNKNOWN_NEEDS_DECISION`.

## Preserved product distinctions

- Board Canvas `Lisa` confirms visual placement for an existing selected component.
- Standalone Add Component creates component identity via `component_created`.
- Standalone Edit Component updates component metadata via `component_updated`.
- Measure Sheet remains the current canonical measurement writer until separately scoped.
- Board Graph remains projection/debug/advanced, not a Board Canvas replacement.
- Raw events / known facts / list screens remain debug/advanced until V2 inspectors cover the same information.
- Reference Images remain local sidecar/reference only, not canonical evidence.
- Customer report/export remains a critical lifecycle surface.

## Boundary record

- No runtime files edited.
- No test files edited.
- No schema/tool/materializer/validator/router/events/known_facts/_incoming files edited.
- No route hiding, screen deletion, runtime implementation, or test migration authorized.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Board Canvas renderer/painter remains read-only.
- Scoped explicit panel actions may write canonical events only when separately implemented and accepted.
- Visual placement remains separate from identity, pins, contacts, pads, nets, traces, and electrical facts.
- AI proposals remain non-canonical.
- Project ZIP/export/materializer behavior remains protected.

## Recommended next candidates

Not armed:

- `BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`
- `ADD_EDIT_COMPONENT_LEGACY_FLOW_REVIEW_PASS`
- `MEASURE_SHEET_V2_ALIGNMENT_SCOPE_LOCK_PASS`

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify route remains `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- verify no runtime/test/tool/schema/assets/events/known_facts/_incoming changes
