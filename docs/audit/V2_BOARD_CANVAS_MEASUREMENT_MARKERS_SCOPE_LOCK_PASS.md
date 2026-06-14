# V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the expected lane for a docs-only lock before implementation.

## PASS metadata

- PASS_ID: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS`
- Type: `DOCS_SCOPE_LOCK`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Mode: docs-only governance lock for the next Board Canvas rendering slice.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Commit tip: `b2ba318` (`docs: close out board canvas pan zoom fit`)
- `git status --short --branch` before patch:
  - untracked allowed scratch files only (`.idea/`, `.metadata`, `_incoming/`, etc.).
- `git log --oneline --decorate -10` confirmed the previous route was at `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`.

## Files read

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `docs/audit/BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS.md`

## Verified route lock state before edit

- Verified `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` were aligned before this scope-lock pass.
- Startup current: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`
- Startup next: `NEEDS_USER_DECISION`
- `Claude Code` and `GPT Pro` reviews were confirmed to agree on proceeding with this next scope-lock.

## Scope-lock rationale

This lock captures the next narrow Board Canvas V2 slice:

- render **component-level** measurement presence visual cues only;
- provide visual orientation that a component has related measurements;
- preserve existing zero-event/read-only behavior;
- do not invent measurements, coordinates, anchors, lines, paths, or net proofs.

Hard semantic correction:

- "measurement marker" in this track means a **component-level badge/highlight** only.
- It is **not** a board coordinate marker, probe point, pin/pad anchor, endpoint geometry, net/path geometry, or canonical fact.

## Definition for allowed future derivation

- Use existing measurement-component associations only.
- Use existing board-normalized component placement geometry only.
- Use existing read-only projection/cache facts only.
- Association must satisfy exact match or exact prefix-with-dot rule:
  - `endpoint == componentId`
  - `endpoint == to/from componentId + "." + ...`
- Prefix matching such as `startsWith("Q2")` is forbidden because it causes false positives (`Q2` vs `Q20`).

## Forbidden future scope (exactly enforced)

- new measurement board coordinates / point fields;
- measurement board x/y rendering, probe-point rendering, pin/pad anchors;
- endpoint-to-board coordinate inference;
- marker lines between two endpoints;
- canonical net/path/continuity promotion;
- visual_trace geometry behavior;
- background photo rendering/alignment;
- photo-local to board transform;
- contour/layer stack behaviors;
- AI/OCR/CV candidate handling;
- marker editing, dragging, or placement authoring;
- Save Measurement / Add Component / Edit Component behavior changes;
- MeasurementEventWriter or writer/service/schema/materializer/validator/validator toolchain changes;
- event schema/model changes;
- `sequence` field introduction;
- Project ZIP import/export mutation;
- known_facts.json mutation;
- events.jsonl write in marker scope.

## Required implementation tests and assertions

1. badge appears when `from == componentId`;
2. badge appears when `to == componentId`;
3. badge appears when endpoint starts with `componentId + "."`;
4. `Q2` does not match `Q20`;
5. component with measurement but no board-normalized placement gets no canvas badge;
6. placed component with no related measurement gets no badge;
7. two-component measurement badges can both render safely; no line is drawn;
8. marker/badge rendering does not write events;
9. marker/badge rendering does not mutate known_facts;
10. marker/badge rendering does not update Project ZIP;
11. pan/zoom/fit keeps badge aligned with rendered component;
12. existing board render / inspector / measurement summary behavior remains intact;
13. editing/authoring labels and controls remain absent.

## Scope-lock summary

- Route changed to:
  - Current: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS`
  - Next: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`
- Current route lock docs and allowlist rows updated in `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- No runtime/tool/schema/protected-surface files were modified in this pass.

## Validation summary

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Scope drift check

- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` agree on route:
  - Current: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS`
  - Next: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`
- `docs/AUDIT_INDEX.md` now points to the new scope-lock audit file.
- No stale board-pass path conflict introduced.
- No runtime files changed in this lock pass.

## safe_for_reaudit

YES

## Expected staging command (docs-only route docs + scope-lock audit)

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
