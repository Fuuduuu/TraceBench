# BOARD_CANVAS_LIVE_POSITIVE_SMOKE_TEST_PLAN.md

## Purpose

Manual positive smoke runbook for validating real board-canvas positive-state behavior using the accepted deterministic fixture:
- `samples/board_canvas_positive_smoke`

This run verifies rendering and read-only metadata boundaries, not feature implementation.

## Prerequisites

- Windows environment.
- Repo root:
  - `C:\Users\Kasutaja\Desktop\TraceBench`
- Flutter binary:
  - `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat`
- Accepted fixture present:
  - `samples/board_canvas_positive_smoke`
  - `project_id: prj_board_canvas_smoke_001`

## Fixture under test

- Project: `prj_board_canvas_smoke_001`
- Expected positive fixture facts include:
  - component `SMP001`
  - pins `SMP001.1`, `SMP001.2`
  - measurement `M1001`
  - visual trace `VT001`
  - board placement for `SMP001`
  - photo alignment `ALN1001`

## Pre-run validation commands

Run in order:

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
git status --short --branch
git log --oneline -8
py -3 tools\validate_events_jsonl.py samples\board_canvas_positive_smoke\events.jsonl schemas\events.schema.json
py -3 tools\materialize_known_facts.py samples\board_canvas_positive_smoke\events.jsonl samples\board_canvas_positive_smoke\known_facts.json
py -3 tools\validate_all.py
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat devices
```

Expected:
- Validation commands pass.
- If materializer command causes no diff, that is expected.
- If materializer command changes fixture data unexpectedly, stop and investigate before app run.

## How to prepare/open the fixture

### Option A (direct directory open; preferred when available)

Use app open-project flow to select:
- `C:\Users\Kasutaja\Desktop\TraceBench\samples\board_canvas_positive_smoke`

Use this path if the app supports opening an extracted project directory directly.

### Option B (ZIP transport workflow)

Use exact tool syntax:

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
py -3 tools\export_project_zip.py samples\board_canvas_positive_smoke C:\Users\Kasutaja\Desktop\TraceBench\.codex\board_canvas_positive_smoke.zip
py -3 tools\validate_project_zip.py C:\Users\Kasutaja\Desktop\TraceBench\.codex\board_canvas_positive_smoke.zip
py -3 tools\import_project_zip.py C:\Users\Kasutaja\Desktop\TraceBench\.codex\board_canvas_positive_smoke.zip C:\Users\Kasutaja\Desktop\TraceBench\.codex\board_canvas_positive_smoke_imported
```

Then open imported project directory:
- `C:\Users\Kasutaja\Desktop\TraceBench.codex\board_canvas_positive_smoke_imported`

Important:
- Do not commit generated ZIP or imported temp directory to repo.

## App run commands

Windows target:

```powershell
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat run -d windows
```

Edge target (if preferred and available in `flutter devices`):

```powershell
C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat run -d edge
```

Do not use Chrome unless `flutter devices` explicitly lists Chrome.

## Board Canvas positive verification checklist

- App launches.
- Fixture project opens/imports.
- Project identity is visible (`prj_board_canvas_smoke_001` or equivalent model label).
- Project Overview opens.
- `Board Canvas` action is visible.
- Board Canvas opens.
- Title is `Board Canvas`.
- `renderer writes: none` is visible.
- Empty placement state is **not** shown.
- `SMP001` board-normalized placement renders.
- Placement selector shows `SMP001`.
- Selecting `SMP001` opens read-only inspector.
- Inspector shows `Component ID: SMP001`.
- Measurement read-only summary is visible.
- `Measurement ID: M1001` is visible.
- Visual trace read-only summary is visible.
- `Trace ID: VT001` is visible.
- Photo alignment readiness panel is visible.
- `Alignment ID: ALN1001` is visible.
- `Source photo ID: photo_smoke_top_001` is visible.
- `Reference pairs: 2` is visible.
- `declared type — not computed: similarity` is visible.
- Required safety copy is visible:
  - `Photo alignment readiness — metadata only`
  - `Stores alignment reference points only.`
  - `Does not confirm identity, nets, measurements, or faults.`
  - `No photo-local evidence is rendered on board canvas.`
  - `No transform is computed.`
  - `Not electrical proof.`

## Forbidden UI checklist

Must not appear:
- `Confirm alignment`
- `Edit alignment`
- `Add reference point`
- `Compute transform`
- `Show photo`
- `Render overlay`
- `Upload photo`
- `Save`
- `Apply`
- `Export from Board Canvas`
- `Run AI`
- `Detect`
- `Promote`
- background photo helper UI
- visual_trace line/polyline/path geometry on board
- damage/suspect overlays
- transform matrix output

Raw reference-point coordinates must not appear in readiness panel coordinate fields:
- `10`
- `200`
- `0.1`
- `0.7`

Nuance:
- Numeric values like `0.1` can legitimately appear in measurement value display. Fail only if they appear as raw alignment coordinate display in readiness panel context.

## Evidence-boundary checklist

Confirm run behavior preserves:
- photo pixels are not facts
- alignment is not identity, pin mapping, net, measurement, or fault proof
- visual_trace remains metadata-only (not net)
- measurement remains read-only metadata
- template/package display does not imply electrical identity
- renderer/view writes nothing
- no background photo helper behavior
- no transform computation
- no `board_graph.json` or `view_state.json` behavior

## Screenshot/notes template

Use this copyable template:

- Date/time:
- Device target: Windows / Edge
- Validation passed: yes/no
- Fixture opened/imported: yes/no
- Board Canvas opened: yes/no
- SMP001 placement visible: yes/no
- Inspector works: yes/no
- M1001 visible: yes/no
- VT001 visible: yes/no
- ALN1001 readiness panel visible: yes/no
- Reference pairs count visible: yes/no
- Raw reference x/y absent: yes/no
- Forbidden UI absent: yes/no
- Overflow/layout issue: yes/no
- Screenshot filenames:
- Verdict: PASS / PASS_WITH_NITS / FAIL
- Notes:

## Pass/fail criteria

- `PASS`: all required positive observations confirmed; forbidden observations absent.
- `PASS_WITH_NITS`: core checks pass; only minor non-blocking UI/layout copy nits.
- `FAIL`: any required positive observation missing, forbidden behavior present, or evidence-boundary violation observed.

## Known expected warnings

During repo-level validation, warning may appear:
- `missing optional photo file: photos/top_backlight_001.jpg`

This warning is expected and non-blocking for this smoke plan.

## Stop conditions

Stop and report immediately if:
- fixture open/import strategy cannot be completed with current app/tool flow
- board canvas route fails to open
- `renderer writes: none` is missing
- raw alignment reference coordinates are shown in readiness panel
- any edit/confirm/save/apply/event-writing controls appear
- any background photo/helper or overlay/transform output appears
- visual_trace/damage/suspect board geometry appears
- behavior implies electrical confirmation from visual metadata
