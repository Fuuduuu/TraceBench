# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_TEST_AND_LINT_HYGIENE_PASS`

## Goal

Behavior-preserving V1.1 test/lint/docs hygiene implementation. Repair the `docs/AUDIT_INDEX.md` malformed literal backtick-n table artifact, add the missing measurement-write success-test error-absence assertion, and apply only locked low-risk analyzer/lint cleanup in explicitly allowed files.

## Allowed files

Docs: `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_PASS.md`.

Tests: `test/widget/measurement_write_screen_test.dart`, `test/widget/reference_images_screen_test.dart`, `test/widget/customer_report_screen_test.dart`, `test/widget/new_project_wizard_screen_test.dart`, `test/unit/board_graph_projection_test.dart`, `test/unit/event_parsing_test.dart`, `test/unit/project_exporter_test.dart`, `test/integration/pelle_sample_end_to_end_test.dart`.

Lib mechanical lint only: `lib/features/board_canvas/screens/board_canvas_screen.dart`, `lib/features/board_graph/screens/board_graph_screen.dart`, `lib/features/board_graph/widgets/board_graph_canvas.dart`, `lib/features/photos/screens/photo_list_screen.dart`, `lib/features/reference_images/screens/reference_images_screen.dart`, `lib/features/reference_images/services/reference_image_sidecar_service.dart`, `lib/shared/models/project_state.dart`, `lib/shared/services/project_loader.dart`, `lib/shared/widgets/projection_stale_banner.dart`.

Manifest: `pubspec.yaml` only for the direct `path` dev dependency.

## Allowed rule categories

- `prefer_const_constructors`
- `prefer_const_declarations`
- `unused_import`
- `unnecessary_import`
- `unnecessary_to_list_in_spreads`
- `unnecessary_brace_in_string_interps`
- `unnecessary_non_null_assertion`
- `annotate_overrides`
- `deprecated_member_use` only for `withOpacity -> withValues`
- `depend_on_referenced_packages` only for adding `path` to `dev_dependencies`

## Explicitly deferred

- `unreachable_switch_case` in `customer_report_screen.dart`
- `library_private_types_in_public_api` in `python_runner.dart`
- `deprecated_member_use` value -> initialValue in `measurement_record_screen.dart`
- `overridden_fields` restructure in `reference_images_screen_test.dart`
- all `pumpAndSettle` migration
- broad formatting sweeps
- broad test refactors

## Forbidden surfaces

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
- No files outside the allowlist.
- No behavior-changing refactors.

## Validation

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat analyze`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/widget/measurement_write_screen_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools/validate_all.py`
- `git diff --name-only`

## Next recommended pass

`V1_1_TEST_AND_LINT_HYGIENE_POST_AUDIT_PASS`
