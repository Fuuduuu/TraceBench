# Code Map: `test/widget/new_project_wizard_problem_description_test.dart`

- Source: `test/widget/new_project_wizard_problem_description_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — model/controller/semantics/responsive protected-boundary coverage`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PROBLEM_DESCRIPTION_V1_LOCK_PASS.md`

## File purpose

Provides one unit test and eight widget tests for the problem-description
draft/editor in an isolated in-memory harness. It proves exact model values,
raw controlled callbacks, no-op behavior, parent-to-controller synchronization
including same-value selection retention, occurrence choices, copy/keys/
semantics, wide/compact operation, and the absence of persistence or routing
collaborators.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Controlled harness | `_ProblemEditorHarness`, `_ProblemEditorHarnessState`, `value`, `emissions`, `setExternal` | Owns a test-only parent snapshot, records callbacks, and drives external updates. |
| Widget shell and helpers | `_buildEditorApp`, `_controller`, `_tapKey` | Hosts the child under scrollable Material UI and exposes stable controller/choice operations. |
| Draft model contract | `draft defaults, copyWith, equality, and occurrence values are exact` | Verifies exact enum order, defaults, raw copy values, equality/hash, and identity-preserving no-op copy. |
| Copy, keys, and semantics | `exact fields, keys, visible status copy, and semantics render` | Verifies exact visible/semantic required/optional and boundary contracts. |
| Raw and effective callbacks | `raw multiline and whitespace-only text are preserved`, `each effective edit emits one complete isolated draft`, `identical text and repeated occurrence emit no mutation` | Distinguishes raw effective edits from identical no-ops. |
| Synchronization, occurrence, and responsive boundary | `external values synchronize without callbacks`, `same-value parent update preserves selection and emits no callback`, `all three occurrence choices work and preserve text`, `wide and compact layouts stay operable without dependencies` | Proves controlled ownership, selection retention, enum operation, layout, and local-only scope. |

## State and data flow

1. `[D]` `_buildEditorApp` creates only a Material/Scaffold/scroll harness and
   injects no router, provider, creator, model, filesystem, or writer.
2. `[D]` Harness callbacks append complete immutable drafts before replacing
   the in-memory parent value.
3. `[D]` The model test covers all five fields, three occurrence values,
   structural equality/hash, and no-op `copyWith` identity.
4. `[D]` Field tests enter raw multiline and whitespace-only strings and read
   both harness value and recorded emissions without normalization.
5. `[D]` Effective edits across four strings and occurrence yield isolated
   complete snapshots; explicit identical callbacks and repeated unknown do not.
6. `[D]` `setExternal` drives changed parent values into controllers with zero
   emissions; a same-value update preserves a non-collapsed selection.
7. `[D]` Wide and compact repumps retain accessible fields and visible boundary
   copy without adding a collaborator or persistent state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps UI, enters text, taps choices, changes viewport, and inspects controllers/semantics. |
| Flutter Material | harness UI | Supplies the in-memory app, scroll shell, fields, chips, selection, and semantics. |
| `NewProjectWizardProblemDescription` and draft/enum | mapped subject | Supplies the controlled child, immutable model, callbacks, and responsive presentation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Harness `value` and `emissions` | `UI_LOCAL` | Mutate only in-memory test/widget state. |
| Text entry, selection, taps, and viewport | `UI_LOCAL` | Drive controllers and binding state only. |
| Model, semantics, controller, and dependency inspection | `ZERO_WRITE` | Read immutable or presentation snapshots without an output path. |

No test imports or constructs a provider, router, `ProjectCreator`, filesystem
fixture, project model, event/fact writer, materializer, AI/OCR/CV helper, or
Project ZIP surface.

## Zero-write zones

- `[D]` The harness stores values and emissions in memory only.
- `[D]` External synchronization and selection assertions inspect controller
  state without persistence or global seams.
- `[D]` Responsive tests change only the test surface size and restore it.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Model | `[D]` exact values/default/copy/equality are directly asserted. | Wizard parent equality/validity | `ZERO_WRITE` | model unit test |
| Visible/semantic contract | `[D]` keys, labels, selection semantics, and boundary label are exact. | nested semantics behavior | `ZERO_WRITE` | exact fields/keys/copy/semantics |
| Raw callbacks | `[D]` emissions retain raw strings and complete draft isolation. | parent dirty handler | `UI_LOCAL` | raw whitespace; effective emissions; identical no-op |
| Controller sync | `[D]` external changed/same values have distinct outcomes. | cursor/focus and `didUpdateWidget` | `UI_LOCAL` | external synchronization; selection retention |
| Occurrence | `[D]` all three choices preserve text and emit only changes. | description-only completion gate | `UI_LOCAL` | occurrence cycle; repeated unknown no-op |
| Responsive boundary | `[D]` wide/compact shells render without dependencies. | ancestor Wizard scroll/retention | `ZERO_WRITE` | layout operability and boundary copy |

## Relevant tests and helpers

Nine tests form six families: model; exact copy/keys/semantics; raw callback
preservation; effective versus no-op emissions; external synchronization and
selection retention; occurrence; and responsive/local-only behavior. The
55-test Wizard integration suite supplies parent gating, progress, dirty-state,
earlier-step retention, placeholders, and zero-write traversal.

## Dangerous combinations

- `[D]` Changing the harness and callback expectations together can hide a
  child that becomes authoritative or emits duplicate/no-op updates.
- `[D]` Changing controller selection setup and synchronization assertions
  together can miss cursor loss.
- `[D]` Changing visible and semantic labels together can make drift appear
  internally consistent while breaking the locked copy contract.
- `[D]` Adding persistent/global collaborators would invalidate the boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Model-only expectation plus the matching draft/enum code.
- One raw/effective/no-op callback test plus its child handler and parent
  equality inspection.
- Synchronization-only tests plus `_synchronizeController` and controller
  selection behavior.
- Copy/semantics or responsive-only assertion while preserving the controlled
  harness and dependency boundary.

## Future extraction seams

- `[S]` The harness could be shared with a later controlled-field suite only if
  emission ordering and local-only dependencies remain explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when harness, model, field key, semantics, callback,
or layout anchors change; `FLOW_DRIFT` when parent update/emission order or
selection handling changes; `BOUNDARY_DRIFT` when a persistent/global fixture
appears; `TEST_DRIFT` when the nine families change; and `STRUCTURE_DRIFT` when
coverage moves to another suite.

## Known uncertainty

- `[D]` Semantics tests verify labels/nodes, not end-to-end spoken verbosity.
- `[D]` The responsive test covers one wide and one compact size.
- `[D]` Zero-write is established by imports, harness, and reachable call paths,
  not a filesystem monitor.
