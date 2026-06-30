# Active Scope Lock

## Current pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS`

## Next recommended pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS`

## Current armed implementation pass

None.

## Type

CODEX / DOCS_DRIFT_MINI_CLEANUP / cleanup_or_archive_planning

## Status

Docs-only compaction lock is active. No product/runtime implementation pass is armed.

## Active write allowlist

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/PASS_QUEUE_ARCHIVE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS.md

## Boundaries

- Docs only.
- No runtime edits.
- No test edits.
- No schema/tool/asset/pubspec edits.
- No _incoming staging or runtime dependency.
- No protected/canonical changes.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics changes.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes.
- No product/runtime implementation route is selected by this cleanup pass.

## Route handling

- Starting route was NEEDS_USER_DECISION across docs/CURRENT_STATE.md, docs/PASS_QUEUE.md, and this lock.
- Current route is `TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS`.
- Next recommended route is `TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS`.
- Post-audit closeout should release this docs-hygiene lock and return the route to NEEDS_USER_DECISION unless the user explicitly selects another pass.