# SOURCES_INDEX_CURRENT.md

## Purpose

Routing, handoff, and conflict-resolution index for TraceBench governance after V1 RC.

## Current release/governance state

- V1 RC tag `v1.0.0-rc1` is tagged and verified (local + origin).
- `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS` is accepted/pushed.
- `V1_TO_V2_ROADMAP_DECISION_PASS` is accepted/pushed.
- `SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS` is accepted/pushed.
- `V1_1_HARDENING_VALIDATION_SMOKE_SCOPE_LOCK_PASS` is accepted/pushed.
- `V1_1_HARDENING_VALIDATION_SMOKE_AUDIT_CLOSEOUT_PASS` is accepted/pushed.
- `VALIDATE_ALL_FIXTURE_COVERAGE_PASS` and closeout are accepted/pushed.
- `REFERENCE_IMAGE_IMPORT_PRE_SCOPE_AUDIT_PASS` is accepted from audit context as audit-only (no repo modifications).
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS` is active/accepted for V1.1.
- Accepted roadmap sequence:
  - `TAG_V1_RC_FIRST`
  - then `V1_1_HARDENING`
  - then `V2_EVENT_WRITING_ARCHITECTURE`
- V2 does not start with transform/photo-overlay/background-photo-helper implementation.
- GPT Pro architecture decision for V1.1 reference images is Model B:
  - project-associated local sidecar files + non-canonical local metadata ledger,
  - explicitly outside `events.jsonl`, `known_facts.json`, and Project ZIP.
- Reference images remain non-canonical and cannot create accepted facts without separate human-confirmed event pathways.

## CURRENT_STATE size/archive discipline

- `docs/CURRENT_STATE.md` is a bounded active handoff file, not a long historical log.
- Keep only:
  - current pass,
  - next recommended pass,
  - current phase,
  - hard boundaries,
  - short latest accepted summaries.
- Move older narrative/history to `docs/audit/*.md`.
- Use `docs/AUDIT_INDEX.md` as lookup and `docs/PASS_QUEUE.md` as routing owner.
- When `CURRENT_STATE.md` grows beyond compact handoff use, schedule `DOCS_DRIFT_MINI_CLEANUP_PASS`.

## AI read order

1. `docs/PROJECT_MEMORY.md`
2. `docs/ACTIVE_SCOPE_LOCK.md`
3. `docs/SOURCES_INDEX_CURRENT.md`
4. `docs/MEMORY_REGISTRY.yml`
5. `docs/PASS_QUEUE.md`
6. `docs/PROMPTING_PROTOCOL.md`
7. `docs/PROTECTED_SURFACES.md`

## Tool / AI routing logic

1. Choose helper by risk class and authority boundary, not convenience.
2. ChatGPT continuation assistant:
   - orchestration,
   - scope review,
   - pass verdicts,
   - prompt writing,
   - commit/push command review.
3. Codex:
   - tightly scoped repo-local execution,
   - docs sync,
   - small implementation passes after scope lock,
   - targeted tests,
   - validator/materializer edits after scope lock,
   - must not self-approve high-risk implementation.
4. Claude Code / Opus:
   - repo-local audit,
   - scope-drift review,
   - implementation-risk review,
   - post-pass forensic checks,
   - test/surface inspection.
5. GPT Pro:
   - architecture decisions,
   - evidence-boundary decisions,
   - V2 direction,
   - canonical truth model,
   - AI proposal model,
   - risky photo/reference/overlay decisions.
6. Claude Design / Claude Chat:
   - UX/design polish,
   - visual hierarchy,
   - accessibility,
   - Board Canvas read-only layout review.
7. User manual action:
   - tag creation,
   - tag push,
   - release-object actions,
   - final accept/push decisions.

## Risk routing quick map

- Low docs-only: Codex, ChatGPT review.
- Low closeout: Codex, ChatGPT review.
- Medium repo-local audit: Claude Code, ChatGPT review.
- Medium scoped implementation: Codex, Claude Code post-audit if protected surfaces are touched.
- Medium UX polish: Claude Design first if visual, Codex implementation after scope lock.
- High architecture: GPT Pro first, Claude Code feasibility/audit second.
- High implementation: GPT Pro + Claude Code gate before Codex.
- Release/tag: user manual action; AI verifies only.

## Pre-pass checklist

1. What is the PASS_ID?
2. What is the lane?
3. Is this docs-only?
4. Does it touch canonical truth?
5. Does it introduce or modify a write path?
6. Can a photo/reference image be mistaken for a fact?
7. Is the file allowlist explicit?
8. Are forbidden surfaces explicit?
9. Are stop conditions explicit?
10. Are validation commands explicit?

## Required scoped prompt structure

- `READ`: files/directories the helper may inspect.
- `WRITE`: exact files/directories the helper may modify.
- `NEVER`: forbidden files/artifacts/behaviors/features/semantic promotions.
- `STOP CONDITIONS`: conditions where helper must stop and report.

## Always-preserved forbidden surfaces

- No event-writing UI.
- No confirm/save/apply/promote controls.
- No AI fact creation.
- No photo-to-fact inference.
- No photo alignment to identity/pin/net/measurement/fault proof.
- No visual_trace to net promotion.
- No damage to fault-proof promotion.
- No suspect to probability promotion.
- No template_id / footprint family to electrical identity promotion.
- No `board_graph.json`.
- No `view_state.json`.
- No Project ZIP contract expansion unless explicitly scoped.
- No tag/release-object mutation unless manually performed by user and separately verified.

## No self-approval rule (high risk)

High-risk Codex implementation must receive non-Codex review before acceptance:

`GPT Pro decision -> Claude Code repo/scope audit -> Codex implementation -> Claude Code post-audit -> ChatGPT pass verdict -> User commit/push`

## Active governance docs

- `docs/MODEL_ROUTING.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/PROJECT_ZIP_SPEC.md`
- `docs/FLUTTER_UI_SPEC.md`
- `docs/PHOTO_FLOW_SPEC.md`

## Conflict order

1. `AGENTS.md`
2. `docs/PROJECT_MEMORY.md`
3. `docs/ACTIVE_SCOPE_LOCK.md`
4. `schemas/*.json`
5. `docs/DATA_MODEL.md`
6. `docs/PASS_QUEUE.md`
7. `docs/PROJECT_STATE.yml` snapshot only
8. `docs/audit/*.md` pass evidence only
9. `docs/archive/**` historical only

## Canonical truth

- `docs/PROJECT_MEMORY.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `schemas/*.json`
- `docs/PROTECTED_SURFACES.md`

## Snapshot/debug only

- `docs/PROJECT_STATE.yml`
- `tools/validate_project_state.py`

## Archive policy

Archive files are never read by default.


## Governance routing source

- `docs/MODEL_ROUTING.md`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/MEMORY_REGISTRY.yml`

