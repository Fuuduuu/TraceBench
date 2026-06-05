# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_RC_TAG_VERIFICATION_CLOSEOUT_PASS`

## Goal

Docs-only closeout for the user-created and verified `v1.1.0-rc1` milestone tag. Do not create, move, delete, push, or otherwise mutate tags or release objects.

## Allowed files

Docs only: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V1_1_RC_TAG_VERIFICATION_CLOSEOUT_PASS.md`.

## Allowed closeout actions

- Record `v1.1.0-rc1` as user-created, pushed, annotated, and verified.
- Record tag target `da3f055aac912b6da43a23eeda0bd33811bb29f8`.
- Record `v1.0.0-rc1` remains intact.
- Record that Codex performed no tag/release mutation.
- Route next to full-app manual V1.1 smoke before implementation work.

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
- No tag or release-object creation, deletion, movement, or push.
- No V2 implementation.
- No commercial/licensing implementation.
- No audit-history pruning.
- No files outside the docs-only allowlist.
- No behavior-changing refactors.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- Confirm `CURRENT_STATE.md` remains below the ~120-line trigger.
- Confirm no tag was created or mutated.

## Next recommended pass

`V1_1_FULL_APP_MANUAL_SMOKE_PASS`
