# Code Map: `lib/features/project/widgets/new_project_wizard_problem_description.dart`

- Source: `lib/features/project/widgets/new_project_wizard_problem_description.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable controlled-editor behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Defines the immutable Step 5 problem draft and a controlled compact editor for
required raw description, occurrence, and three optional text fields. It
synchronizes parent values into local text controllers, emits complete changed
drafts once, presents wide/compact layouts and explicit non-diagnostic copy,
and performs no persistence or inference.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Occurrence vocabulary | `NewProjectWizardProblemOccurrence`, `unknown`, `continuous`, `intermittent` | Defines the exact three UI-local occurrence choices and order. |
| Immutable draft | `NewProjectWizardProblemDescriptionDraft`, `copyWith`, `operator ==`, `hashCode` | Carries five raw values and returns identity for a no-op copy. |
| Controlled widget API | `NewProjectWizardProblemDescription`, `value`, `onChanged`, `compact` | Receives parent-owned draft and emits complete replacement values. |
| Controller lifecycle | `_descriptionController`, `_whenController`, `_symptomsController`, `_attemptsController`, `initState`, `didUpdateWidget`, `_synchronizeController`, `dispose` | Mirrors changed parent strings without callback loops and preserves same-value selection. |
| Field callbacks | `_changeDescription`, `_changeWhenOccurs`, `_changeSymptoms`, `_changeAttempts`, `_changeOccurrence` | Suppresses identical edits and emits one complete raw draft for effective changes. |
| Compact fields | `_buildField`, `WizardCompactFieldSection`, `WizardCompactTokens.inputDecoration` | Presents multiline required/optional fields with exact semantics and raw input. |
| Occurrence tiles | `_buildOccurrence`, `WizardCompactTileSelector`, `wizard-problem-occurrence-grid` | Presents typed, keyboard-reachable caller-owned occurrence choices. |
| Boundary notice | `_buildBoundaryNote`, `wizard-problem-boundary-note`, `WizardCompactInlineNotice` | Keeps non-diagnostic/non-electrical/local-draft limits visible and complete. |
| Responsive composition | `_buildPrimaryColumn`, `_buildOptionalColumn`, `wizard-problem-compact-layout`, `wizard-problem-wide-layout`, `build` | Stacks fields in compact mode and uses two columns wide without changing values. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `39/39` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## Qualification evidence

The production file independently owns the draft/enum contract, controller
synchronization, no-op-safe raw callbacks, field semantics, typed occurrence
selection, visible boundary notice, and responsive composition. That exceeds
the automatic five-behavior threshold without a human override.

## State and data flow

1. The parent supplies one immutable draft and `compact` flag.
2. Four controllers initialize from the draft. On parent update, only changed
   text is replaced; same text returns early and preserves selection.
3. Text is preserved raw, including whitespace and newlines. Effective edits
   call `copyWith` on the current parent snapshot and emit one complete draft.
4. Repeated text or occurrence values emit nothing.
5. The required description and occurrence tiles form the primary column;
   three optional fields form the secondary column.
6. Compact mode stacks columns; wide mode places them side by side. The
   visible boundary notice remains after both.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies immutable values, controllers, text fields, semantics, and responsive layout. |
| Compact tokens/widgets | inbound presentation | Supply fields, tile selection, input style, and complete notice. |
| Parent Wizard | inbound state/outbound callback | Owns Step 5 gate, dirty state, review, request, and persistence. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Text controllers | `UI_LOCAL` | Mirror display/edit state only. |
| `onChanged` draft emission | `UI_LOCAL` | Sends raw values to the parent; no service is invoked. |
| Draft/enum/semantics/layout | `ZERO_WRITE` | Immutable values and rendering only. |

No creator, loader, provider, router, filesystem, event, fact, materializer,
AI/OCR/CV, diagnosis, component, placement, measurement, coordinate, net,
electrical, or Project ZIP collaborator is imported.

## Zero-write zones

- Draft equality/copy and occurrence values are in-memory only.
- Controller synchronization emits no callback.
- Boundary text states that the editor does not diagnose or infer.
- Responsive changes do not normalize or persist input.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Draft/enum | `[D]` Exact fields/order/equality are local. | parent Step 5 gate and request | `ZERO_WRITE` | model contract test |
| Controller sync | `[D]` `didUpdateWidget` updates changed text only. | cursor/focus and parent repump | `UI_LOCAL` | changed and same-value external tests |
| Raw callbacks | `[D]` Each handler compares then copies current draft. | dirty state/review/request | `UI_LOCAL` | raw multiline; isolated effective edits; no-op test |
| Occurrence tiles | `[D]` Typed selector emits external value. | keyboard/focus and review label | `UI_LOCAL` | three choices; keyboard activation |
| Boundary copy | `[D]` Complete constant is visible and semantic. | canonical/electrical exclusions | `ZERO_WRITE` | exact copy/semantics test |
| Responsive | `[D]` Caller flag selects row/column. | Wizard overall compact mode | `ZERO_WRITE` | wide/compact operability |

## Relevant tests and helpers

`test/widget/new_project_wizard_problem_description_test.dart` has one unit
and nine widget tests for draft contract, exact copy/semantics, raw input,
effective/no-op callbacks, changed/same external synchronization, occurrence,
keyboard access, and responsive/local-only behavior. The Wizard screen suite
owns Step 5 gating, dirty cancellation, review, request persistence, and 200%
text integration.

## Dangerous combinations

- Changing controller sync and callback guards together can create feedback
  loops or cursor loss.
- Trimming/normalizing child input would change the locked raw-draft contract.
- Changing draft fields without review/request mapping can hide persisted
  values.
- Replacing the boundary notice with contextual/hidden help would remove
  required visible safety copy.
- Adding inference or persistent collaborators crosses protected boundaries.

## Safe SNIPER slices

- Draft value/equality only plus model assertions.
- One field callback plus raw/no-op test.
- Controller synchronization only plus changed/same-value tests.
- Occurrence selector only plus typed/keyboard tests.
- Responsive layout only while values/callbacks remain controlled.
- Boundary-copy presentation only while complete text stays visible.

## Future extraction seams

- `[S]` Repeated field construction could move to another controlled compact
  primitive if raw callbacks and semantics stay exact.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` on draft, controller, handler, tile, or key anchors;
`FLOW_DRIFT` on synchronization or emissions; `BOUNDARY_DRIFT` if
normalization/inference/persistence enters; `TEST_DRIFT` when the ten tests
move; and `STRUCTURE_DRIFT` if model/editor ownership splits.

## Known uncertainty

- `[D]` Parent Step 5 completion trims only for gate validity; this child
  still preserves the raw string.
- `[P]` Spoken-screen-reader quality is approximated through semantics nodes,
  not end-to-end assistive technology.
- `[P]` Wide/compact tests use representative fixed viewports.
