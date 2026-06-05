# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a behavior-preserving test/lint/docs hygiene pass: repair the `AUDIT_INDEX.md` backtick-n table artifact, add the missing measurement-write error-absence assertion, and clear the mechanical analyzer warnings. No logic/behavior/evidence-semantics change.

## Accepted input

- `V1_1_POST_MEMORY_RECONCILIATION_ROUTE_REVIEW_PASS` (AUDIT_ONLY) recommended this pass; this lock adopts that recommendation. Memory-system reconciliation chain is accepted/pushed.
- `flutter analyze` = 52 issues, 0 errors (info/warning only).

## Allowed docs surfaces (this pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS.md`

## Locked decision

One combined behavior-preserving pass `V1_1_TEST_AND_LINT_HYGIENE_PASS` covering: (A) AUDIT_INDEX `` `n `` repair, (B) measurement-write error-absence assertion, (C) mechanical analyzer cleanup (allowed rule categories only). pumpAndSettle migration and 4 judgment analyzer items are DEFERRED. Full scope, exact allowed files, allowed/deferred rule categories, and validation are detailed in `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS.md`.

## Locked implementation surfaces (next pass)

Docs: `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/audit/V1_1_TEST_AND_LINT_HYGIENE_PASS.md`.
Test: `test/widget/measurement_write_screen_test.dart`, `test/widget/reference_images_screen_test.dart`, `test/widget/customer_report_screen_test.dart`, `test/widget/new_project_wizard_screen_test.dart`, `test/unit/board_graph_projection_test.dart`, `test/unit/event_parsing_test.dart`, `test/unit/project_exporter_test.dart`, `test/integration/pelle_sample_end_to_end_test.dart`.
Lib (mechanical lint only): `lib/features/board_canvas/screens/board_canvas_screen.dart`, `lib/features/board_graph/screens/board_graph_screen.dart`, `lib/features/board_graph/widgets/board_graph_canvas.dart`, `lib/features/photos/screens/photo_list_screen.dart`, `lib/features/reference_images/screens/reference_images_screen.dart`, `lib/features/reference_images/services/reference_image_sidecar_service.dart`, `lib/shared/models/project_state.dart`, `lib/shared/services/project_loader.dart`, `lib/shared/widgets/projection_stale_banner.dart`.
Manifest: `pubspec.yaml` (add `path` to `dev_dependencies` only).

Excluded lib files (deferred-rule only, do NOT modify): `lib/features/report/screens/customer_report_screen.dart`, `lib/shared/services/python_runner.dart`, `lib/features/measurements/screens/measurement_record_screen.dart`.

## Deferred (not in the hygiene pass)

- `unreachable_switch_case` (customer_report_screen.dart), `library_private_types_in_public_api` (python_runner.dart), value→initialValue deprecation (measurement_record_screen.dart), `overridden_fields` restructure (reference_images_screen_test.dart), all `pumpAndSettle` migration.

## Forbidden surfaces (next pass)

- No feature/product/evidence-semantics/event-writing changes; no behavior change in lib lint edits.
- No Reference Images/Board Canvas feature logic; no Project ZIP/schema/materializer/tools/sample/asset/generated-artifact/tag/release changes.
- No `board_graph.json`/`view_state.json`; no V2/commercial/licensing.
- No audit-history pruning; no broad formatting sweep; no broad test refactor; none of the deferred analyzer items.

## Hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` canonical truth; `known_facts.json` materialized projection; renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` / `view_state.json` forbidden V1 artifacts.
- `visual_trace` is not a net; `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts; photo alignment is not identity/pin/net/measurement/fault proof; damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.

## Required validation

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py`

## Next recommended pass

`V1_1_TEST_AND_LINT_HYGIENE_PASS`
