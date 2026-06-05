# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_READINESS_DOCS_SYNC_AND_TAG_DECISION_PASS`

## Goal

Docs-only readiness record and tag-decision setup after accepted V1.1 hardening readiness assessment. Do not create tags or modify release objects.

## Allowed files

Docs only: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V1_1_READINESS_DOCS_SYNC_AND_TAG_DECISION_PASS.md`.

## Allowed docs-sync actions

- Record V1.1 hardening readiness assessment as accepted input.
- Record V1.1 done-enough definition and deferred residuals.
- Record tag decision options; tag creation remains manual/user-owned and separately verified.
- Route next to a tag decision/verification docs pass before implementation work.
- Record the preferred post-tag-decision value track as `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`.

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

`V1_1_RC_TAG_DECISION_AND_VERIFICATION_PASS`
