# REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope lock`

## Scope lock decision

`REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS` is accepted as the next small recovery slice after:
- `DOCS_DRIFT_MINI_CLEANUP_PASS` completed
- `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS` accepted
- `V1_1_POST_GOVERNANCE_CLEANUP_NEXT_ROUTE_REVIEW_PASS` returning PASS in routing review

Current implementation direction is:

- lock `REFERENCE_IMAGES_UX_STATES_IMPL_PASS` for Reference Images empty/missing/error state UX only.

## Locked implementation scope

`REFERENCE_IMAGES_UX_STATES_IMPL_PASS` may only touch:

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

And governance docs:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## State scope (first slice)

- empty-state copy and messaging cleanups
- missing local file message and explanatory local-only helper text
- optional existing unsupported-format / import-failure / large-file / max-count copy handling only if already present in current code path
- required safety strings must remain present:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`

## Required test-shape guardrails for the implementation pass

- use fake/null ledger scenarios (no real temp image files)
- keep tests deterministic and bounded
- prefer empty/resolve-null cases
- avoid selected-image real `Image.file` decode paths in tests
- keep existing service tests unchanged unless directly dependent

## Forbidden implementation additions for this slice

- no full screen or layout architecture rewrite
- no metadata grouping expansion
- no selected-image preview rewrite or real-image decode in tests
- no filesystem-heavy widget tests
- no Project ZIP / schema / materializer / tools / samples / assets changes
- no Board Canvas / AI / URL import / transform/matrix / photo-overlay work
- no `events.jsonl` or `known_facts.json` write-path changes
- no `board_graph.json` or `view_state.json`

## Evidence boundaries

- Human is the sensor; AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing.
- Reference images stay non-canonical local sidecar in V1.1:
  - outside `events.jsonl`
  - outside `known_facts.json`
  - outside materializer
  - outside Board Canvas evidence rendering
  - outside URL import and AI/OCR/CV

## Required next recommended pass

`REFERENCE_IMAGES_UX_STATES_IMPL_PASS`
