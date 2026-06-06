# SOURCES_INDEX_CURRENT.md

## Purpose

Routing, handoff, and conflict-resolution index for TraceBench governance after V1 RC.

## Current release/governance state

- Current pass and next route: `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Active scope lock: `docs/ACTIVE_SCOPE_LOCK.md`.
- Accepted history and evidence of pass outcomes: `docs/AUDIT_INDEX.md` plus `docs/audit/*.md`.
- Durable invariants: `docs/PROJECT_MEMORY.md` and `docs/PROTECTED_SURFACES.md`.
- Governance diagrams / routing diagrams:
  - `docs/PASS_LIFECYCLE.md`
  - `docs/ARCHITECTURE_BOUNDARIES.md`
  - `docs/MODEL_ROUTING.md`
- External orientation file:
  - `TraceBench_Project_Source_Guide.md` remains non-governance orientation material only.

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
- Canonical maintenance trigger: compact `CURRENT_STATE.md` when it exceeds approximately 120 lines. See `docs/MEMORY_MAINTENANCE.md`.

## AI read order

Canonical read order lives in `docs/MEMORY_PROTOCOL.md` §5. Do not duplicate the ordered payload here.

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

Canonical conflict order lives in `docs/MEMORY_REGISTRY.yml` at `rules.conflict_order`. Do not duplicate the ordered payload here.

## Canonical truth

- `docs/PROJECT_MEMORY.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `schemas/*.json`
- `docs/PROTECTED_SURFACES.md`

## Snapshot/debug only

- `docs/PROJECT_STATE.yml`
- `tools/validate_project_state.py`
- `docs/PROJECT_STATE.yml` is non-canonical/deprioritized. Live state is owned by `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.

## Archive policy

Archive files are never read by default.


## Governance routing source

- `docs/MODEL_ROUTING.md`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/MEMORY_REGISTRY.yml`

## Design/prototype source folders

- docs/sources/ideelabor/boardfact_measure_sheet/: BoardFact Measure Sheet prototype bundle holding area for visual/product workflow input only. Not runtime app source, not production Flutter source, not Project ZIP content, and not evidence/canonical input.
