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

Current architecture:
- Event writing decisions and constraints are governed by `docs/FLUTTER_EVENT_WRITE_SPEC.md`.
- First UI remains read-only until the event-writing scope-lock and implementation passes are accepted.
- First implementation direction is a measurement_recorded-only subset after sequence and append-only safety is in place.

Reason this pass is deferred:
- sequence management is not designed yet
- Dart-side event validation is not yet implemented
- append-only guarantees are not yet enforced

Deferred pass:
- FLUTTER_EVENT_WRITE_SCOPE_LOCK_PASS (completed)
- FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS (planned first implementation scope)

## Stale projection banner rules

- Stale projection UX is governed by `docs/PROJECTION_REFRESH_SPEC.md`.
- Global stale banner should appear on derived views when `isProjectionStale` is true.
- Banner text:
  `Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.`
- No in-app Refresh button in V1.
- Stale state does not block navigation.

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

`FLUTTER_GRAPH_VIEW_PASS` is implemented (read-only).

### Scope

- Read-only board graph view derived from `known_facts.json`.
- Data input: existing imported Project ZIP → `known_facts.json`.
- Projection: `BoardGraphProjection` is built in Dart memory from `known_facts.json`.
- Renderer: Flutter renderer reads `BoardGraphProjection` only.
- Layout: V1 uses deterministic auto-layout (`graph_layout`) state in memory.
- Persistence: no `board_graph.json`, no `view_state.json`, no persisted layout coordinates.
- Route: `/project/graph` is available in the shell and opens as a read-only view.

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

## Read-only photo list/view V1 scope

Future implementation pass:

- FLUTTER_PHOTO_LIST_PASS

Scope:

- Add route: `/project/photos`
- Add a Project Overview entry/card/link to the Photos screen.
- Source data is `known_facts.json` only through existing project load/model flow.
- Do not parse `events.jsonl` directly in Flutter UI.
- No persisted UI state.
- Do not create `board_graph.json` or `view_state.json`.

Beginner mode:

- show photo mode / role label
- show path or missing-file warning when available
- show damage region count
- show suspect region count
- show visual trace count
- hide raw photo IDs
- hide raw bbox/point coordinates
- hide raw IDs unless needed for safe understanding
- no diagnosis/inference display

Advanced mode:

- show `photo_id`
- show `path`, `mode`, and `layer` if present
- show bbox/point data read-only
- show related damage/suspect/visual-trace IDs
- show `visual_trace` evidence as visual-only (never electrical/measured)
- no editing and no event writing

Strictly forbidden in V1:

- camera capture
- file picker/photo import
- annotation editing
- event writing
- OCR/CV
- AI diagnostics/fault probability
- source search
- schema/tool/materializer changes
- sample/asset mutation
- Project ZIP contract changes
- visual_trace -> measured/electrical net promotion
- photo-derived identity/measurement/net/fault facts

Implementation write allowlist:

- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/photos/**`
- `lib/shared/models/known_facts.dart` (only if minimal parsing/serialization gap exists)
- `test/unit/known_facts_parsing_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/photo_list_screen_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_PHOTO_LIST_PASS.md`

Required future tests:

- known_facts parsing test for photos/damage_regions/suspect_regions/visual_traces if gaps exist
- photo list empty-state widget test
- beginner mode hides raw IDs/coordinates
- advanced mode shows raw IDs/evidence details
- damage/suspect/visual-trace count tests
- no edit/camera controls test
- navigation integration test from Project Overview to `/project/photos`
- visual-trace evidence wording test: shown as visual hint only, never electrical/measured/evidence-confirming
### Event writing scope

First event-write implementation scope is `measurement_recorded` only.

Full details live in `docs/FLUTTER_EVENT_WRITE_SPEC.md`.

Other event types remain deferred.

## Stale projection banner rules

- Stale projection UX is governed by `docs/PROJECTION_REFRESH_SPEC.md`.
- V1 stale UI is display-only and only reflects `ProjectState.isProjectionStale`.
- It must not trigger refresh, export, or materializer work.
- It must not mutate `known_facts.json`.
- Future implementation pass:
  - `PROJECTION_STALE_UI_PASS`
