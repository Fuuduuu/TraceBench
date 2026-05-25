# FLUTTER_ZIP_EXPORT_POLISH_SCOPE_REVIEW_PASS

Status: completed

Lane: DOCS_SYNC

Scope: docs-only scope review to close the export polish loop.

## Summary

- `FLUTTER_ZIP_EXPORT_PASS` is implemented as a desktop/dev handoff:
  - `ProjectExporter` calls materializer then export tool in order.
  - Mobile path remains placeholder.
- `FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS` completed with `PASS_WITH_NITS`.
- `FZ-02` is fixed by `FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS` (sanitized user-facing export failure messages).
- `FZ-01` is formally closed as V1 accepted risk.

## FZ-01 PROCESS TIMEOUT — V1 ACCEPTED RISK, FORMALLY CLOSED

### Finding

- `ProjectExporter` currently uses `Process.run(...).timeout(…)`.
- On timeout the process is not explicitly terminated via managed lifecycle control.
- A timeout can allow a subprocess to continue briefly in background.

### V1 accepted rationale

- V1 export is desktop/dev scope only.
- `materialize_known_facts.py` and `export_project_zip.py` are short-running for expected developer workflows.
- No data-integrity or security boundary break was observed from this timeout behavior in current V1 scope.
- Export success does not mutate `known_facts.json` from Dart nor write `events.jsonl`.
- Stale-state clearing remains disallowed in this scope.
- Known-facts materialization and ZIP contract ownership stays in Python tooling.

### Deferred fix path

- Fix is deferred until practical need in later scope:
  - `FLUTTER_PROCESS_LIFECYCLE_HARDENING_PASS`
- Suggested future implementation direction:
  1. Replace `Process.run(...).timeout(...)` with `Process.start(...)`.
  2. Capture `stdout`/`stderr` streams.
  3. Use explicit timeout against child process result.
  4. On timeout, terminate subprocess (and child process tree where platform support is safe).
- This adds process-lifecycle complexity beyond current V1 polish scope.

## State after review

- Export audit/polish sequence is closed in V1.
- No `FZ-02` follow-up required.
- `FLUTTER_PROCESS_LIFECYCLE_HARDENING_PASS` remains deferred and only if timeout handling becomes observable in use.

## Routing

- Next recommended pass: `USER_DECISION_NEXT_FEATURE_PASS`
- Recommended scope: choose next milestone via governance/user decision after export handoff stabilization.

## Forbidden-surface confirmation

- No `lib/**`, `tools/**`, `schema/**`, or `platform/**` changes.
- No new `sample/**`, `asset/**`, or `pubspec.*` changes.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, `view_state.json` edits.
- No Flutter ZIP export implementation or process-lifecycle (`Process.start`) change.
- No stale-state clearing / known_facts mutation / event-writing changes introduced.
