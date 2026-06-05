# V1_1_TEST_AND_LINT_HYGIENE_PASS

PASS_ID: `V1_1_TEST_AND_LINT_HYGIENE_PASS`
Lane: `FLUTTER_PASS / TEST_AND_LINT_HYGIENE`
Mode: Behavior-preserving implementation. No feature behavior, product/evidence semantics, schema, materializer, Project ZIP, sample/asset, generated artifact, tag, release object, V2, or commercial/licensing change.

## MODEL_ROUTING_CHECK

PASS. Codex is the correct tool/model for this repo-local mechanical test/lint/docs hygiene implementation. Claude Code / Opus is required afterward for post-audit.

## Scope drift check

PASS. Changes are limited to the locked allowlist and allowed mechanical rule categories. Deferred judgment items and out-of-allowlist analyzer findings were not touched.

## Implementation summary

- Repaired the malformed literal backtick-n table artifact in `docs/AUDIT_INDEX.md`.
- Added the missing success-path assertion that `measurement-error-message` is absent in `test/widget/measurement_write_screen_test.dart`.
- Removed the remaining allowed mechanical analyzer residuals:
  - unused `fromComp` local in `lib/features/board_graph/models/board_graph_model.dart`,
  - unnecessary non-null assertion in `lib/features/project/screens/home_screen.dart`.
- Applied mechanical analyzer/lint cleanup in allowed files only:
  - const constructor/declaration additions,
  - unnecessary import removals,
  - unnecessary spread `.toList()` removals,
  - unnecessary string interpolation brace removal,
  - unnecessary non-null assertion cleanup,
  - `withOpacity` to `withValues(alpha: ...)`,
  - direct `path` dev dependency for `depend_on_referenced_packages`,
  - `@override` annotations for the locked reference-image test fields.

## Deferred analyzer items / residual warnings

Explicitly deferred by scope and left untouched:

- `unreachable_switch_case` in `lib/features/report/screens/customer_report_screen.dart`.
- `library_private_types_in_public_api` in `lib/shared/services/python_runner.dart`.
- `deprecated_member_use` value -> initialValue in `lib/features/measurements/screens/measurement_record_screen.dart`.
- `overridden_fields` restructure in `test/widget/reference_images_screen_test.dart`.
- `pumpAndSettle` migration.
- Any analyzer findings in files outside the allowlist.

## Evidence-boundary confirmation

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference Images and Board Canvas feature/evidence logic were not changed.
- No V2 implementation started.

## Validation

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat analyze`: reduced from 52 issues to 5 residual warnings/infos. Exit remains non-zero only because residual items are explicitly deferred by scope.
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/widget/measurement_write_screen_test.dart --reporter expanded`: PASS, 6 tests.
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`: PASS, 195 tests.
- `py -3 tools/validate_all.py`: PASS, 236 tests.
- `docs/AUDIT_INDEX.md` malformed literal backtick-n table artifact check: PASS.
- `measurement-error-message` success-path absence assertion check: PASS.
- `pubspec.yaml` and `pubspec.lock` are intentionally both in the final diff so the direct `path` dev dependency remains lockfile-consistent.

Residual analyzer items documented for post-audit:

- `lib/features/report/screens/customer_report_screen.dart`: `unreachable_switch_case`, explicitly deferred.
- `lib/features/measurements/screens/measurement_record_screen.dart`: `deprecated_member_use` value -> initialValue, explicitly deferred.
- `lib/shared/services/python_runner.dart`: `library_private_types_in_public_api`, explicitly deferred.
- `test/widget/reference_images_screen_test.dart`: `overridden_fields`, explicitly deferred.

## Next recommended pass

`V1_1_TEST_AND_LINT_HYGIENE_POST_AUDIT_PASS`
