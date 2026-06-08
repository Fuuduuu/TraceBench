# V2_SAVE_MEASUREMENT_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local scoped Flutter/UI implementation because the V2 architecture, schema/spec, validator extension, materializer projection, writer service, and Save Measurement scope lock are accepted and closed out.

This pass changes only the Measure Sheet Save Measurement UI flow, a narrow Dart adapter for the accepted Python writer service, focused tests, allowed governance docs, and this audit record.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `d37f12c docs: close out V2 save measurement scope`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_SAVE_MEASUREMENT_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_SAVE_MEASUREMENT_PASS`.

## Scope drift check

PASS. Actual changes stayed within the accepted Save Measurement implementation boundary:

- Measure Sheet UI flow,
- minimal Dart adapter for the accepted writer service,
- focused widget/unit tests,
- allowed governance docs,
- this audit record.

No writer service behavior, validator behavior, materializer behavior, schema files, JSON schema files, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, platform folders, tags, or release objects were changed.

## Verdict

PASS. The scoped Save Measurement UI write flow creates a V2 `measurement_recorded` candidate only after explicit human action and submits it through the accepted writer service. The UI does not append directly to `events.jsonl`.

## Small patch follow-up

`V2_SAVE_MEASUREMENT_SMALL_PATCH_PASS` resolved the GPT Pro substitute post-audit `NEEDS_SMALL_PATCH` findings:

- HIGH-01: `V2SaveMeasurementService` now hard-codes candidate `event_type` to `measurement_recorded` at the service boundary, so a request-level override cannot create another event type.
- HIGH-02: the Measure Sheet UI now checks local `ProjectState.events` for an existing `event_id` or available `client_operation_id` before appending the writer result to local UI state.

The patch also fixed changed-file analyzer nits only: unnecessary string-interpolation braces and deprecated `DropdownButtonFormField.value` usage.

## Files changed

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `test/widget/measure_sheet_screen_test.dart`
- `test/unit/v2_save_measurement_writer_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because no new stable product invariant needed a compact pointer; implementation evidence and routing state live in this audit record and governance ledgers.

## Save Measurement implementation summary

- Added a Save Measurement form to the existing Measure Sheet surface.
- The save control stays disabled until the user has selected a target context, entered a measured value, and selected a unit/mode.
- Save writes only after explicit human action.
- Successful save updates local UI state with the returned event and marks projection state stale for later refresh.
- Selected `Koht` / target context remains visible after save.
- Reference Values and Guided Measurement Helper remain display/read-only surfaces.

## Event construction / writer usage summary

- Added `V2SaveMeasurementService` in `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- The service builds a V2 `measurement_recorded` candidate with `schema_version = 2.0-draft`.
- Candidate events include `event_id`, `event_type`, `created_at`, `project_id`, `client_operation_id`, `actor`, `source`, `confirmation`, and `payload`.
- Payload includes `measurement_id`, `measured_at`, `target`, `reading`, and `value_provenance`.
- The adapter calls the accepted Python writer service at `tools/event_writer_service.py`.
- The UI/provider code does not append directly to `events.jsonl`.
- The accepted writer service remains responsible for validator-before-append, lock handling, idempotency, append durability, and readback verification.
- The adapter does not call materializer, Project ZIP, export, Board Canvas, Reference Images, AI/OCR/CV, URL import, or source search code.

## Human confirmation / value provenance summary

- Saved events use `actor.type = human`.
- Saved events use `source.type = explicit_user_confirmation`.
- Saved events use `confirmation.confirmed = true`.
- The measured value source is recorded as `human_entered`.
- Reference/helper/candidate values are treated only as visible context and are not used as measured values.
- Helper/reference/candidate values do not auto-fill the measured field.
- One-tap promotion of helper/reference/candidate values remains forbidden.
- Save Measurement does not infer net identity, confirmed pin mapping, component identity, diagnosis, probability, confidence, or fault ranking.

## Error handling summary

The UI surfaces not-saved states for:

- validation failure,
- writer append/readback failure,
- writer lock conflict,
- unavailable writer service or Python runtime,
- missing local project directory.

Idempotent duplicate retry is treated as an existing successful writer result and does not duplicate events in local UI state.

## Tests added/updated

Added and updated focused tests for:

- Save button disabled until human-entered value and unit are present.
- Helper/reference/candidate values do not auto-fill measured value.
- No one-tap helper/reference/candidate value promotion controls are present.
- Valid Save Measurement calls the writer once and preserves selected `Koht`.
- Rapid double tap produces one writer call.
- Writer validation, append, and lock failures show not-saved states.
- Idempotent duplicate retry does not duplicate the event in local UI state.
- Existing writer result with a matching local operation id does not duplicate `ProjectState.events`.
- Event adapter constructs a V2 `measurement_recorded` candidate and invokes only the accepted writer service.
- Event adapter keeps `measurement_recorded` even if a request attempts a non-measurement event type override.
- Event adapter preserves actor/source/confirmation and value provenance.
- Event adapter maps validation and lock failures without claiming saved.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No direct UI append to `events.jsonl`.
- No writer service behavior changes.
- No validator behavior changes.
- No materializer behavior changes.
- No schema files or JSON schema files.
- No Project ZIP changes.
- No Board Canvas runtime changes.
- No Reference Images runtime changes.
- No AI/OCR/CV, URL import, or source search changes.
- No generated artifacts, platform folders, tags, or release objects.
- No `board_graph.json` or `view_state.json` generation.
- No Add/Edit Component implementation.
- No Activity Timeline implementation.
- No Measure Momentum implementation.

## Validation result

PASS.

- `dart format lib\features\measure_sheet\screens\measure_sheet_screen.dart lib\features\measure_sheet\services\v2_save_measurement_writer.dart test\widget\measure_sheet_screen_test.dart test\unit\v2_save_measurement_writer_test.dart`: formatted 4 files.
- `flutter test test\widget\measure_sheet_screen_test.dart test\unit\v2_save_measurement_writer_test.dart --reporter expanded`: PASS, 24 tests.
- `flutter test --reporter expanded`: PASS, 220 tests.
- `py -3 tools\validate_all.py`: PASS, 268 tests.
- `flutter analyze`: existing baseline reports 5 issues outside this patch's allowed files; no changed-file analyzer issues remain.
- `dart analyze lib\features\measure_sheet\screens\measure_sheet_screen.dart lib\features\measure_sheet\services\v2_save_measurement_writer.dart test\widget\measure_sheet_screen_test.dart test\unit\v2_save_measurement_writer_test.dart`: PASS, no issues found.
- `git status --short --branch`: implementation/docs tracked changes plus known unrelated untracked paths.
- `git diff --name-only`: allowed implementation, test, and governance docs only; new service/test/audit artifacts appear in `git status` until staged.

## Any NITs

None.

## Safe for Claude Code / Opus post-audit

YES. The pass is ready for GPT Pro re-audit / Claude Code post-audit. Expected next pass: `V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`.

## Next recommended pass

`V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`
