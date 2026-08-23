# Code Map: `lib/features/measurements/screens/measurement_record_screen.dart`

- Source: `lib/features/measurements/screens/measurement_record_screen.dart`
- Type: `production`
- Status: `RETIRED`
- Qualification: `AUTO — canonical writer paths and UI-local responsibilities coexist`
- Audit evidence: `none`

## File purpose

Retired historical map: accepted committed source intentionally deleted this
unreachable legacy measurement-write UI together with its direct legacy
writer. The inventory below is provenance/history only, not current live-source
or SNIPER authority. The `/project/measurements/new ->
/project/measure-sheet` compatibility redirect and old sequence-bearing
project reads survive under their separate current owners.

This legacy measurement-entry screen captures one manually entered numeric
reading, validates and deduplicates the transient form, and invokes
`MeasurementEventWriter` to append a canonical measurement event. It replaces
the in-memory `ProjectState` with the writer result and reports bounded success
or failure copy. The current application router redirects the former creation
URL to Measure Sheet, while direct widget construction still exercises this
screen and its writer boundary.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen and state lifecycle | `MeasurementRecordScreen`, `_MeasurementRecordScreenState`, `createState`, `dispose` | Owns the stateful screen and the four text-controller lifecycles. |
| 2. Draft input state | `_valueController`, `_fromController`, `_toController`, `_customUnitController`, `_selectedUnit` | Captures human-entered value, endpoint, and unit drafts as UI-local state. |
| 3. Fixed measurement defaults | `_defaultMode`, `_defaultPowerState`, `_otherUnitValue`, `_unitOptions` | Supplies the legacy continuity mode, unknown power state, and selectable/custom unit vocabulary. |
| 4. Input normalization | `_parsedValue`, `_unit` | Trims text, parses a finite numeric candidate, and resolves selected versus custom unit text. |
| 5. Form identity and save gate | `_currentFormKey`, `_isDuplicateFormKey`, `_canSubmit`, `_lastSuccessfulFormKey` | Builds a normalized identity and blocks incomplete, concurrent, or unchanged repeat submission. |
| 6. Project-state gate | `_saveMeasurement`, `projectStateProvider`, `No project loaded.` | Requires a loaded project before request construction and canonical writer invocation. |
| 7. Request assembly | `MeasurementWriteRequest`, `value`, `unit`, `fromTarget`, `toTarget`, `mode`, `powerState` | Translates the validated draft into the writer's typed request without deriving a measurement. |
| 8. Canonical writer invocation | `MeasurementEventWriter`, `writeMeasurement` | Constructs the accepted legacy writer and crosses the canonical event-write boundary. |
| 9. Returned-state and success handling | `updatedProjectState`, `_successMessage`, `measurement-success-message` | Replaces in-memory provider state with the writer result, remembers the successful form, and reports projection staleness. |
| 10. Failure and submission lifecycle | `MeasurementWriteException`, `_errorMessage`, `_isSubmitting`, `finally` | Surfaces typed writer failures and restores the transient submission gate. |
| 11. Form composition | `build`, `measurement-unit-dropdown`, `measurement-unit-custom-field`, `measurement-submit-button` | Renders loaded/no-project states, input widgets, custom-unit visibility, action, and terminal messages. |

## State and data flow

- `[D]` Text controllers and `_selectedUnit` receive only direct widget input.
- `[D]` `_parsedValue` and `_unit` normalize that input; `_currentFormKey`
  rejects missing, non-finite, or blank values and includes both fixed defaults.
- `[D]` `_canSubmit` disables the action while a write is active or the valid
  form matches `_lastSuccessfulFormKey`.
- `[D]` `_saveMeasurement` re-reads `projectStateProvider`, sets transient
  progress state, and builds one `MeasurementWriteRequest`.
- `[D]` `MeasurementEventWriter.writeMeasurement` validates the request,
  appends one event through its own owner, and returns an updated project state.
- `[D]` The screen assigns `result.updatedProjectState` to the provider and
  reports that known-facts-derived views still require refresh.
- `[D]` `MeasurementWriteException` becomes UI copy; no broader error class is
  converted into canonical state here.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input / projection-state output | Supplies the loaded project and receives the writer-returned state. |
| `MeasurementEventWriter` | outbound canonical boundary | Validates and appends the accepted `measurement_recorded` event outside this screen. |
| `MeasurementWriteRequest` | outbound data | Carries explicit human-entered measurement fields to the writer. |
| `MeasurementWriteException` | inbound failure | Provides the typed failure surfaced by the screen. |
| Flutter text/form widgets | UI-local input | Capture draft text, unit selection, action, and result presentation. |
| `lib/app/router.dart` | application navigation evidence | Redirects `measurements/new` to `/project/measure-sheet` and does not construct this screen. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, `_selectedUnit`, messages, `_isSubmitting` | `UI_LOCAL` | `[D]` Mutate only widget state. |
| `_saveMeasurement` → `MeasurementEventWriter.writeMeasurement` | `CANONICAL_EVENT` boundary invoked | `[D]` The imported writer appends an accepted measurement event to `events.jsonl`. |
| `result.updatedProjectState` → `projectStateProvider` | `PROJECTION_STATE` | `[D]` Replaces in-memory state returned by the writer; the writer marks it stale and adds the event. |
| `_parsedValue`, `_unit`, `_currentFormKey`, `_canSubmit` | `ZERO_WRITE` | `[D]` Compute validation and gating values only. |
| `build` and terminal-message widgets | `ZERO_WRITE` | `[D]` Render current widget/provider state. |

Event-envelope validation, sequence and ID allocation, file replacement and
rollback, accepted status, actor constraints, and `events.jsonl` ownership
remain in `MeasurementEventWriter`. This screen does not write
`known_facts.json`, materialize projections, infer readings, or create
secondary component, pin, or net events.

## Zero-write zones

- `[D]` Parsing, unit resolution, form-key generation, and submit eligibility
  do not mutate widget, provider, or filesystem state.
- `[D]` Loaded/no-project presentation and input decoration are rendering only.
- `[D]` Success and failure widgets display strings already held in UI state.
- `[D]` The screen imports no file, JSON, schema, materializer, exporter, or
  Project ZIP implementation.
- `[D]` Application routing does not reach this screen through
  `measurements/new`; it redirects to Measure Sheet.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Draft input/unit widget | `[D]` controllers and selection feed normalization | `_unit`, `_currentFormKey`, custom-unit visibility | `UI_LOCAL` | form-gating and edit-after-success widget tests |
| Parsing and validation | `[D]` normalized values determine form identity | request assembly and writer validation | `ZERO_WRITE` | disabled-submit widget test; writer invalid-request tests |
| Duplicate-submit gate | `[D]` active and last-success keys guard `_saveMeasurement` | success state and async lifecycle | `UI_LOCAL` | rapid-double-tap and unchanged-form widget tests |
| Request assembly | `[D]` typed fields come from current draft/defaults | writer request validation and envelope build | `CANONICAL_EVENT` boundary invoked | success widget test; writer unit tests |
| Writer invocation | `[D]` direct `writeMeasurement` call | event loading, validation, append, rollback | `CANONICAL_EVENT` boundary invoked | writer unit and end-to-end tests |
| Returned provider state | `[D]` writer result is assigned after success | projection-stale consumers | `PROJECTION_STATE` | success and resubmission widget tests |
| Failure/submission state | `[D]` typed catch plus `finally` | widget lifecycle and writer failures | `UI_LOCAL` | writer rejection/append-failure tests |
| Screen composition/navigation | `[D]` direct widget construction; router redirect | Measure Sheet destination and compatibility test | `ZERO_WRITE` | direct screen widget tests; overview route test |

## Relevant tests and helpers

- `test/widget/measurement_write_screen_test.dart` directly constructs the
  screen and covers incomplete-form gating, excluded controls, success/stale
  copy, rapid double tap, unchanged repeat blocking, and edit-after-success.
- `_createSampleProject`, `_buildProjectState`, `_fillValidMeasurementForm`,
  `_submitAndWait`, and `_waitForMeasurementTerminalState` provide its direct
  fixture and asynchronous UI harness.
- `test/unit/measurement_event_writer_test.dart` directly owns sequence,
  request, actor, event-ID, append, `known_facts.json`, and no-secondary-event
  behavior behind the imported writer boundary.
- `test/integration/measurement_write_end_to_end_test.dart` directly invokes
  the writer and proves one `measurement_recorded` append while known facts and
  secondary event families remain unchanged.
- `test/widget/project_overview_screen_test.dart` proves the legacy
  `measurements/new` application path redirects to Measure Sheet.

## Dangerous combinations

- `[P]` Changing normalization and request assembly together can make the UI
  validate one value while the writer receives another.
- `[P]` Changing `_currentFormKey`, `_isSubmitting`, and success-state updates
  together can reintroduce duplicate canonical events.
- `[P]` Assigning provider state before writer success can present an event
  that was not durably appended.
- `[P]` Replacing the typed catch with broad success-like handling can hide
  canonical append or validation failures.
- `[D]` Restoring application reachability while changing this legacy writer
  boundary crosses navigation and canonical-write responsibilities.
- `[P]` Adding direct known-facts or secondary-event mutation here would
  bypass the verified writer boundary.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One unit-selector API migration | `measurement-unit-dropdown`, `_selectedUnit` | `_unit`, custom-unit visibility, form key | form-gating and edit-after-success widget tests |
| One input validation rule | `_parsedValue` or `_currentFormKey` | request validation and submit button | disabled-submit plus writer invalid-request tests |
| One duplicate-save rule | `_isDuplicateFormKey`, `_canSubmit` | `_saveMeasurement`, success key | double-tap and unchanged-form tests |
| One typed failure message | `MeasurementWriteException`, `_errorMessage` | writer failure contract | matching writer failure plus widget terminal state |
| One layout/copy change | `build` and named widget keys | action reachability and terminal messages | focused screen widget tests |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Form normalization value object | `[S]` `_parsedValue`, `_unit`, and `_currentFormKey` already form a cohesive calculation. | `NONE` |
| Writer dependency injection | `[S]` Direct construction limits screen-level failure testing. | `NONE` |
| Legacy screen retirement | `[S]` Production routing redirects away while focused tests still instantiate the screen. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for controller/helper `SYMBOL_DRIFT`, form-to-request
  or provider `FLOW_DRIFT`, writer/write-class `BOUNDARY_DRIFT`, direct-test
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck the writer and protected owners whenever request fields, validation,
  append behavior, returned state, or canonical-event semantics change.
- Recheck router evidence if application reachability changes.
- Formatting, import ordering, and line movement alone do not stale this map.

## Known uncertainty

- `[D]` The current app router does not construct this screen, but direct
  widget tests demonstrate that its write path remains executable.
- `[P]` Persistence atomicity and envelope validity are imported writer
  behavior and require that source and its focused tests for proof.
- `[S]` Extraction and retirement seams are descriptive only.
