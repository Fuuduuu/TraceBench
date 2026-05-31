# V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS

## PASS_ID
`V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only V1 release-candidate scope lock.

## Reason

- `V1_RELEASE_READINESS_REPO_AUDIT_PASS` concluded `READY_WITH_NITS` (no true blockers).
- `DOCS_DRIFT_MINI_CLEANUP_PASS` completed countdown/routing cleanup.
- V1 now needs a formal release-candidate scope contract before any release-candidate execution flow.

## V1 included scope (locked)

- Event-backed Known Facts Builder.
- Canonical event log + schema/validator + accepted-only materializer projection.
- KnownFacts schema and Dart read-only model support.
- Project ZIP local-first import/export/validation contract.
- Forbidden-artifact rejection for `board_graph.json` and `view_state.json`.
- Read-only Board Canvas route/navigation + board_normalized placement + selector + read-only metadata panels.
- Read-only boardview polish and text-visible evidence-class labels.
- Positive smoke fixture + positive manual smoke PASS evidence.
- Persistent read-only chrome: `renderer writes: none`.

## V1 excluded/deferred scope (locked)

- Background photo helper.
- Transform/matrix computation.
- Photo-local evidence board rendering.
- `visual_trace`/damage/suspect/measurement canvas geometry overlays.
- Event-writing UI and edit/confirm/save/apply/promote/detect controls.
- AI proposal/detection/candidate UI.
- Project ZIP contract expansion.
- Persisted view state and any `board_graph.json`/`view_state.json` behavior.
- Visual/evidence metadata promotion into electrical/fault truth.

## Evidence boundaries (locked)

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` canonical truth; `known_facts.json` materialized projection.
- Renderer/view writes nothing.
- Photo pixels are not facts.
- Photo alignment is not identity/pin-map/net/measurement/fault proof.
- `visual_trace` is not a net.
- Damage is not fault proof.
- Suspect is not probability.
- `template_id` is geometry/package metadata only, not identity.

## Release-candidate checklist (locked)

- Tracked working tree clean.
- `py -3 tools\validate_all.py` PASS.
- Flutter full test suite PASS.
- `tests.test_asset_sample_sync` PASS.
- `tests.test_project_zip` PASS.
- `tests.test_materialize_known_facts` PASS.
- `tests.test_validate_events_jsonl` PASS.
- Positive fixture present and valid.
- Positive manual smoke PASS recorded.
- No `board_graph.json` / `view_state.json`.
- No evidence-boundary weakening.
- Docs current/next routing aligned.
- Known non-blocking warnings documented.

## Non-blocking nits (accepted for V1 RC)

- Missing optional photo warning for `photos/top_backlight_001.jpg`.
- `validate_all.py` does not auto-validate `board_canvas_positive_smoke` (future tools hardening).
- Hardcoded board substrate colors accepted for V1.
- No V1 git tag yet (later release action).
- Local untracked IDE/platform artifacts remain non-blocking.

## Next recommended pass

`V1_RELEASE_CANDIDATE_SCOPE_LOCK_AUDIT_PASS`

## Validation result

- `py -3 tools\validate_all.py` passed.
- Docs-only changed surfaces confirmed by `git diff --name-only`.
- Final status verified with `git status --short --branch`.

## Forbidden-surface confirmation

- No code/schema/tool/test/sample/asset/runtime/product behavior changes.
- No generated artifacts.
- No git tag creation.
- No release artifacts.
