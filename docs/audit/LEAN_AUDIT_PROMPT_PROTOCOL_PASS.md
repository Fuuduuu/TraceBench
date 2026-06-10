# LEAN_AUDIT_PROMPT_PROTOCOL_PASS

## Verdict

PASS pending post-audit.

## Scope

Docs-only governance pass to reduce repeated long audit prompts while preserving TraceBench audit strictness.

## Changes recorded

- Added `docs/AUDIT_CONTRACT.md` as the reusable repo-local audit contract owner.
- Added standard contracts for `scope-lock-post-audit`, `implementation-post-audit`, `docs-closeout`, `route-review`, and `recovery / evidence-recheck`.
- Documented the lean prompt format: `PASS_ID`, `TYPE`, `LANE`, `CODEX`, `FOCUS`, and `APPLY STANDARD AUDIT CONTRACT`.
- Documented lean-read rules for auditors.
- Documented when full prompts remain required.
- Added examples for scope-lock post-audit, implementation post-audit, docs closeout, and evidence recheck.
- Updated `docs/PROMPTING_PROTOCOL.md` with a compact pointer to `docs/AUDIT_CONTRACT.md`.

## Boundaries preserved

- Repo docs remain canonical.
- Old chat memory and old uploads do not override repo docs.
- Protected-surface boundaries remain enforced.
- Summary-only evidence remains insufficient for protected implementation audits.
- No Flutter runtime, tests, tools, validator, materializer, schema, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Add/Edit implementation, Activity Timeline, Measure Momentum, assets, samples, generated artifacts, platform folders, tags, or releases changed.

## Route decision

Current pass: `LEAN_AUDIT_PROMPT_PROTOCOL_PASS`.

Next recommended pass: `LEAN_AUDIT_PROMPT_PROTOCOL_POST_AUDIT_PASS`.

After accepted post-audit and closeout, route back to `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`.

## Validation

Required by pass:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
