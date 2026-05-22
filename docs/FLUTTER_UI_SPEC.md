# FLUTTER_UI_SPEC.md

## 1. Milestone name and scope

Milestone:
FLUTTER_VIEWER_SHELL_PASS

Scope:
Read-only Project ZIP viewer.

Included:
- app shell
- Project ZIP import/open
- project overview
- events viewer
- known_facts viewer
- customer report viewer
- export ZIP action/spec placeholder

Excluded:
- event writing
- new project wizard
- camera
- OCR/CV
- AI
- measurement wizard
- board map / trace drawing
- fault probability
- cloud sync

## 2. Accepted decisions

A. First Flutter scope pass is docs-only.
No pubspec.yaml, no lib/, no Flutter bootstrap in this pass.

B. Platform target:
mobile-first, Android/iOS first.
Windows desktop may be allowed later as development tool only.

C. Data source:
Project ZIP is the first UI input.
No separate local-folder workflow in first UI.
ZIP parsing is read-only.

## 3. Allowed screens

| screen | Beginner/Advanced | read-only/action | data source | included | reason |
|---|---|---|---|---|---|
| Home / project list | Both | read-only | Project ZIP (manifest/derived) | yes | Browse current project metadata and quick open state. |
| Open / Import Project ZIP | Beginner | action | Project ZIP file picker | yes | First-run project input path. |
| Project overview | Both | read-only | Manifest + known_facts | yes | Human-readable project summary for users. |
| Events viewer | Advanced | read-only | `events.jsonl` | yes | Chronological fact source for verification and traceability. |
| Known facts viewer | Both | read-only | `known_facts.json` | yes | Primary materialized state consumed by report and UI views. |
| Customer report viewer | Beginner | read-only | `exports/customer_report.md` | yes | Read-only customer-facing export artifact. |
| Component list | Both | read-only | `known_facts.json` | yes | Track identified components and statuses. |
| Measurement list | Both | read-only | `known_facts.json` + events | yes | Show active/stale state labels (human-readable). |
| Not populated list | Both | read-only | `known_facts.json` + events | yes | Show excluded fault candidates for grounding. |
| Pin list | Both | read-only | `known_facts.json` | yes | Show pin definitions for user comprehension. |
| Export ZIP action | Advanced | action | Project ZIP writer contract | yes | Re-export unchanged/packaged project state for handoff. |
| Beginner next-step placeholder | Beginner | action | Static UI state | yes | Keep guided path for future implementation expansion. |
| Advanced raw event view | Advanced | read-only | `events.jsonl` | yes | Diagnostics for advanced users before write-path exists. |

## 4. Forbidden screens/features

- live camera preview
- OCR/CV component detection
- AI chat/diagnostics
- fault probability
- next-best-measurement
- source search
- trace drawing
- board map editor
- schematic editor
- KiCad/boardview import/export
- Bluetooth multimeter
- cloud login/sync
- event writing
- sequence management
- measurement wizard
- new project wizard

## 5. Beginner mode rules

Beginner sees:
- project name/device/model in human-readable form
- component list with human labels
- measurement list with active vs stale displayed as labels, not raw enum
- not populated list
- customer report
- basic export/import actions
- next-step placeholder only

Beginner must not see:
- raw event_id
- sequence numbers
- confirmed_by_event_ids
- raw JSON payloads
- raw enum values unless translated

## 6. Advanced mode rules

Advanced sees:
- chronological events viewer
- event_id, sequence, event_type
- collapsible JSON payload
- known_facts raw/pretty view
- validity chain, e.g. M001 stale -> evt_000007 -> M002 active
- net confirmation chain, e.g. N1 <- evt_000008
- excluded_from_fault_candidates with footprint_id

Advanced is still read-only in first UI.

## 7. Event-writing decision

First UI does not write events.

Reason:
- sequence management not designed yet
- Dart-side event validator does not exist yet
- event creation requires separate architecture decision
- append-only guarantees must not be weakened

Deferred pass:
FLUTTER_EVENT_WRITE_PASS

## 8. Project ZIP integration

Mobile:
file_picker -> ZIP -> validate/read -> display in memory or local cache.

Desktop:
deferred. May later support ZIP or folder open, but not first UI.

All paths must align with existing Project ZIP validation contract.
First UI must not mutate imported Project ZIP.

## 9. Folder structure specification only

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
  features/
    project/
    events/
    known_facts/
    report/
  shared/
    models/
    widgets/
    theme/

test/
  unit/
  widget/
  integration/
```

Do not create these folders in this pass.

## 10. State management decision

Preferred:
Riverpod.

Acceptable alternative:
flutter_bloc, if later justified.

Forbidden:
large setState-driven shared app state
GetX-style magic/global state

Reason:
Project data is hierarchical and shared across viewer screens.

## 11. Key Dart packages, spec only

Mention, do not add:
- file_picker
- archive
- path_provider
- go_router
- riverpod
- flutter_markdown

No version pinning in this pass.

## 12. Test strategy

Future Flutter tests:
- unit: manifest/known_facts/events parsing
- widget: project overview with mock data
- integration: Project ZIP import -> display Pelle PV20 sample

No pytest for Flutter.
Flutter tests later use flutter test.

## 13. Stop conditions

Codex must stop if asked to:
- create Flutter code
- write events
- add camera/OCR/CV
- add AI/fault probability
- modify schemas/tools/samples
- add cloud/BLE/source search
- open local-folder workflow as equal first-class path

## 14. Next recommended pass

Next pass after this:
FLUTTER_VIEWER_SHELL_PASS

But only after user confirms Flutter implementation should begin.

## Board graph view V1 scope lock

### Future implementation pass

`FLUTTER_GRAPH_VIEW_PASS`

### Scope

- Read-only board graph view derived from `known_facts.json`.
- Data input: existing imported Project ZIP → `known_facts.json`.
- Projection: `BoardGraphProjection` is built in Dart memory from `known_facts.json`.
- Renderer: Flutter renderer reads `BoardGraphProjection` only.
- Layout: V1 uses deterministic auto-layout (`graph_layout`) state in memory.
- Persistence: no `board_graph.json`, no `view_state.json`, no persisted layout coordinates.

### Behavioral rules

- Beginner mode should show components, pins, measured nets, and not-populated labels in simplified form.
- Advanced mode may show measurements, stale facts/history markers, visual traces, damage/suspect regions, and raw IDs where already allowed in this spec.
- Visual trace rule: visual traces may render as visual hints only when enabled; they must not become measured electrical nets.
- Not-populated rule: not-populated footprints may render as excluded/label nodes but must never become `measuredConnection` endpoints.
- Stale measurement rule: stale measurements remain visible in audit/history mode and are not deleted.
- Future implementation should reuse existing app architecture and avoid package churn unless already present in the project.

### Explicitly forbidden in graph view V1

- event writing
- component editing UI
- measurement wizard
- camera
- OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview import/export
- BLE multimeter
- cloud sync
- Project ZIP contract changes
- `board_graph.json`
- `view_state.json`
- photo overlay / PCB coordinate overlay
- canonical schematic image generation
- `visual_trace` → measured net promotion

### V1 contract constraints

- no package/version changes in this scope-lock pass
