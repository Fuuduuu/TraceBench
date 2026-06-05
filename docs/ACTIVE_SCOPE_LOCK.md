# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_TEST_AND_LINT_HYGIENE_CLOSEOUT_PASS`

## Goal

Docs-only closeout for the accepted/pushed `V1_1_TEST_AND_LINT_HYGIENE_PASS` implementation and Claude Code / Opus re-audit result `ACCEPT_AS_IS`.

## Allowed files

Docs only: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_CLOSEOUT_PASS.md`.

## Allowed closeout actions

- Record accepted implementation and re-audit outcomes.
- Record validation state and final deferred analyzer residuals.
- Record that `board_graph_model.dart`, `home_screen.dart`, and `pubspec.lock` were authorized by the small-patch/re-audit path.
- Update routing to the next route-review pass.

## Explicitly deferred

- `unreachable_switch_case` in `customer_report_screen.dart`
- `library_private_types_in_public_api` in `python_runner.dart`
- `deprecated_member_use` value -> initialValue in `measurement_record_screen.dart`
- `overridden_fields` restructure in `reference_images_screen_test.dart`
- all `pumpAndSettle` migration
- broad formatting sweeps
- broad test refactors

## Forbidden surfaces

- No code or test changes.
- No Flutter runtime changes.
- No tools, schemas, materializers, samples, assets, generated artifacts, tags, or release-object changes.
- No deferred analyzer residual fixes.
- No pumpAndSettle migration.
- No feature work.
- No product/evidence semantics changes.
- No event-writing work.
- No Reference Images feature logic changes.
- No Board Canvas feature/evidence logic changes.
- No Project ZIP changes.
- No schemas changes.
- No materializer changes.
- No tools changes.
- No samples/assets changes.
- No generated artifacts.
- No tags/releases.
- No V2 implementation.
- No commercial/licensing implementation.
- No audit-history pruning.
- No files outside the docs-only allowlist.
- No behavior-changing refactors.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Next recommended pass

`V1_1_POST_TEST_AND_LINT_HYGIENE_ROUTE_REVIEW_PASS`
