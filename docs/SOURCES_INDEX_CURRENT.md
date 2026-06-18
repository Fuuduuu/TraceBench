# SOURCES_INDEX_CURRENT.md

## Purpose

Routing, handoff, and conflict-resolution index for current TraceBench governance.

## Current release/governance state

- Current pass and next route: `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Active scope lock: `docs/ACTIVE_SCOPE_LOCK.md`.
- Accepted history and evidence of pass outcomes: `docs/AUDIT_INDEX.md` plus `docs/audit/*.md`.
- Durable invariants: `docs/PROJECT_MEMORY.md` and `docs/PROTECTED_SURFACES.md`.
- Governance diagrams / routing diagrams:
  - `docs/PASS_LIFECYCLE.md`
  - `docs/ARCHITECTURE_BOUNDARIES.md`
  - `docs/MODEL_ROUTING.md`
- External/non-repo orientation pointer:
  - `TraceBench_Project_Source_Guide.md` is orientation-only material outside the canonical repo docs. Do not assume it exists in this repository, and do not treat it as canonical governance.

## Current orientation snapshot

- Canonical live route owners remain `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Current accepted route: `NEEDS_USER_DECISION`.
- Latest accepted pushed work: Board Canvas UI auto-hide manual smoke record `10adac9` (`docs: record board canvas ui auto-hide smoke`).
- Board Canvas density polish is accepted/pushed/manual-smoke PASS.
- Project Overview / Workbench layout density is accepted/pushed/closed out.
- Current design-gap capture routes toward `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`; write-flow integration, route consolidation, and theme parity remain separate later scopes.

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

Canonical owner: `docs/MODEL_ROUTING.md`.

This file only points to the routing owner. Do not duplicate the full tool/model routing matrix here.

## Risk routing quick map

Canonical owner: `docs/MODEL_ROUTING.md`.

Use this source index to find the routing document, then follow the canonical routing matrix there.

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
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- No Project ZIP contract expansion unless explicitly scoped.
- No tag/release-object mutation unless manually performed by user and separately verified.

## No self-approval rule (high risk)

Canonical owner: `docs/MODEL_ROUTING.md`.

High-risk Codex implementation must receive the non-Codex review path defined there before acceptance.

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

- docs/sources/ideelabor/boardfact_measure_sheet/: BoardFact Measure Sheet prototype bundle holding area for visual/product workflow input only. Claude Design / UX review returned `ACCEPT_WITH_NITS`; source files remain non-runtime design input, not production Flutter source, not Project ZIP content, and not evidence/canonical input.
- `_incoming/ui_redesign/2026-06-14_workbench_home/`: local scratch/reference-only Technician Workbench Home design input for integrated workbench direction. Contains standalone HTML/CSS mockup material; it remains untracked, non-runtime, non-canonical, not Project ZIP content, and must not be copied into Flutter/runtime/assets.
