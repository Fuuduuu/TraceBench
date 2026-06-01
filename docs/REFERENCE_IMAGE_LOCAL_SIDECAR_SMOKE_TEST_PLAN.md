# REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS`

## Lane
`DOCS_SYNC / QA_PLAN`

## Goal
Create a manual Windows smoke validation runbook for the accepted V1.1 local reference-image sidecar viewer.

## Scope
- Docs-only QA plan.
- No code/runtime/schema/tool/materializer/ZIP contract changes.
- No event-writing/UI feature additions.

## Preconditions (before run)

1. `git status --short --branch` is clean except expected untracked local paths:
   - `.idea/`
   - `.metadata`
   - `assets/samples/pelle_pv20_minimal/metadata/`
   - `trace_bench_viewer.iml`
   - `windows/`
2. Branch is `main` and matches `origin/main`.
3. `v1.0.0-rc1` exists locally and on origin.
4. Previous implementation and audit passes are accepted/pushed:
   - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`
   - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_CLOSEOUT_PASS`
   - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS`
   - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_CLOSEOUT_PASS`
   - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_POST_AUDIT_PASS`
   - `V1_1_HARDENING_BACKLOG_REVIEW_PASS`
5. Test image files available locally for import:
   - `.png`
   - `.jpg`
   - `.jpeg`
   - `.webp`

## Manual smoke test steps (Windows)

### 1) Baseline app start
1. Launch TraceBench desktop.
2. Open a valid project from normal project-open flow.
3. Verify project loads without import errors.

### 2) Reachability from Project Overview
1. From Project Overview, locate the reference-image entrypoint (the accepted pass requires panel/viewer reachability from overview).
2. Verify the action is visible and opens the Reference Images viewer.
3. Verify regular existing overview actions remain visible/working.

### 3) Local import and sidecar storage path
1. In Reference Images viewer, run local picker import with an allowed file type (`png`, `jpg`, `jpeg`, `webp`).
2. Verify the image preview renders in the viewer.
3. Verify imported bytes are copied under:
   - `<project_root>\.tracebench_local\reference_images\`
4. Verify sidecar ledger exists/updates at:
   - `<project_root>\.tracebench_local\reference_images.json`
5. Verify ledger is non-canonical/reference-only metadata:
   - no electrical facts,
   - no event payload replacement,
   - no known_facts projection entries,
   - no materializer projection entries.

### 4) Safety copy and evidence boundary text checks
1. In the Reference Images viewer, confirm safety text/state includes:
   - `reference only`
   - `not evidence`
   - `not in Project ZIP`
   - `not used by AI`
   - `renderer writes: none`
2. Confirm no indication of transform/path overlay, event-writing, or import/export side effects beyond sidecar copy.

### 5) Project ZIP exclusion smoke check
1. Export project ZIP from the app.
2. Locate exported ZIP in Windows Explorer.
3. Inspect ZIP contents (PowerShell example):
   - `Expand-Archive <exported-zip> <temp-check-dir>`
   - verify no extracted path includes `.tracebench_local/` or `reference_images` sidecar directory.
4. Verify required baseline files remain present in the ZIP (for example `events.jsonl`, `project.json`, `known_facts.json` as applicable).
5. Confirm ZIP validator behavior still rejects sidecar paths in malformed ZIP/folder states (already covered by implementation pass; this is a manual smoke regression check).

### 6) Path-clamp defensive check (optional, manual)
1. Back up `<project_root>\.tracebench_local\reference_images.json`.
2. Edit one copied ledger entry to force invalid `storedRelativePath` values (e.g., absolute path or traversal with `..`).
3. Relaunch project/viewer and navigate back to the reference image entry.
4. Verify preview is not loaded from the invalid location and app remains stable.
5. Restore ledger backup after check.

### 7) Forbidden behavior checklist
During the run, verify all are absent:
- events.jsonl writes from this flow
- known_facts.json writes from this flow
- Board Canvas overlay/rendering from this flow
- URL image import
- AI/OCR/CV proposal behavior
- board_graph.json generation
- view_state.json generation

## PASS / FAIL capture template

| Check | Expected PASS | Observed |
|---|---|---|
| App/project opens normally | Pass |  |
| Reference Images viewer reachable from Project Overview | Pass |  |
| Allowed image import types accepted | Pass |  |
| Sidecar copy under `.tracebench_local/reference_images/` | Pass |  |
| `reference_images.json` updated with safe metadata only | Pass |  |
| Preview renders for valid local image | Pass |  |
| Safety copy visible (`reference only`, not evidence, no AI, no ZIP, no renderer writes) | Pass |  |
| ZIP has no `.tracebench_local` entries | Pass |  |
| Required ZIP files remain present | Pass |  |
| Forbidden behavior stays absent | Pass |  |
| Optional path-clamp tamper case rejected | Pass |  |

## Expected run outcome

Manual result is **PASS** only when all required checks pass and no forbidden behavior is observed.
If any required check fails, stop and record a blocker for follow-up implementation hardening.
