# Code Map: `lib/features/components/screens/add_component_screen.dart`

- Source: `lib/features/components/screens/add_component_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — canonical writer paths and UI-local/read-only responsibilities coexist`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_PREREQUISITE_CODE_MAP_BOOTSTRAP_PASS.md`

## File purpose

This screen turns explicit human-entered component identity and context into a
canonical `component_created` request through the accepted V2 writer. It owns
the local form gate, operation identity, result/failure presentation, and
caller-side mirroring of the returned event into stale projection state. Its
safety, hint, and technical-detail surfaces remain read-only, and the screen
does not write project files directly.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Draft and submit gate | `_componentKinds`, seven `TextEditingController` fields, `_formKey`, `_canAdd` | Normalizes required and optional human input, blocks incomplete/in-flight forms, and suppresses repeat submission of the last successful form. |
| 2. Explicit canonical add action | `_addComponent`, `v2AddComponentWriterProvider`, `V2AddComponentRequest` | Requires a loaded project and complete form, then invokes the accepted V2 component writer. |
| 3. Returned-event projection mirror | `_hasLocalEvent`, `_clientOperationIdForEvent`, `projectStateProvider.notifier` | Deduplicates by event or operation identity, mirrors the returned event, and marks projection stale. |
| 4. Request normalization and identity | `_optionalText`, `_clientOperationId` | Converts blank optional fields to null and derives deterministic operation identity from the complete form. |
| 5. Result and failure lifecycle | `_isSaving`, `_lastSuccessfulFormKey`, `_successMessage`, `_errorMessage`, `_messageForFailure` | Tracks in-flight/success/error state and translates typed writer failures into bounded not-saved copy. |
| 6. Form and controller presentation | `build`, `dispose`, `_clearMessages`, `add-component-` key prefix | Renders the human-entry form, disposes controllers, clears stale result copy, and exposes stable interaction keys. |
| 7. Boundary presentation | `_SafetyCard`, `_HintBoundaryCard`, `_TechnicalDetailsTile` | States the human-confirmation, hint-not-evidence, identity-only writer, and event-type boundaries without callbacks. |

## State and data flow

- `[D]` Human text and the selected kind flow through `_formKey`; incomplete
  forms never receive an enabled canonical action.
- `[D]` `_addComponent` reads the current `projectStateProvider` value and
  passes the same loaded project plus normalized request fields to the writer.
- `[D]` The writer result is deduplicated against local events by `event_id`
  and `client_operation_id` before `TraceBenchEvent.fromJson` is applied.
- `[D]` The provider receives a copied event list with
  `isProjectionStale: true`; canonical persistence remains writer-owned.
- `[D]` Result, error, saving, and last-form fields are widget-local state.
- `[D]` Hint/package/footprint/template values remain human-entered context;
  no hint is promoted to evidence, pin, net, or measurement truth here.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input / projection-state output | Supplies the loaded project and receives the caller-owned returned-event mirror. |
| `V2AddComponentWriter` provider | canonical boundary | Validates and appends the explicit component-created event outside the screen. |
| `V2AddComponentRequest` and writer result/error types | outbound / inbound contract | Carry normalized human input, operation identity, result status, event, and typed failure. |
| `ProjectState` | loaded-project input | Supplies manifest, directory, events, and projection state to the writer. |
| `TraceBenchEvent` | returned projection model | Converts the writer's returned event for local provider mirroring. |
| Flutter and Riverpod | UI / dependency access | Own transient controllers, widget state, rendering, and provider reads. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, selection, saving, and result fields | `UI_LOCAL` | `[D]` Mutate only `_AddComponentScreenState`. |
| `_addComponent` -> `v2AddComponentWriterProvider` | `CANONICAL_EVENT` boundary invoked | `[D]` Delegates the explicit human component-created write to the accepted writer. |
| Returned event -> provider copy | `PROJECTION_STATE` | `[D]` Mirrors one returned event and marks derived projection stale. |
| Safety, hint, and technical widgets | `ZERO_WRITE` | `[D]` Render fixed boundary information and expose no canonical callback. |

Event validation, append/locking, schema enforcement, file selection, direct
`events.jsonl` access, and materialization remain outside this screen. The
screen imports no filesystem library and has no direct file-write call.

## Zero-write zones

- `[D]` Form rendering, field validation, and button enablement do not persist.
- `[D]` `_SafetyCard`, `_HintBoundaryCard`, and `_TechnicalDetailsTile` are
  presentation-only.
- `[D]` Optional hint fields carry context into the confirmed request but do
  not independently confirm identity or electrical meaning.
- `[D]` Failure translation changes UI copy only.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Draft/gate | `[D]` `_formKey`, `_canAdd` | field keys and operation identity | `UI_LOCAL` | required-field and valid-request tests |
| Writer request | `[D]` `_addComponent`, `V2AddComponentRequest` | V2 writer contract and schema owner | `CANONICAL_EVENT` boundary invoked | valid request plus writer unit suite |
| Event mirror | `[D]` `_hasLocalEvent`, provider notifier | event identity and projection freshness consumers | `PROJECTION_STATE` | success and idempotent-existing tests |
| Operation identity | `[D]` `_clientOperationId` | writer idempotency contract | `UI_LOCAL` before write | valid request and writer idempotency tests |
| Failure copy | `[D]` `_messageForFailure` | writer failure enum | `UI_LOCAL` | four focused failure cases |
| Boundary copy | `[D]` safety/hint/detail widgets | protected identity/evidence semantics | `ZERO_WRITE` | safety, disclosure, and forbidden-source tests |

## Relevant tests and helpers

- `test/widget/add_component_screen_test.dart` covers safety copy, field gates,
  request mapping, returned-event mirroring, stale projection, technical
  disclosure, typed failures, idempotent existing results, and selected
  forbidden source/write boundaries.
- `test/unit/v2_add_component_writer_test.dart` owns real validation, append,
  locking, path, idempotency, and writer-result behavior.
- The paired test map is
  `docs/code_maps/test/widget/add_component_screen_test.dart.md`.

## Dangerous combinations

- `[P]` Changing form normalization and operation identity together can turn a
  repeat into a distinct canonical request.
- `[P]` Changing writer-result identity and `_hasLocalEvent` together can
  duplicate the caller-side projection event.
- `[P]` Treating optional hint values as inferred truth would cross the
  human-confirmation and evidence boundary.
- `[H]` Adding direct filesystem or materializer work would bypass the
  accepted writer architecture.
- `[P]` Moving provider ownership while changing event mirroring can obscure
  which layer owns stale projection state.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One required-field rule | `_formKey`, `_canAdd` | keyed form fields | gate plus valid-request tests |
| One request field | `_addComponent`, `V2AddComponentRequest` | writer request contract | valid-request plus writer unit tests |
| One dedup rule | `_hasLocalEvent`, `_clientOperationIdForEvent` | provider mirror | success and existing-result tests |
| One failure message | `_messageForFailure` | failure enum | matching focused failure test |
| One boundary-copy change | `_SafetyCard` or `_HintBoundaryCard` | protected semantics | safety and forbidden-boundary tests |
| One provider/session dependency change | `projectStateProvider`, `_addComponent` | writer and returned-event mirror | success, failure, and idempotency families |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Returned-event reconciliation | `[S]` Event and operation dedup is isolated in two helpers. | `NONE` |
| Loaded-session input | `[S]` Canonical action and projection mirror both depend on the current provider value. | `NONE` |
| Boundary cards | `[S]` Three callback-free widgets own fixed presentation. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for draft/helper `SYMBOL_DRIFT`, request/provider
  `FLOW_DRIFT`, writer/evidence `BOUNDARY_DRIFT`, focused coverage
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck writer, event, and provider owners when request identity, returned-
  event mirroring, or stale promotion changes.
- Recheck protected owners when hint, identity, human-confirmation, or
  technical-disclosure semantics change.
- Formatting and physical line movement alone do not stale this map.

## Known uncertainty

- `[P]` Canonical validation and persistence are imported writer behavior.
- `[D]` Caller-owned provider mirroring is current behavior, not authority for
  a future session-owner migration.
- `[S]` Future seams are descriptive and non-authorizing.
