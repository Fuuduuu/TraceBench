# BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md

## Purpose

Manual live-lite verification runbook for current accepted board-canvas read-only behavior and photo-alignment readiness metadata behavior before any UI/evidence expansion.

This plan is visual/manual QA only.

## Prerequisites

- Windows machine with Flutter installed at:
  - `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat`
- Repo is available at:
  - `C:\Users\Kasutaja\Desktop\TraceBench`
- A sample or project state that can surface:
  - board-normalized placements
  - inspector metadata
  - measurement summary metadata
  - visual_trace summary metadata
  - photo-alignment readiness metadata (when `photo_to_board_alignments` is non-empty)

## Commands to run

Run in order:

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
git status --short --branch
git log --oneline -8
py -3 tools\validate_all.py
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat devices
```

Launch option 1 (browser target):

```powershell
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat run -d chrome
```

Launch option 2 (Windows desktop target, if available):

```powershell
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat run -d windows
```

## What screen/route to open

Open the board canvas route:

- `/project/board-canvas`

## What to visually verify

### Core board-canvas state

- `/project/board-canvas` route opens successfully.
- `renderer writes: none` is visible.
- Empty states are calm and non-actionable.
- `board_normalized` component placements render when present.
- `photo_local` placements are not rendered on board coordinates.

### Inspector/read-only metadata

- Read-only inspector opens via non-mutating selection/list control.
- Measurement summary appears as read-only metadata only.
- visual_trace summary appears as read-only metadata only.

### Photo-alignment readiness panel

- Panel appears when `KnownFacts.photoToBoardAlignments` is non-empty.
- Panel remains project/photo-level metadata (not selected-component identity semantics).
- Reference pair count is shown.
- Raw reference-point `x/y` values are not shown.
- `transform_type` is shown as `declared type — not computed`.
- Required safety copy is visible:
  - `Photo alignment readiness — metadata only`
  - `Stores alignment reference points only.`
  - `Does not confirm identity, nets, measurements, or faults.`
  - `No photo-local evidence is rendered on board canvas.`
  - `No transform is computed.`
  - `Not electrical proof.`
  - `renderer writes: none`

## What must NOT appear

- `Confirm`
- `Save`
- `Apply`
- `Edit alignment`
- `Confirm alignment`
- `Add reference point`
- `Upload photo`
- `Show photo`
- `Render overlay`
- `Compute transform`
- `Run AI`
- `Detect`
- `Promote`
- `Export`
- background photo helper behavior
- visual_trace/damage/suspect board geometry
- transform matrix output
- any `board_graph.json` behavior
- any `view_state.json` behavior

## Evidence-boundary checklist

Confirm UI/copy/behavior does not imply:

- photo pixels are facts
- alignment confirms identity
- alignment confirms pin mapping
- alignment confirms net
- alignment confirms measurement
- alignment confirms fault proof
- visual_trace is a net
- damage is fault proof
- suspect is probability
- `template_id` implies electrical identity
- renderer/view writes facts

## What screenshots/notes to collect

Capture:

- board canvas initial state
- board placements visible state
- inspector with measurement summary visible
- inspector with visual_trace summary visible
- readiness panel visible state
- any unexpected layout/overflow issue
- any unexpected forbidden action text

Use consistent filenames, for example:

- `smoke_board_canvas_initial_<target>.png`
- `smoke_board_canvas_readiness_panel_<target>.png`
- `smoke_board_canvas_inspector_<target>.png`

## Observations template

Record:

- Device target used: `chrome` / `windows`
- App launched: `yes` / `no`
- Project loaded: `yes` / `no`
- Board canvas visible: `yes` / `no`
- Readiness panel visible: `yes` / `no` / `not applicable`
- Inspector works: `yes` / `no`
- Any overflow/layout issue: `yes` / `no`
- Any forbidden action label seen: `yes` / `no`
- Screenshot filenames / notes: `<list>`
- Verdict: `PASS` / `PASS_WITH_NITS` / `FAIL`

## Pass/fail criteria

- `PASS`: all required visuals/labels present, no forbidden actions/behaviors, no boundary violations.
- `PASS_WITH_NITS`: core behavior correct, minor non-blocking visual/text/layout nits observed.
- `FAIL`: missing required behavior, forbidden behavior appears, boundary violation, route fails, or app fails to run.

## Known expected warnings

Validation may report:

- `missing optional photo file: photos/top_backlight_001.jpg`

This is currently expected warning-level behavior.

## Stop conditions

Stop and record failure if any of the following occurs:

- board-canvas route does not open
- `renderer writes: none` missing
- raw reference-point `x/y` appears
- transform/matrix output appears
- any edit/confirm/save/apply/event-writing UI appears
- any background photo/helper or photo-local overlay behavior appears
- visual_trace/damage/suspect board geometry appears
- behavior implies electrical confirmation from visual metadata
