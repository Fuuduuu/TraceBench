# Code Map: `lib/features/project/actions/project_acquisition_actions.dart`

- Source: `lib/features/project/actions/project_acquisition_actions.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the two reusable user-triggered existing-project acquisition actions. It
selects ZIP or directory input, captures the active `ProjectSession` generation,
delegates validation/loading to `ProjectLoader`, and installs the loaded state
only if that generation is still current. A valid install chooses caller-owned
success callbacks or the default canonical `/project` route; stale completion
does neither. Typed and generic failure presentation remains unchanged.
It reads project input but writes no project file or canonical event/fact.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| ZIP picker and cancel | `ProjectZipImportAction`, `importZip`, `FilePicker.platform.pickFiles`, `allowedExtensions`, `withData` | Requests one ZIP with bytes when available and returns without state change on picker cancel/empty result. |
| ZIP byte-first load | `picked.bytes`, `ProjectLoader.loadFromZipBytes` | Loads the exact picker-provided bytes without a second filesystem read. |
| ZIP path fallback | `picked.path`, `File(picked.path!).readAsBytes`, `No file path for selected ZIP` | Reads the selected path only when bytes are absent and rejects a missing/empty path through the typed load-error boundary. |
| ZIP guarded success handoff | `projectStateProvider.notifier`, `generation`, `openProject`, `onImported`, `context.go('/project')` | Installs the loaded state only for the captured generation, then invokes the callback/default route only when opening succeeded and context remains mounted. |
| ZIP failure presentation | `ProjectLoadException`, `ZIP import failed` | Preserves typed loader detail and distinguishes generic import failure copy. |
| Directory picker and cancel | `ProjectDirectoryOpenAction`, `openDirectory`, `directoryPicker`, `FilePicker.platform.getDirectoryPath`, `Ava TraceBenchi projektikaust` | Uses an injected or native directory picker and returns on null/blank selection. |
| Directory load and guarded handoff | `projectLoader`, `ProjectLoader.loadFromDirectory`, `openProject`, `onOpened` | Uses the injected/default loader and performs callback/default navigation only after generation-valid session installation. |
| Directory failure presentation | `Valitud kaust ei ole kehtiv TraceBenchi projekt.`, `Projekti kaustast avamine ebaõnnestus` | Maps typed invalid-project failures to stable localized copy and generic failures to their existing detail-bearing copy. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed symbol, member expression,
route string, and user-visible string resolves as an exact substring in the
committed source. The map uses no line-number anchors.

## State and data flow

1. `ProjectZipImportAction.importZip` requests one ZIP and exits silently when
   selection is cancelled or empty.
2. Picker-provided bytes are passed directly to
   `ProjectLoader.loadFromZipBytes`; only the no-bytes branch reads the selected
   filesystem path, then passes that snapshot to the same loader.
3. The ZIP action captures `ProjectSession.generation` before selection. A
   successful load calls `openProject`; only an accepted open calls
   `onImported` or navigates to `/project`.
4. `ProjectDirectoryOpenAction.openDirectory` invokes an injected picker or
   the native directory picker and exits on null/blank selection.
5. The directory action captures generation before selection. The selected
   directory is passed to an injected loader or
   `ProjectLoader.loadFromDirectory`; only a generation-valid `openProject`
   calls `onOpened` or navigates to `/project`.
6. Typed and generic failures leave success handoff unexecuted and present
   their existing snack-bar copy only while the context remains mounted.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies `BuildContext`, mounted checks, callbacks, and snack-bar presentation. |
| Riverpod `WidgetRef` | state boundary | Reads the shared ProjectSession notifier and its current generation. |
| FilePicker | inbound user selection | Selects one ZIP or one directory through native platform UI. |
| `dart:io` `File` | ZIP path fallback read | Reads selected ZIP bytes only when the picker did not provide bytes. |
| `ProjectLoader` | outbound project reader | Validates and hydrates ZIP bytes or a directory into `ProjectState`. |
| `projectStateProvider` / `ProjectSession` | outbound projection-state owner | Generation-guards and installs successfully loaded state. |
| GoRouter `context.go` | outbound navigation | Provides the default canonical `/project` success destination. |
| `lib/app/app.dart` | direct caller | Uses both actions and supplies callbacks that switch into the workbench. |
| `ProjectGate` | direct caller | Uses directory acquisition with a non-null callback to preserve the original URI. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| File/directory picker and ZIP path read | `ZERO_WRITE` | Selects and reads user-owned input without modifying source or project files. |
| `ProjectLoader` calls | `ZERO_WRITE` | Delegates project parsing/validation; this owner does not change Project ZIP semantics. |
| Loaded state `openProject` | `PROJECTION_STATE` | Replaces rebuildable in-memory project state only for the captured generation and appends no canonical event/fact. |
| `onImported`, `onOpened`, default route | `UI_LOCAL` | Runs only after accepted session installation; stale completion has no callback/navigation effect. |
| Snack-bar feedback | `UI_LOCAL` | Presents existing failure copy without persistent mutation. |

The file performs no event append, fact creation, materialization, project
export, archive rewrite, schema mutation, source deletion, or canonical
component/placement/measurement/electrical write. `ProjectLoader` and Project
ZIP parsing/validation remain separate owners.

## Zero-write zones

- Picker cancellation and null/blank selection return without provider,
  navigation, callback, loader, or filesystem mutation.
- ZIP selection and path fallback read bytes but do not alter the selected ZIP.
- Directory selection passes a path to the loader without modifying the
  selected directory in this owner.
- Mounted checks and snack-bar presentation are UI-only.
- Callback invocation delegates downstream behavior; the actions do not infer
  or manufacture project truth.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| ZIP picker/cancel | [D] Exact picker arguments and early return. | launcher callbacks and FilePicker seam | `ZERO_WRITE` | launcher ZIP-flow test |
| ZIP bytes/path load | [D] Mutually exclusive byte-first/path-fallback branches. | `ProjectLoader` ZIP contract | `ZERO_WRITE` | ZIP success and loader ZIP tests |
| ZIP success/stale result | [D] Captured generation gates open and callback/default route. | app workbench transition and ProjectSession | `PROJECTION_STATE` + `UI_LOCAL` | launcher ZIP success and stale ZIP tests |
| ZIP failures | [D] Typed and generic catches are separate. | loader exception text and snack-bar host | `UI_LOCAL` | launcher/action regression family |
| Directory picker/load | [D] Picker and loader each have injected/default seams. | ProjectGate recovery and directory loader | `ZERO_WRITE` | folder cancel, invalid, direct load, success |
| Directory success/stale result | [D] Captured generation gates open and callback/default route. | app/gate navigation and ProjectSession | `PROJECTION_STATE` + `UI_LOCAL` | folder/gate success and stale directory test |
| Directory failures | [D] Typed and generic catches preserve distinct copy. | ProjectGate URI/recovery state | `UI_LOCAL` | invalid folder and gate failure outcomes |

## Relevant tests and helpers

- `test/widget/benchbeep_home_screen_test.dart` owns the direct launcher/action
  evidence: folder cancel, folder success, typed invalid selection, injected
  directory-backed load, stale directory suppression, ZIP picker contract,
  stale ZIP suppression, and ZIP success to canonical Board Canvas within its
  25-test family.
- `test/widget/project_gate_test.dart` exercises directory cancel, typed
  failure, generic failure, and successful state handoff through `ProjectGate`,
  including original-URI preservation and zero writer requests.
- `test/unit/project_loader_zip_test.dart` remains the downstream owner for ZIP
  byte parsing, validation, and Project ZIP load behavior rather than this UI
  action map.

## Dangerous combinations

- Removing generation gating or ignoring `openProject`'s result can expose a
  project route for stale loaded state or overwrite a newer session.
- Changing ZIP byte-first and path-fallback branches together can introduce a
  second-read mismatch or alter the protected Project ZIP input contract.
- Changing directory success navigation and `ProjectGate`'s non-null
  `onOpened` callback together can lose original-URI recovery.
- Broadening typed catches can collapse stable invalid-project feedback into
  generic error copy.
- Moving loader semantics into this owner would blur acquisition UI,
  validation, and Project ZIP responsibilities.

## Safe SNIPER slices

- ZIP picker/cancel only: picker arguments, early return, and launcher picker
  test.
- ZIP byte/path selection only: `picked.bytes`, `picked.path`, one loader call,
  and ZIP-focused tests.
- Directory picker/cancel only: `directoryPicker`, native default, early
  return, and cancel test.
- One success handoff only: captured generation, `openProject` result,
  callback/default branch, and app/gate route assertion.
- One failure class only: matching catch, stable copy, and focused outcome test.

## Future extraction seams

- [S] The duplicated guarded-open-before-callback/default-route sequence could
  become a private helper only if generation capture, mounted checks, and each
  action's public behavior remain explicit.
- [S] Failure presentation could receive a narrow test seam if platform-driven
  error coverage becomes difficult; no such change is authorized here.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when either public action/signature, picker seam,
loader seam, session, or callback anchor changes; `FLOW_DRIFT` when byte/path
selection, generation/open-before-navigation ordering, cancel, or failure handling
changes; `BOUNDARY_DRIFT` when this file begins writing project/canonical data
or changes Project ZIP behavior; `TEST_DRIFT` when direct launcher/gate outcome
coverage moves; and `STRUCTURE_DRIFT` when ZIP and directory ownership splits.

## Known uncertainty

- [D] The action tests prove handoff and feedback behavior; detailed ZIP and
  directory content validation remains owned by `ProjectLoader` tests.
- [D] Callback bodies are caller-owned and may preserve a requested URI; this
  map claims only that callbacks run after an accepted session open.
- [D] Both native picker invocations occur before their load `try` blocks;
  returned cancel/results are handled here, while a picker-thrown exception
  propagates to the caller rather than entering these generic load catches.
