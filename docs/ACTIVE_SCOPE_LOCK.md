# Active task boundary and protected scope

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Authorization state

Accepted runtime baseline: `33cf477b6661d077b16b814965b1ac02bf953cb0`.
No further runtime implementation is reserved. The latest explicit human request
authorizes one bounded documentation sync; it does not select the next module,
create a PASS_ID or arm an implementation child.

The completed consolidation and older reservations are historical. Current
accepted source includes shared vocabulary, safe projection refresh, shared
candidate editing/local persistence, Navigator/Placement-preview extraction,
selection/mode routing, candidate drag decisions and interaction corrections.

## Exact documentation boundary

Only these existing files may change in this sync:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/WORKFLOW_FINDINGS.md`
- `docs/ARCHITECTURE_BOUNDARIES.md`
- `docs/ARCHITECTURE.md`
- `docs/PROJECT_MEMORY.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `README.md`

ARCHITECTURE_BOUNDARIES is the current implementation ownership summary;
ARCHITECTURE retains Sprint 0 history. Diagrams describe committed source, not
new functionality. Code Maps, AGENTS/CLAUDE, runtime/tests, schemas, assets,
fixtures, specifications and audit/archive material remain unchanged. No new files.

## Protected boundaries

- POHIKIRI and human confirmation remain authoritative. Rendering, selection and
  local candidate drafts do not create canonical truth.
- Event envelopes/payloads, writers, Session generation/dedup, materialization,
  evidence/repair semantics, persisted placement geometry and Project ZIP are frozen.
- Candidate sidecars are noncanonical, excluded from ZIP and distinct from
  original Wizard intake. Candidate-to-canonical confirmation/migration is deferred.
- Future new/changed canonical, writer, migration, persistence-compatibility or ZIP
  contracts require explicit protected scope and relevant independent review.
- The tooling-policy edit records the approved user-level Dart MCP exception and
  replaces the previous per-use PASS_ID/post-audit gate and approval matrix with
  documented task-bounded reuse rules. It authorizes no actual configuration
  change, install, real-project write or unrelated external tool. No Flutter
  suite/build, app launch or Computer Use here.
- No staging, commit, push, reset, stash, clean or destructive cleanup.

## Foreign material and history

Preserve byte-for-byte and exclude from the documentation commit set:

- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_COMPONENT_CANDIDATE_EDITOR_V1_SCOPE_LOCK_PASS.md`
- `windows/flutter/generated_plugin_registrant.cc`
- `windows/flutter/generated_plugin_registrant.h`
- `windows/flutter/generated_plugins.cmake`

The old editor draft is not authority for accepted implementation or future
confirmation work. Historical reservations remain in the
[complete committed scope snapshot](archive/ACTIVE_SCOPE_LOCK_HISTORY_2026-10-29.md),
captured at `69e5bd4`; existing audit artifacts/verdicts are not rewritten.

## Validation and next work

Check the exact nine-document diff, source/commit claims, finding statuses,
Current/Next agreement, local Markdown links, Mermaid syntax where permitted
local tooling exists, Git whitespace and frozen-file hashes. Run applicable
Python documentation validation in scratch; keep generated outputs out of this
checkout. Preflight PASS is not test or review acceptance.

After one independent read-only review and an exact human-authorized commit,
Current/Next remain NEEDS_USER_DECISION. CURRENT_STATE owns priorities and
PASS_QUEUE sequence. No additional review, audit-recording or implementation
programme is automatically created.
