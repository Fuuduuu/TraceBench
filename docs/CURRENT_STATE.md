# Current State

## Current pass

`LEAN_AUDIT_PROMPT_PROTOCOL_PASS`

## Next recommended pass

`LEAN_AUDIT_PROMPT_PROTOCOL_POST_AUDIT_PASS`

## Purpose

This docs-only governance pass adds a reusable lean audit contract so future audit prompts can be shorter while preserving TraceBench strictness.

`docs/AUDIT_CONTRACT.md` now owns standard audit contracts for scope-lock post-audit, implementation post-audit, docs closeout, route review, and recovery/evidence recheck.

`docs/PROMPTING_PROTOCOL.md` points auditors to the audit contract and lean prompt shape when repo-local docs are sufficient.

## Route context

The previous route before this pass was:

- Current: `V2_ADD_COMPONENT_CLOSEOUT_PASS`
- Next: `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`

This pass temporarily routes next to `LEAN_AUDIT_PROMPT_PROTOCOL_POST_AUDIT_PASS`.

After accepted post-audit and closeout, route back to `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`.

## Boundaries

- Docs-only governance change.
- No Flutter runtime, tests, tools, validator, materializer, schema, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Add/Edit implementation, Activity Timeline, Measure Momentum, assets, samples, generated artifacts, platform folders, tags, or releases.
- Repo docs remain canonical; old chat memory and old uploads do not override repo docs.
- Protected-surface audits still require strict evidence and cannot rely on summary-only evidence.

## Pointers

- Audit contract: `docs/AUDIT_CONTRACT.md`
- Prompting protocol: `docs/PROMPTING_PROTOCOL.md`
- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Pass audit: `docs/audit/LEAN_AUDIT_PROMPT_PROTOCOL_PASS.md`
