# Active Scope Lock

## Current pass

`LEAN_AUDIT_PROMPT_PROTOCOL_PASS`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Docs-only governance pass. Do not implement code or modify runtime, tests, tools, validator, materializer, schemas, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Add/Edit Component implementation, Activity Timeline, Measure Momentum, assets, samples, generated artifacts, platform folders, tags, or releases.

## Next recommended pass

`LEAN_AUDIT_PROMPT_PROTOCOL_POST_AUDIT_PASS`

After accepted post-audit and closeout, route back to `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`.

## Write allowlist

- `docs/AUDIT_CONTRACT.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/MODEL_ROUTING.md` only if a compact pointer is needed
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/audit/LEAN_AUDIT_PROMPT_PROTOCOL_PASS.md`

## Required content

- Add reusable standard audit contracts for `scope-lock-post-audit`, `implementation-post-audit`, `docs-closeout`, `route-review`, and `recovery / evidence-recheck`.
- Preserve scope-lock discipline, post-audit gates, route consistency checks, protected-surface boundaries, validation requirements, and safe-to-commit gates.
- Document the lean prompt format: `PASS_ID`, `TYPE`, `LANE`, `CODEX`, `FOCUS`, and `APPLY STANDARD AUDIT CONTRACT`.
- Document lean-read rules for auditors.
- Document cases where full prompts remain required.
- Add short examples for scope-lock post-audit, implementation post-audit, docs closeout, and evidence recheck.
- Add a compact pointer in `docs/PROMPTING_PROTOCOL.md`.

## Forbidden surfaces

- No Flutter runtime changes.
- No tests.
- No tools, validator, materializer, writer service, schema, or Project ZIP changes.
- No Board Canvas or Reference Images runtime changes.
- No AI/OCR/CV implementation.
- No Add/Edit Component implementation.
- No Activity Timeline or Measure Momentum implementation.
- No assets, samples, generated artifacts, platform folders, tags, or releases.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`

## Route lock

Current: `LEAN_AUDIT_PROMPT_PROTOCOL_PASS`.
Next: `LEAN_AUDIT_PROMPT_PROTOCOL_POST_AUDIT_PASS`.
Return route after accepted post-audit and closeout: `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`.
