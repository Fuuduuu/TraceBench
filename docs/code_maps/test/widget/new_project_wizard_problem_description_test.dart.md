# Code Map: `test/widget/new_project_wizard_problem_description_test.dart`

- Source: `test/widget/new_project_wizard_problem_description_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — model/controller/semantics/keyboard/responsive protected-boundary coverage`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Provides one unit test and nine widget tests for the immutable problem draft
and controlled Step 5 editor. An isolated in-memory harness verifies exact
values, raw effective callbacks, no-op suppression, controller
synchronization/selection, occurrence tiles, compact keyboard access,
semantics, responsive layout, and absence of persistent collaborators.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Controlled harness | `_ProblemEditorHarness`, `_ProblemEditorHarnessState`, `value`, `emissions`, `setExternal` | Owns a parent snapshot, records complete drafts, and drives external values. |
| App and interaction helpers | `_buildEditorApp`, `_controller`, `_tapKey`, `textScale` | Hosts scrollable Material UI and exposes stable field/tile operations. |
| Draft model | `draft defaults, copyWith, equality, and occurrence values are exact` | Verifies fields, enum order, defaults, equality/hash, and identity-preserving no-op copy. |
| Copy and semantics | `exact fields, keys, visible status copy, and semantics render` | Verifies required/optional labels, keys, selection semantics, and visible boundary. |
| Raw/effective/no-op callbacks | `raw multiline and whitespace-only text are preserved`, `each effective edit emits one complete isolated draft`, `identical text and repeated occurrence emit no mutation` | Distinguishes exact raw edits from unchanged values. |
| External synchronization | `external values synchronize without callbacks`, `same-value parent update preserves selection and emits no callback` | Proves controlled parent ownership without loops or cursor collapse. |
| Occurrence and keyboard | `all three occurrence choices work and preserve text`, `keyboard reaches occurrence choices and activates once` | Proves typed order, text retention, focus, and one activation. |
| Responsive/local boundary | `wide and compact layouts stay operable without dependencies` | Proves both branches and zero collaborator expansion. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `19/19` selected anchors resolve as exact substrings in committed
`HEAD`; zero are missing.

## State and data flow

1. `_buildEditorApp` injects one in-memory harness into a Material/scroll shell.
2. Effective callbacks append the complete immutable draft before replacing
   the harness value; no-op callbacks append nothing.
3. The unit test compares exact fields, occurrence values, equality/hash, and
   `copyWith` identity.
4. Widget tests enter raw whitespace/newlines, inspect emissions, and drive
   changed or same parent values through `setExternal`.
5. Keyboard tests traverse to a tile and activate it once.
6. Surface size/text scale changes are restored after responsive scenarios.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter/`flutter_test` | test driver | Pumps, edits, focuses, sends keys, changes viewport, and inspects controllers/semantics. |
| Problem draft/editor | mapped subject | Supplies controlled model, fields, occurrence, layout, and boundary copy. |

No router, provider, creator, filesystem, project model, event/fact writer,
materializer, AI/OCR/CV, or Project ZIP fixture exists.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Harness value/emissions | `UI_LOCAL` | Mutate only in-memory test state. |
| Text/selection/tile/viewport actions | `UI_LOCAL` | Drive widget/controller/binding state only. |
| Model, semantics, dependency inspection | `ZERO_WRITE` | Read values and widget nodes without output. |

## Zero-write zones

- Harness values/emissions never leave memory.
- External synchronization and selection inspect controller state only.
- Responsive changes are reset.
- No test constructs a global or persistent collaborator.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Model | `[D]` Exact values/default/copy/equality are asserted. | parent gate/review/request | `ZERO_WRITE` | model test |
| Copy/semantics | `[D]` Keys, labels, selection, and boundary are direct. | compact primitives | `ZERO_WRITE` | exact fields/copy/semantics |
| Raw callbacks | `[D]` Harness records complete values. | parent dirty state | `UI_LOCAL` | raw; effective; no-op |
| Controller sync | `[D]` Changed and same parent updates are separate. | cursor/focus | `UI_LOCAL` | synchronization; selection retention |
| Occurrence/keyboard | `[D]` All choices and one key activation are direct. | tile selector | `UI_LOCAL` | choice cycle; keyboard |
| Responsive boundary | `[D]` Both branches render with no extra imports. | parent shell/text scale | `ZERO_WRITE` | wide/compact test |

## Relevant tests and helpers

Ten tests form model, copy/semantics, raw/effective/no-op emission,
synchronization/selection, occurrence/keyboard, and responsive/local-only
families. Wizard integration owns the required Step 5 gate, dirty-state
cancellation, review/request mapping, and parent 200% text behavior.

## Dangerous combinations

- Changing harness emissions with production callbacks can hide duplicate or
  normalized output.
- Changing controller selection setup with sync expectations can miss cursor
  loss.
- Changing copy and semantics assertions together can make drift appear
  internally consistent.
- Adding persistent/global collaborators invalidates the boundary.

## Safe SNIPER slices

- Model-only exact-value expectation.
- One raw/effective/no-op callback test.
- Synchronization/selection only.
- One occurrence/keyboard assertion.
- One responsive branch with teardown.
- Boundary copy/semantics only.

## Future extraction seams

- `[S]` The controlled harness could be shared only if emission ordering and
  zero-dependency scope remain explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` on harness, model, key, title, or controller anchor;
`FLOW_DRIFT` on external update/emission order; `BOUNDARY_DRIFT` if persistent
fixtures enter; `TEST_DRIFT` when ten tests move; and `STRUCTURE_DRIFT` when
the suite or harness splits.

## Known uncertainty

- `[D]` Semantics nodes are checked, not end-to-end spoken output.
- `[D]` Zero-write is shown by imports and reachable call paths, not a
  filesystem monitor.
- `[P]` Representative wide/compact sizes do not enumerate every device.
