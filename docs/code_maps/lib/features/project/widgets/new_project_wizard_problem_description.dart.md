# Code Map: `lib/features/project/widgets/new_project_wizard_problem_description.dart`

- Source: `lib/features/project/widgets/new_project_wizard_problem_description.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS.md`

## File purpose

Defines the public immutable five-value problem-observation draft and its exact
three-value occurrence enum, then presents a controlled responsive Step 5
editor. The child owns only controllers and presentation lifecycle; the Wizard
parent remains authoritative through `value`, `onChanged`, and `compact`.
Raw human text and selection-preserving same-value synchronization stay local;
the file performs no diagnosis, inference, persistence, routing, or canonical
write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Draft and occurrence model | `NewProjectWizardProblemOccurrence`, `NewProjectWizardProblemDescriptionDraft`, `copyWith`, `operator ==`, `hashCode` | Defines exact defaults, values, immutable effective copies, and structural equality. |
| Controlled child contract | `NewProjectWizardProblemDescription`, `value`, `onChanged`, `compact` | Receives the authoritative parent snapshot and emits complete replacement drafts. |
| Controller lifecycle and synchronization | `_descriptionController`, `_whenController`, `_symptomsController`, `_attemptsController`, `initState`, `didUpdateWidget`, `_synchronizeController`, `dispose` | Mirrors changed parent values without callbacks and skips same-value assignment to preserve cursor/selection. |
| Effective mutation callbacks | `_changeDescription`, `_changeWhenOccurs`, `_changeSymptoms`, `_changeAttempts`, `_changeOccurrence` | Suppresses identical assignments and emits one isolated complete draft for each effective edit. |
| Field, occurrence, and semantics presentation | `_buildField`, `_buildOccurrence`, `_buildPrimaryColumn`, `_buildOptionalColumn` | Renders exact labels, required/optional copy, keys, multiline fields, three choices, and accessibility semantics. |
| Responsive boundary presentation | `build`, `wizard-problem-wide-layout`, `wizard-problem-compact-layout`, `_buildBoundaryNote` | Chooses two-column or stacked layout and keeps the human-observation/local-draft boundary visible. |

## State and data flow

1. `[D]` A const draft defaults all strings to raw empty values and occurrence
   to `unknown`; `copyWith` returns the same instance when every value matches.
2. `[D]` The parent passes one authoritative immutable draft into the child.
3. `[D]` `initState` seeds four presentation controllers from that snapshot.
4. `[D]` `didUpdateWidget` synchronizes only changed text. Same-value updates
   return before controller assignment, preserving active selection/cursor and
   emitting no callback.
5. `[D]` Each text handler compares raw input to the corresponding parent value,
   then emits one complete copied draft without trimming or normalization.
6. `[D]` Occurrence selection follows the same effective-change rule; unknown
   remains valid and may be reselected without mutation.
7. `[D]` Wide and compact branches reuse the same controllers and authoritative
   value, so layout changes do not create a second draft owner.
8. `[D]` The boundary note describes human observations and local-only state;
   no runtime path interprets or persists the content.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework and UI state | Provides immutable annotation, controllers, fields, chips, semantics, responsive layout, and styling. |
| `NewProjectWizardScreen` | inbound parent | Owns the authoritative draft, trimmed-only validity, dirty state, navigation, and progress. |

There is no provider, router, project model, creator, filesystem, AI/OCR/CV,
schema, writer, materializer, projection, or Project ZIP dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controller text and focus/selection | `UI_LOCAL` | Presentation state is initialized and synchronized from the parent only. |
| `onChanged` draft emission | `UI_LOCAL` | Emits an immutable raw-value proposal back to the Wizard parent; no external state receives it. |
| Labels, chips, semantics, layouts, and boundary note | `ZERO_WRITE` | Render or describe only. |

Human text is observation input, not a canonical problem, diagnosis, component,
electrical relation, repair instruction, event, fact, or project field.

## Zero-write zones

- `[D]` `_buildField`, `_buildOccurrence`, and both layout columns only render
  controlled state and callbacks.
- `[D]` Validity is not calculated here and text is never trimmed, classified,
  summarized, inferred, saved, or sent to an external collaborator.
- `[D]` `_buildBoundaryNote` explicitly denies diagnosis/component/electrical
  interpretation and says the data remains in the local Wizard draft.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Draft model | `[D]` exact enum/defaults/copy/equality define parent no-op behavior. | Wizard parent equality and validity | `UI_LOCAL` | model defaults/copy/equality; integration dirty no-op |
| Controller sync | `[D]` changed-only assignment preserves same-value selection. | focus/cursor and parent rebuilds | `UI_LOCAL` | external synchronization; same-value selection retention |
| Raw callbacks | `[D]` one handler per value emits complete copies. | parent dirty handler | `UI_LOCAL` | raw whitespace; isolated emissions; identical no-op |
| Occurrence | `[D]` three keyed choices read the parent value. | completion remains description-only | `UI_LOCAL` | exact values; all choices; repeated unknown no-op |
| Copy and semantics | `[D]` exact visible labels/keys and semantic labels coexist. | Wizard heading semantics | `ZERO_WRITE` | exact fields/keys/status/semantics |
| Responsive boundary | `[D]` compact/wide branches share controllers and note. | ancestor scroll and Wizard resize | `ZERO_WRITE` | wide/compact operability; integration retention |

## Relevant tests and helpers

Primary focused suite:
`test/widget/new_project_wizard_problem_description_test.dart`, 9 tests using
`_ProblemEditorHarness`, `_controller`, and `_tapKey` for the model, exact
copy/keys/semantics, raw/no-op callbacks, external synchronization, cursor
selection, occurrence choices, responsive layouts, and dependency boundary.

Integration coverage:
`test/widget/new_project_wizard_screen_test.dart`, 55 widget tests, including
Step 5 whitespace gating, progress, five-value retention, effective dirty
handling, identical callback handling, responsive rebuilds, placeholders, and
zero-write traversal.

## Dangerous combinations

- `[D]` Changing model equality, callback guards, and parent dirty handling
  together can turn identical assignments or rebuilds into false edits.
- `[D]` Changing controller synchronization and focus/cursor behavior together
  can overwrite active selection or emit unintended callbacks.
- `[D]` Changing field semantics and visible labels together can hide required
  versus optional status or amplify nested accessibility verbosity.
- `[D]` Adding interpretation, persistence, provider, router, or project-model
  dependencies would cross the accepted local-only boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Model-only: enum, draft defaults/copy/equality, focused unit test, and parent
  equality inspection; exclude field or persistence changes.
- Synchronization-only: `_synchronizeController`, `didUpdateWidget`, selection
  retention, and external-value tests; exclude authoritative child state.
- One field/occurrence callback: handler, stable key/copy, semantic label, raw
  emission test, and parent effective-change inspection.
- Responsive presentation only: wide/compact composition and boundary note;
  preserve controllers, raw values, callbacks, and ancestor scrolling.

## Future extraction seams

- `[S]` Palette values could be shared only through a separately scoped visual
  refactor; they carry no domain or write semantics.
- `[S]` Field presentation could become a private widget if controller and
  authoritative-parent ownership remain explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when model, controller, callback, key, semantics, or
layout anchors change; `FLOW_DRIFT` when synchronization/equality/emission
changes; `BOUNDARY_DRIFT` when observations leave widget state or gain
interpretation; `TEST_DRIFT` when the 9/55-test linkage changes; and
`STRUCTURE_DRIFT` when authoritative ownership moves.

## Known uncertainty

- `[D]` Nested field semantics may be verbose in some accessibility readers;
  tests verify nodes and labels, not end-to-end spoken output.
- `[D]` Controller synchronization collapses changed external text selection to
  the end; same-value updates preserve active selection by skipping assignment.
- `[D]` Responsive automation covers fixed wide/compact sizes, not every device.
