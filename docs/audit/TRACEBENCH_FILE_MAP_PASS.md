# TRACEBENCH_FILE_MAP_PASS

## Pass metadata

- PASS_ID: `TRACEBENCH_FILE_MAP_PASS`
- Mode: docs-only file-map/index creation
- Route before pass: `NEEDS_USER_DECISION`
- Route after pass: `NEEDS_USER_DECISION`

## Source audits recorded

- `TRACEBENCH_MARKDOWN_GOVERNANCE_AND_MEMORY_SYSTEM_AUDIT`
- `TRACEBENCH_FULL_APP_READONLY_AUDIT`

## Purpose

Create a compact, table-first `docs/FILE_MAP.md` so future agents can identify documentation ownership, read priority, stale-risk, and update rules without bulk-reading audit history, archives, `_incoming`, or source/design provenance folders.

## Changed files

- `docs/FILE_MAP.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_PASS.md`

## Summary

- Added `docs/FILE_MAP.md` as the owner for docs classification, read priority, stale-risk, do-not-read-by-default guidance, and update rules.
- Registered FILE_MAP in `docs/TRUTH_INDEX.md` as the documentation classification/read-priority owner.
- Registered FILE_MAP in `docs/MEMORY_REGISTRY.yml` as first-read context while keeping route truth in the existing route docs.
- Updated `docs/SOURCES_INDEX_CURRENT.md` to point docs classification responsibility to FILE_MAP instead of maintaining duplicate governance-doc lists.
- Added this pass to `docs/AUDIT_INDEX.md`.

## Boundary confirmation

- No route docs were changed.
- No runtime, test, schema, tool, materializer, validator, writer, sample, fixture, asset, or `_incoming` files were changed.
- `docs/FILE_MAP.md` does not own current route state, audit verdicts, pass acceptance, or pushed status.
- `docs/AUDIT_INDEX.md` remains the pass-status owner.
- `docs/PASS_QUEUE.md` remains the active route/queue owner.
- `docs/ACTIVE_SCOPE_LOCK.md` remains the active allowlist owner.
- `docs/TRUTH_INDEX.md` remains the invariant/ownership owner.
- `docs/SOURCES_INDEX_CURRENT.md` remains the source/design intake pointer owner.

## Validation plan

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit packet marker

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW
