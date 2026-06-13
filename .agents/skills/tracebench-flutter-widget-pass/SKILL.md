# tracebench-flutter-widget-pass

Reusable workflow for TraceBench narrow Flutter/Dart UI/widget passes.

## Required start

- Read `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` first.

## Scope and safety

- Identify exact runtime files and focused test files.
- Require focused widget tests for UI behavior changes.
- Prefer focused test command plus analyzer/format/lint command if available.
- Do not touch schema/materializer/writer-service/Project ZIP unless explicitly scoped.
- Do not change dependencies or lockfiles unless explicitly scoped.

## Save/Add/Edit protections

For Save Measurement / Add Component / Edit Component passes:

- preserve V2 event boundaries
- preserve human confirmation path
- preserve runtime boundaries
- do not alter canonical event semantics as side effect

## Typical check list

- targeted widget test command
- formatter/analyzer baseline command (if configured)
- narrow regression file review