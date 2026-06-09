# V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is the correct tool for this repo-local docs-only scope lock. No implementation, schema, validator, materializer, writer-service, Flutter runtime, test, Project ZIP, tag, or release work is required.

## Startup state

- Branch: `main`.
- Remote: `origin https://github.com/Fuuduuu/TraceBench.git`.
- HEAD at startup: `331125f docs: triage Gemini save measurement security findings`.
- Tracked working tree before scope-lock edits: clean.
- Existing untracked local artifacts were present and left untouched.

## Scope drift check

PASS. This pass creates a docs-only scope lock. It does not modify Flutter runtime, tests, writer service, validator, materializer, schema files, Project ZIP logic, Board Canvas, Reference Images, AI/OCR/CV, Activity Timeline, Measure Momentum, Add/Edit Component, assets, samples, platform folders, generated artifacts, tags, or releases.

## Verdict

PASS. Future Save Measurement path/project-directory canonicalization hardening scope is locked, pending post-audit.

## Background

- `V2_SAVE_MEASUREMENT_PASS` is implemented, audited, accepted, pushed, and closed out.
- Gemini advisory triage is accepted/pushed.
- Gemini TRC-01 is recorded as MEDIUM candidate hardening around `V2SaveMeasurementService` / `_joinPath`.
- Gemini TRC-03 is design-sensitive and must not be blindly changed in this pass.
- Add Component remains deferred until after this hardening route.

## Locked future implementation scope

Future implementation pass may address only Save Measurement project-directory/path canonicalization around the Dart writer adapter.

Future implementation may:

- normalize/canonicalize the project directory path before deriving `events.jsonl`;
- ensure the derived `events.jsonl` path stays inside the selected local project directory;
- reject missing, relative, malformed, traversal-like, or non-canonical project directory inputs before writer invocation;
- use platform-safe path handling if already available or minimally introduced;
- add focused unit/widget tests for accepted and rejected path cases;
- preserve the accepted writer-service boundary.

## Future implementation candidate allowlist

Exact future allowlist must be re-locked in the implementation pass, but this scope lock permits considering only:

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart` only if required for clear not-saved error mapping
- existing focused Measure Sheet / Save Measurement tests only
- governance/audit docs for the future implementation pass

## Future forbidden surfaces

Future implementation must not:

- modify `tools/event_writer_service.py` behavior unless a later audited scope explicitly decides it is necessary and safe;
- change validator behavior;
- change materializer behavior;
- change schema files or JSON schemas;
- change Project ZIP import/export;
- change Board Canvas;
- change Reference Images;
- change AI/OCR/CV;
- change Activity Timeline;
- change Measure Momentum;
- change Add/Edit Component;
- change deterministic `clientOperationId` semantics;
- introduce UUID/ULID changes for TRC-03;
- introduce broad filesystem refactors;
- introduce app-wide storage architecture changes;
- introduce platform folder changes;
- touch generated artifacts, assets, samples, tags, or releases.

## TRC-01 handling

TRC-01 is accepted as MEDIUM candidate hardening.

Future implementation must:

- fail closed when project directory cannot be canonicalized;
- fail closed when `events.jsonl` would resolve outside the project directory;
- not pass unsafe paths to the Python writer;
- return a clear not-saved error to UI;
- never silently redirect writes to another directory;
- preserve writer-service validation-before-append, lock, idempotency, durable append, and readback guarantees;
- preserve Save Measurement event construction and accepted behavior.

## TRC-03 exclusion

TRC-03 is not part of this hardening scope.

Deterministic `clientOperationId` is currently tied to idempotent retry / duplicate prevention semantics. Any UUID/ULID or random operation ID change requires a separate design review and scope lock.

## Future test requirements

Future implementation must add focused tests proving:

- normal local project directory still saves successfully;
- missing project directory remains not-saved;
- traversal-like `projectDirectory` is rejected;
- `events.jsonl` path cannot escape selected project directory;
- canonicalized path is used for writer invocation;
- writer is not called when path validation fails;
- error maps to not-saved outcome;
- Save Measurement still emits only `measurement_recorded`;
- idempotent existing writer result still does not duplicate local `ProjectState.events`.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No Add/Edit Component implementation.
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- No Photo Markup / Repair Map / Visual Trace Shape Assist.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation.
- No automatic second event.

## Route decision

Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`.

Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to implementation before post-audit accepts this scope lock. Do not route to Add Component yet.

## Validation required

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
