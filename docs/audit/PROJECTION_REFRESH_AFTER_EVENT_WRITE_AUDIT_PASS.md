# PROJECTION_REFRESH_AFTER_EVENT_WRITE_AUDIT_PASS

- Status: completed
- Lane: DOCS_SYNC / AUDIT_ONLY
- Verdict: ACCEPT_READY_FOR_CODEX for scope-lock handoff
- Commit: `e52cab0`

## Findings

- Accepted policy for post-write projection freshness is POLICY_D: export-time refresh + global stale indicator.
- `measurement_recorded` appends only to local unpacked `events.jsonl`.
- `known_facts.json` is not mutated by the accepted append flow.
- `ProjectState.isProjectionStale` is set after local event append.
- Derived views may remain stale until refresh.
- Python materializer remains canonical projection owner.
- Dart-native known_facts materializer is rejected for V1.
- Bundled mobile export remains deferred.
- No event-writing flow in V1 creates `net_connection_confirmed`.
- No component/pin/photo/annotation write paths are introduced.
- No AI-authored measurement values or inferred targets/units are accepted.
- `events.jsonl` and `known_facts.json` remain mutable only by their accepted owners and were not updated by this policy decision.

## Validation

- `py -3 tools\validate_all.py` passed.
- `dart format` was not run (docs-only scope).
- `flutter test` was not run (docs-only scope).

## Forbidden-surface confirmation

- No repository file changes were made during this audit.
- No implementation files or tool/materializer code was modified.
- No `schemas/`, `tools/`, `tests/`, `samples/`, `assets/`, `lib/`, or `pubspec*` edits.
