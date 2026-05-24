# FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS

Status: completed

Lane: DOCS_SYNC

Scope: docs-only, V1 Flutter ZIP export scope lock before implementation.

## Scope lock summary

- Primary V1 direction is Desktop/dev export-first, with mobile export remaining placeholder.
- Flutter V1 constraints:
  - Flutter must not mutate `known_facts.json` directly.
  - Flutter must not add a Dart-native materializer.
  - Flutter must not write `events.jsonl` except already accepted `measurement_recorded` flow.
  - `ProjectionStaleBanner` remains display-only.
- ZIP contract remains unchanged:
  - no contract expansion,
  - no `board_graph.json`,
  - no `view_state.json`.
- Security baseline from `PROJECT_ZIP_SECURITY_HARDENING_PASS` is locked:
  - symlinked files are rejected from ZIP export,
  - absolute/traversal photo paths are invalid portable references.

## Gemini ZIP Export Scope Research (cleaned summary)

- High-level technical feasibility was interpreted as: desktop export path is implementable with the existing local ZIP contract, while mobile Python/materializer support is a separate platform constraint.
- Risk framing retained: mobile placeholder assumptions are valid for V1; no bundled Python or SAF/share-sheet implementation is assumed.
- Explicitly rejected assumptions:
  - no 4–6 week delivery timeline dependency is accepted as scope,
  - no AI model/gigabyte-scale inference dependency is accepted,
  - no iOS/macOS bundling path is accepted in V1,
  - no immediate expansion of ZIP contract or mobile runtime behavior.

## Locked decisions for V1

1. Export scope lock: Desktop/dev is the intended V1 implementation direction.
2. Mobile export: remains placeholder in V1.
3. Known-facts ownership: Python materializer remains canonical; Flutter remains read-only display layer for stale state.
4. ZIP artifact boundary: preserve forbidden artifact rules and optional-photo warning behavior.
5. Known-facts mutation and event semantics remain unchanged by Flutter.

## Explicit "do not do yet" list

- No Flutter ZIP export implementation in this pass.
- No Dart-native materializer in this pass.
- No mobile platform export implementation in this pass.
- No Android SAF, MANAGE_EXTERNAL_STORAGE, or share-sheet implementation in this pass.
- No new ZIP paths or contract extension.
- No project ZIP contract changes in UI code or tools.

## Test matrix for next implementation pass

- forbidden artifact exclusion
  - `board_graph.json` and `view_state.json` are not exported in V1.
- stale UI banner text is not included in exported `customer_report.md` artifacts.
- no Flutter-side `known_facts.json` mutation.
- no unauthorized `events.jsonl` writes.
- mobile export remains placeholder behavior.
- desktop/dev export boundary behavior (packaging path, artifact set, authority handoff).
- materializer failure behavior (export fails safely when materialization fails).
- stale state is not cleared unless import/reload flow completes successfully.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- `git diff --check`
- `git diff --name-only`
- `git status --short --branch`

## Forbidden-surface confirmation

- No `lib/`, `tools/`, `schemas/`, `samples/`, or `assets/` changes.
- No platform folders (`android`, `ios`, `macos`, `windows`, `linux`) changed.
- No `pubspec.yaml` / `pubspec.lock` changes.
- No Flutter implementation changes.
- No Project ZIP contract expansion.
- No event-writing implementation changes.
