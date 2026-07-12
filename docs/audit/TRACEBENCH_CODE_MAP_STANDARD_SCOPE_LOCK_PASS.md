# TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Profile: MINI
- Mode: docs-only scope lock
- Current: `TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS`

No code-map standard or index is created in this pass. No production map, test map, Board Canvas map, runtime, test, schema, tool, `_incoming`, Prompting Constitution, lint/tooling, or refactor change is authorized. Nothing is staged, committed, or pushed.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == f858a0e7c2e87c827f553ab1476be1547d3416b1`
- Commit subject: `docs: close out component category navigator`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Only known untracked scratch/design/generated files were present; they remain outside scope and unstaged.

The live route was `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`, so the human-selected code-map scope lock did not conflict with an armed pass. `docs/FILE_MAP.md` already classifies non-default documentation maps as task-specific/on-demand material and does not require an ownership change for this scope.

## Human strategy source

The human-supplied strategy in this pass is the authority for the framework direction. No `_incoming`, historical chat memory, generated prototype, or existing runtime file is treated as a code-map standard.

The strategy establishes a lightweight repo-local navigation and impact-evidence layer for large files while preserving the canonical route, scope, and protected-owner hierarchy.

## Framework authority and loading

- Code maps live under `docs/code_maps/**`.
- They are task-specific and remain outside the exact five-file default read set.
- Maps describe committed source state; they are not future-design documents or runtime truth.
- Maps are descriptive, not normative.
- Canonical specs, semantic owners, active scope locks, and source code outrank a map whenever they conflict.
- A map cannot authorize writes, add files to an allowlist, widen a pass, approve a refactor, or open a protected surface.

## Naming and anchor direction

Map paths must deterministically mirror their source paths under `docs/code_maps/**`. The bootstrap owns the exact convention and collision rules.

Map content must identify stable symbols, types, functions, methods, widgets, tests, and ownership boundaries rather than source line numbers. Line-number anchors are forbidden because routine edits make them stale. A map may link to a source path but must use symbol identity as the durable locator.

## Qualification direction

Bootstrap v1 is Dart-focused. The standard must define concise, deterministic qualification criteria for when a Dart source file benefits from a map.

Production and test files qualify independently. A production map does not automatically authorize or require a test map, and a test map does not automatically authorize or require a production map.

The standard/bootstrap and the first production map remain separate passes. This scope lock authorizes no actual source-file map.

## Index direction

`docs/code_maps/CODE_MAP_INDEX.md` lists maps that actually exist. It must not predeclare planned, proposed, candidate, future, or implied production/test maps.

At bootstrap, the index may contain only its purpose, interpretation rules, and an empty actual-map listing. The presence of the standard itself does not count as a production or test map.

## Required bootstrap contents

`TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS` must define in `CODE_MAP_STANDARD.md`:

1. purpose and authority;
2. deterministic source-to-map path convention;
3. Dart-focused qualification criteria;
4. a concise standard map template;
5. impact evidence classes;
6. write-class vocabulary;
7. update and drift policy;
8. Claude map-audit model;
9. SNIPER integration;
10. concision limits; and
11. explicit non-authorization rules.

The standard must require later work on mapped files to report exactly one map disposition per relevant map:

- `REVIEWED_NO_CHANGE`
- `UPDATE_REQUIRED`
- `NOT_APPLICABLE`

The bootstrap may define these statuses but may not apply them to a production/test map that does not yet exist.

## Update, audit, and workflow direction

- Maps describe committed state only; they do not document an unstaged draft as if accepted.
- The bootstrap must define when a committed source change makes a map stale and when a map update is required.
- Map maintenance remains explicit and evidence-backed; no automatic linter, generator, validator, watcher, pre-commit hook, or CI gate is authorized.
- Claude's future map audit remains read-only and checks map/source consistency, symbol anchoring, concision, actual-map indexing, and non-authorization compliance.
- SNIPER integration must keep map reads and updates proportional to the scoped task and must never widen an implementation allowlist.

## Armed bootstrap pass

`TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS` may create exactly:

- `docs/code_maps/CODE_MAP_STANDARD.md`
- `docs/code_maps/CODE_MAP_INDEX.md`

It may not edit `docs/FILE_MAP.md`, active route docs, Prompting Constitution files, runtime, tests, schemas, tools, or `_incoming`; create a Board Canvas, production, or test map; introduce tooling or linting; or refactor code.

If clean bootstrap implementation requires another file, stop with `BLOCKED_ALLOWLIST_MISMATCH`. If the standard direction conflicts with canonical governance, stop with `BLOCKED_GOVERNANCE_CONFLICT`.

## Preserved boundaries

This documentation framework changes no product, runtime, event/fact, writer, schema, validator, materializer, projection, Project ZIP, route behavior, package, asset, measurement, component identity, AI/OCR/CV, electrical, or Board Canvas semantics.

Known scratch/design/generated files remain untouched and outside any staging set. The Prompting Constitution MINI rules are inherited but not edited or duplicated.

## Current docs-only write set

This scope-lock pass writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS.md`

No `docs/code_maps/**` file is created yet. Do not stage, commit, or push from this pass.

## Route after this scope lock

- Current: `TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS`
