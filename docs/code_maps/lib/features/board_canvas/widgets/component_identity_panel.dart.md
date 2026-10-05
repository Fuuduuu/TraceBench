# Code Map: `lib/features/board_canvas/widgets/component_identity_panel.dart`

- Source: `lib/features/board_canvas/widgets/component_identity_panel.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical add/edit writer paths and screen-lived UI-local state coexist`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENTS_C1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns Board Canvas component identity creation and metadata editing in one normal
Dart library. `ComponentIdentityHolder` owns screen-lived drafts, guards, status,
pending/repeat state and existing add/edit writer/session workflow.
`ComponentIdentityPanel` renders both forms around host-built Placement children.
The host owns holder lifetime, selection resolution, Add frame/scroll, Placement,
Inspector and painters. Source, tests and canonical owners outrank this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Holder lifecycle and notification | `ComponentIdentityHolder`, `_disposed`, `_update`, `dispose`, `notifyListeners` | ChangeNotifier state survives panel absence; disposal suppresses local mutation/notification without cancelling captured session handoff. |
| 2. Create draft and gate | `_rightPanelCreateComponentId`, `_rightPanelCreateComponentLabel`, `_rightPanelCreateComponentKind`, `_rightPanelCreateComponentBlockReason` | Required ID/label/kind and local-directory gate; transient create input and results. |
| 3. Edit target and change derivation | `_seedRightPanelMetadataEditDraft`, `_componentMetadataEditBaselineLabel`, `_canonicalRightPanelComponentKind`, `_rightPanelMetadataEditChanges`, `_rightPanelMetadataEditFormKey` | Silent ID-based reseeding, projected-label/kind normalization and ordered observed-value changes. |
| 4. Explicit create workflow | `_confirmRightPanelComponentCreation`, `V2AddComponentRequest`, `v2AddComponentWriterProvider` | In-flight guard, normalized request and accepted add-writer invocation. |
| 5. Explicit edit workflow and repeat gate | `_rightPanelMetadataEditBlockReason`, `_rightPanelMetadataEditLastSuccessfulFormKey`, `_confirmRightPanelMetadataEdit`, `V2EditComponentRequest`, `v2EditComponentWriterProvider` | Existing target/nonempty changes/directory and successful-form gates; accepted edit-writer invocation. |
| 6. Operation identity and failure copy | `_componentCreationClientOperationIdFor`, `_metadataEditClientOperationIdFor`, `_componentCreationFailureMessage`, `_componentMetadataEditFailureMessage` | Current ID normalization/timestamp pattern and typed/generic result presentation. |
| 7. Captured session handoff | `projectStateProvider.notifier`, `projectSession.applyCanonicalEvent`, `generation: generation` | Captures session/generation before await and applies the returned event before disposed-holder UI checks. |
| 8. Panel and Placement composition | `ComponentIdentityPanel`, `metadataEditComponent`, `placementSectionBuilder`, `...placementSectionBuilder(context)`, `ListenableBuilder` | Reads the host-resolved nullable target, listens to the holder and spreads host children between create and edit in one Column. |
| 9. Form presentation | `_RightPanelComponentCreationSection`, `_RightPanelMetadataEditSection`, `_AddComponentDraftChipButton` | Existing keyed controls, canonical kind choices, guard/result copy and private chip-button rendering. |

## Anchor inventory and verification

Every responsibility-table anchor resolves literally in this library.
The host and writer/session types remain separate owners; no line-number anchors.

## State and data flow

1. [D] The host creates one holder per Board Canvas screen State and disposes it
   with that State. Add removal/re-entry, focus/mode changes and responsive
   cutover reuse the holder; the child panel does not own its disposal.
2. [D] Inputs are `ProjectState`, nullable host-resolved `ComponentFact`, holder
   and one `List<Widget> Function(BuildContext context)` Placement builder.
   No selection, private placement/painter or save/session callback crosses the API.
3. [D] `build` silently reseeds edit fields only when the target ID changes:
   designator/component-ID label fallback, canonical kind, cleared result copy
   and successful-form key. It neither notifies listeners nor resets in-flight.
4. [D] Local field callbacks use `_update` to clear stale result copy; edit
   changes also clear its repeat key. ListenableBuilder rebuilds presentation.
5. [D] Create trims ID/label/kind and supplies a fresh operation ID. Its gate
   requires all three fields and a nonblank project directory, plus in-flight
   suppression. It has no successful-form repeat guard.
6. [D] Edit requires a projected target, nonblank label and actual changes.
   Label change precedes kind change. Stored noncanonical kind normalizes to
   `unknown`, whose kind change uses `set`; other known kinds use `replace`.
7. [D] Edit sends component ID, ordered changes,
   `board_canvas_right_panel_metadata_edit` reason and current operation ID.
   A matching successful component/label/kind form key blocks repeat save;
   field edits or target reseeding clear that key.
8. [D] Both workflows capture writer, Session and generation before awaiting.
   After the writer returns, `applyCanonicalEvent` runs before any disposed-holder
   UI return. No ref/context access occurs after await.
9. [D] Live holders receive appended/existing or typed/generic failure copy and
   finally clear in-flight. Disposed holders skip completion/error/finally
   local updates; panel absence alone does not suppress completion.
10. [D] The panel spreads host Placement children between both existing forms
    in its single stretch/min Column. The host retains Card/ExpansionTile,
    scroll controller, Placement widgets/callbacks and their canonical writer.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material / ChangeNotifier / ListenableBuilder | UI / holder / subscription | Transient state, rebuild notification and existing form presentation. |
| Riverpod ConsumerWidget / WidgetRef | existing provider access | Reads writer and Session objects synchronously before each writer await. |
| `v2_add_component_writer.dart` | canonical output / result contract | Existing provider, request, add call and typed result/failure vocabulary. |
| `v2_edit_component_writer.dart` | canonical output / result contract | Existing provider, ordered changes, edit call and typed result/failure vocabulary. |
| `known_facts.dart`, `project_state.dart` | read inputs | Nullable existing component and current loaded project passed to writers. |
| `project_session.dart` | provider / projection output | Captured generation and returned-event application. |
| `board_canvas_palette.dart`, `dart:math` | static presentation / sizing | Existing colors and chip-button maximum width. |
| `board_canvas_screen.dart` | constructing caller / one-way builder | Owns holder lifetime, target resolution and Placement children; never imported by this module. |
| `board_canvas_screen_test.dart` | indirect widget / direct source observation | Frozen C0 oracle and `componentSource` ownership/data-path guards. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Holder drafts, guards, status/error, in-flight and successful-form key | `UI_LOCAL` | [D] Mutable ChangeNotifier fields only; disposal blocks subsequent local updates. |
| `_confirmRightPanelComponentCreation` -> add writer | `CANONICAL_EVENT` boundary invoked | [D] Explicit enabled action supplies V2 request to the accepted writer. |
| `_confirmRightPanelMetadataEdit` -> edit writer | `CANONICAL_EVENT` boundary invoked | [D] Explicit gated action supplies projected target and observed-value changes. |
| Returned event -> `projectSession.applyCanonicalEvent` | `PROJECTION_STATE` | [D] Captured-generation in-memory handoff before local disposal checks; Session owns rejection/dedup/stale promotion. |
| Form rendering / host Placement children construction | `ZERO_WRITE` | [D] Construction and read-only copy do not invoke a writer; Placement save callback remains host-owned. |

Canonical validation, persistence, locks, event envelope and idempotency stay
with the existing writers. Session application mirrors their returned event;
this module does not append files or materialize Known Facts.

## Zero-write zones

- Form presentation, selected-component labels, kind normalization and change
  comparison are local/read operations until explicit create/edit action.
- No target shows guidance only; created components are not auto-selected.
- Placement builder invocation constructs host widgets without owning their
  draft, save target, writer or painter implementation.
- The module imports no host, filesystem, loader, exporter, materializer or
  geometry owner and contains no CanvasSelection/placement-private/painter type.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Holder lifetime/notification | [D] host creates/disposes; module guards local updates | host screen lifetime, ListenableBuilder subscription | `UI_LOCAL` | C0 removal/cutover/pending/away-completion cases |
| Create gate/request | [D] trimmed required fields and explicit add call | add writer, directory precondition, create form | `UI_LOCAL` / invoked `CANONICAL_EVENT` | C0 create guards, request/ID and retained create families |
| Target/reseed/change computation | [D] nullable input, silent ID reseed and ordered changes | host selection/fallback, component projection and edit form | `UI_LOCAL` | C0 selection/reseed, observed values and noncanonical kind case |
| Edit repeat/request | [D] successful form key plus explicit edit call | edit writer, target and ordered request fields | `UI_LOCAL` / invoked `CANONICAL_EVENT` | C0 repeat/appended/existing and exact edit requests |
| Await/disposal/session | [D] captured objects and application before UI guard | Session generation/dedup, writer completion | `PROJECTION_STATE` / `UI_LOCAL` | C0 replacement, screen disposal and concurrent completion order |
| Operation IDs/failures | [D] regex normalization, UTC microseconds and exact failure branches | writer enums/request identity and result copy | `UI_LOCAL` / invoked `CANONICAL_EVENT` | C0 edge/underscore IDs, typed/generic failures and retry |
| Placement composition | [D] builder children spread between keyed sections | host frame/scroll/template picker/builder/Placement writer | construction `ZERO_WRITE` | C0 picker/builder widget order and draft isolation |

## Relevant tests and helpers

- `test/widget/board_canvas_screen_test.dart` retains all 47 generated
  `Components C0 characterization` cases and their helpers, fixtures and fakes.
- `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `mountComponents`,
  `createDraft` and `editDraft` observe pending, retry, existing/appended results,
  current repeat asymmetry, exact requests, selection and session safety.
- Deferred cases observe event application after screen disposal and rejection
  by a replacement generation; two completions preserve distinct events.
- Widget positions pin create -> Placement picker/builder -> edit ordering.
- `componentSource` checks module holder/sections/requests/providers/IDs,
  host ownership exclusions, module dependency negatives and host Placement.
- Writer unit suites own real command/validation/persistence boundaries.
  `project_session_test.dart` owns the in-memory generation/dedup contract.

## Dangerous combinations

- A panel-mounted check could suppress live-holder completion after Add removal.
- Returning on disposed holder before Session application would drop an
  already-started generation-guarded handoff after screen disposal.
- Reading ref/context after await could access an unmounted panel.
- Notifying holder listeners during build-time reseeding changes the build
  contract; reseeding and in-flight/repeat state must be inspected together.
- Changing ID normalization, same-form create repeat behavior or failure copy
  is behavior change; a move or descriptive map does not authorize it.
- Adding a wrapping Column or passing private Placement/painter data would
  alter the verified one-way composition seam.

## Safe SNIPER slices

- One create gate or request field: named helper/request, matching C0 case, writer.
- One edit observed-value/repeat rule: change/form helper and exact request case.
- One async completion boundary: save method, holder eligibility, captured
  Session and matching replacement/disposal/deferred case.
- One nullable-target/reseed rule: host resolver and silent seed helper, C0 case.
- One form/composition boundary: keyed section, spread builder, host frame
  and widget-position/draft-isolation evidence.

## Future extraction seams

[S] Request/identity/failure helpers and form rendering are observable review
boundaries within this library. No decomposition, shared widget or new state
architecture is prescribed.

## Freshness and review triggers

Review holder/panel ownership, subscription/disposal, silent target reseeding,
guards, successful-form key, request/operation/failure fields, provider capture
and Session application order, nullable host inputs, Placement builder shape,
form keys/copy, and C0/static-owner evidence.

## Known uncertainty

- [D] Widget doubles do not prove real writer persistence, locking or OS behavior.
- [D] A false Session application result does not replace writer-result success
  copy while the holder is alive; this map does not reinterpret that behavior.
- [D] Create's missing successful-form repeat guard is observed current behavior,
  with no product-intent claim.
- [D] The private chip presentation is copied locally; the host retains its own
  Placement copy. Neither owns a shared-widget extraction.
