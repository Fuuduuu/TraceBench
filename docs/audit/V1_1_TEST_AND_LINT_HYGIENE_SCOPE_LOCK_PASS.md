# V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS

PASS_ID: `V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC / SCOPE_LOCK`
Mode: Docs-only scope lock. No code/test/tool/schema/sample/tag changes in this pass.

## Inputs accepted

- `V1_1_POST_MEMORY_RECONCILIATION_ROUTE_REVIEW_PASS` (AUDIT_ONLY) recommended this behavior-preserving test/lint/docs hygiene pass as the next step; this lock adopts that recommendation. (Live route pointer still named the route review as "next" because route reviews do not write.)
- Whole-repo debug audit + `flutter analyze` snapshot below.

## Analyzer snapshot (this pass)

`flutter analyze` = **52 issues, 0 errors** (all info/warning). By rule:
`prefer_const_constructors` 24 · `unnecessary_to_list_in_spreads` 4 · `unused_import` 5 · `unnecessary_non_null_assertion` 3 · `unused_local_variable` 2 · `unnecessary_brace_in_string_interps` 2 · `prefer_const_declarations` 2 · `annotate_overrides` 2 · `deprecated_member_use` 2 · `overridden_fields` 2 · `unreachable_switch_case` 1 · `unnecessary_import` 1 · `library_private_types_in_public_api` 1 · `depend_on_referenced_packages` 1.

## Decision

One combined behavior-preserving implementation pass is **safe** for the mechanical subset. Lock `V1_1_TEST_AND_LINT_HYGIENE_PASS` as next. Carve out 4 judgment items + the pumpAndSettle migration as **deferred** (they would require behavior judgment or API changes and must not be mixed into a mechanical hygiene pass).

## Locked hygiene scope (next pass = `V1_1_TEST_AND_LINT_HYGIENE_PASS`)

**A. Docs formatting repair**
- Repair the literal backtick-n (`` `n ``) artifacts in `docs/AUDIT_INDEX.md` (introduced by closeout commit `005e772`) that merge the table separator + the two newest rows. Restore proper markdown table rows. No history rewrite, no row deletion, no pruning.

**B. Measurement-write missing assertion**
- In `test/widget/measurement_write_screen_test.dart` (the "shows success and stale refresh message" test), assert the error message is absent — `expect(errorFinder.evaluate().isEmpty, isTrue);` (or equivalent project style). No production behavior change.

**C. Analyzer/lint cleanup — ALLOWED rule categories only (mechanical, behavior-preserving):**
- `prefer_const_constructors`, `prefer_const_declarations`
- `unused_import`, `unnecessary_import`
- `unnecessary_to_list_in_spreads`
- `unnecessary_brace_in_string_interps`
- `unnecessary_non_null_assertion`
- `annotate_overrides` (add `@override` only)
- `deprecated_member_use` **only** the `withOpacity` → `.withValues(alpha:)` swap
- `depend_on_referenced_packages` for `path` — fixed **only** by adding `path` to `dev_dependencies` in `pubspec.yaml`

The impl must re-run `flutter analyze` and fix only the above rule categories in the analyzer-flagged files; no logic, behavior, state, UI copy, evidence semantics, data model, schema, or runtime change.

**D. pumpAndSettle migration — DEFERRED** (not in this pass; would expand scope).

## Explicitly DEFERRED (do NOT touch in the hygiene pass)

- `unreachable_switch_case` in `lib/features/report/screens/customer_report_screen.dart` (the `_ =>` default on the sealed `ExportResult` switch is forward-compat defensive code; removing it reduces future safety — defer/keep).
- `library_private_types_in_public_api` in `lib/shared/services/python_runner.dart:90` (fix is an API-visibility change, not mechanical — defer).
- `deprecated_member_use` value→initialValue in `lib/features/measurements/screens/measurement_record_screen.dart:198` (`value:`/`initialValue:` on a FormField have different controlled-vs-initial semantics — behavior judgment, defer).
- `overridden_fields` restructure in `test/widget/reference_images_screen_test.dart:70,94` (removing the field and overriding getter/setter could change the fake's behavior; only the `annotate_overrides` `@override` annotation is in scope — defer the restructure).
- All `pumpAndSettle` migration.

## Exact allowed implementation files (next pass)

Docs / governance:
- `docs/AUDIT_INDEX.md` (item A + pass rows)
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_PASS.md`

Test (item B + mechanical lint):
- `test/widget/measurement_write_screen_test.dart`
- `test/widget/reference_images_screen_test.dart` (allow `annotate_overrides`/`prefer_const`; defer `overridden_fields` restructure)
- `test/widget/customer_report_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/unit/board_graph_projection_test.dart`
- `test/unit/event_parsing_test.dart`
- `test/unit/project_exporter_test.dart`
- `test/integration/pelle_sample_end_to_end_test.dart`

Lib (mechanical lint only — listed files have only allowed-category issues):
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `lib/features/board_graph/widgets/board_graph_canvas.dart`
- `lib/features/photos/screens/photo_list_screen.dart`
- `lib/features/reference_images/screens/reference_images_screen.dart`
- `lib/features/reference_images/services/reference_image_sidecar_service.dart`
- `lib/shared/models/project_state.dart`
- `lib/shared/services/project_loader.dart`
- `lib/shared/widgets/projection_stale_banner.dart` (withOpacity→withValues)

Dependency manifest:
- `pubspec.yaml` (add `path` to `dev_dependencies` only; no version/dependency changes beyond this)

Excluded lib files (only carry deferred-rule issues — do NOT modify): `lib/features/report/screens/customer_report_screen.dart`, `lib/shared/services/python_runner.dart`, `lib/features/measurements/screens/measurement_record_screen.dart`.

## Forbidden surfaces (next pass)

- No feature work; no product/evidence semantics changes; no event-writing.
- No Reference Images / Board Canvas feature or evidence logic changes (lint-only edits in their files must not alter behavior).
- No Project ZIP / schema / materializer / tools / sample / asset / generated-artifact / tag / release changes.
- No `board_graph.json` / `view_state.json`; no V2; no commercial/licensing.
- No audit-history pruning; no broad formatting sweep; no broad test refactor.
- None of the explicitly-deferred analyzer items above.

## Required validation (next pass)

- `flutter analyze` (issue count materially reduced; only the explicitly-deferred items may remain; document residual count).
- `flutter test test/widget/measurement_write_screen_test.dart --reporter expanded`.
- `flutter test --reporter expanded` (full suite green).
- `py -3 tools\validate_all.py` (PASS).
- `git diff --name-only` (only allowed files); verify no forbidden surface changed.
- Verify `docs/AUDIT_INDEX.md` no longer contains literal `` `n `` table artifacts.
- Verify the success test asserts the error message is absent.

## Validation (this scope-lock pass)

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py`

## Next recommended pass

`V1_1_TEST_AND_LINT_HYGIENE_PASS` (Codex implements after this lock; Claude Code post-audit with `flutter analyze` + full tests + `validate_all.py`).
