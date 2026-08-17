# Code Map: `test/widget/project_gate_test.dart`

- Source: `test/widget/project_gate_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 10 tests spanning recovery, project-open outcomes, route inventory, provider handoff, visual treatment, and zero-write boundaries`
- Audit evidence: `docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This focused widget-test owner verifies the shared loaded-project gate through
the production router. It supplies controlled project state, directory-picker
and loader seams, a representative component-writer double, and exact route
inventories to prove recovery presentation, original-URI stability, project
open outcomes, all guarded targets, both aliases, canonical BenchBeep Home
navigation with legacy Viewer absence, and zero-write child reveal.

## Qualification

`[D]` Committed source qualifies at `SCORE 7/12` for 10 tests spanning
recovery, project-open outcomes, route inventory, provider handoff, visual
treatment, and zero-write boundaries. The reproducible scoring worksheet is
retained in the matching audit artifact.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Guarded destination inventory | `_projectDestinations` | Defines the exact 15 path/destination-type pairs expected to use the shared gate. |
| 2. Loaded project fixture | `_loadedProject` | Builds explicit-fresh project state with a configurable directory and empty canonical collections. |
| 3. Canonical root fixture | `_buildCanonicalHome`, `BenchBeepHomeScreen` | Supplies the router's required root builder with inert callbacks and the canonical launcher surface. |
| 4. Router and provider harness | `_RouterSession`, `_pumpRouter`, `homeBuilder` | Builds the production router with the explicit root, overrides project/gate/writer providers, mounts `buildTheme()`, and exposes URI plus provider observations. |
| 5. Representative writer double | `_RecordingAddComponentWriter`, `requests` | Records component-write requests so route recovery and child reveal can prove zero writes. |
| 6. Null and loaded rendering | `null project keeps requested URI and shows shared recovery`, `preloaded project renders the requested child immediately` | Verifies exact recovery presentation/token treatment, child suppression, loaded pass-through, URI, and provider state. |
| 7. Project-open outcome family | `cancel keeps URI and recovery without invoking the loader`, `typed load failure keeps URI, recovery, and existing feedback`, `generic load failure keeps URI, recovery, and existing feedback`, `successful load reveals child without changing original URI` | Exercises injected picker/loader outcomes, existing feedback, state assignment, URI retention, and child reveal. |
| 8. Route, root, and alias family | `home recovery action resolves to the root route`, `TraceBench Viewer`, `Read-only Project ZIP Viewer`, `all 15 real project destinations use the shared gate`, `legacy project redirects settle on their frozen destinations` | Covers canonical BenchBeep Home with legacy copy absent, every real target, and both redirect aliases through the production graph. |
| 9. Zero-write representative | `write-capable child reveal issues zero component writes` | Proves recovery and loaded reveal do not invoke the representative canonical writer. |

## State and data flow

1. `_pumpRouter` creates a `ProviderContainer` with explicit project state and
   optional deterministic picker, loader, and writer overrides.
2. `buildTraceBenchRouter` receives `_buildCanonicalHome` as its required
   `homeBuilder`, selects the real route, and mounts `ProjectGate` for each real
   project target.
3. Null project state renders recovery without changing the requested URI or
   mounting the guarded destination.
4. The open action receives controlled picker/loader results: cancel and both
   failure classes retain null state and URI; success replaces provider state.
5. Provider replacement rebuilds the same matched gate and reveals its child
   without a default navigation to `/project`.
6. Home recovery resolves to `/`, renders `BenchBeepHomeScreen`, and excludes
   the two legacy Viewer strings.
7. Route-matrix and alias tests observe production destinations after loading;
   the representative write-capable route keeps its fake request list empty.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `buildTraceBenchRouter`, `GoRouter` | system under test / route harness | Supplies the production route tree, required root contract, canonical URIs, aliases, and route information. |
| `ProjectGate` and gate seam providers | system under test / overrides | Own null/loaded selection and delegate project opening through injected deterministic seams. |
| `projectStateProvider`, `ProviderContainer` | fixture and observation | Injects null/loaded state and proves success replacement or failure preservation. |
| `ProjectState`, `ProjectManifest`, `KnownFacts` | fixture models | Build valid minimal loaded state without canonical writes. |
| `ProjectDirectoryOpenAction` behavior | indirect production dependency | Supplies existing picker/loader/error/state-assignment behavior exercised through the gate. |
| Fifteen destination widget types | route observations | Prove the correct child is suppressed or revealed at each real project target. |
| `V2AddComponentWriter` | protected-boundary test double | Detects unintended component write requests on representative reveal. |
| `buildTheme`, `BenchBeepVisualTokens` | presentation fixture / observation | Proves recovery uses the active dark surface, panel, and rule tokens. |
| `BenchBeepHomeScreen` | explicit root fixture / observation | Proves Home recovery uses the canonical launcher and not the removed Viewer surface. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Router construction and route navigation | `UI_LOCAL` + `ZERO_WRITE` | `[D]` URI changes and widget construction do not persist project facts. |
| Recovery render and child suppression/reveal | `ZERO_WRITE` | `[D]` Provider state and writer requests remain unchanged until a successful explicit open. |
| Injected picker/loader seams | exercised `NONCANONICAL_FILE` read boundary | `[D]` Tests return controlled values and do not access the real filesystem. |
| Successful loader result -> `projectStateProvider` | observed `PROJECTION_STATE` | `[D]` The supplied loaded state replaces null state; no canonical event is appended. |
| `_RecordingAddComponentWriter.requests` | exercised `CANONICAL_EVENT` boundary | `[D]` The fake records zero requests during gate recovery and child reveal. |
| Canonical Home and alias routing | `UI_LOCAL` + `ZERO_WRITE` | `[D]` Only the transient URI and rendered destination change; legacy Viewer copy remains absent. |

## Zero-write zones

- Exact recovery copy, token treatment, and action discovery are render-only.
- Null/loaded gate selection and original-URI observations perform no write.
- Cancel and failure paths preserve null provider state.
- Canonical Home, route inventory, and alias loops navigate without canonical
  mutations.
- The writer double demonstrates absence of a write request; it does not prove
  persistence internals beyond the exercised provider boundary.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Destination inventory | [D] Exact 15 tuples are looped through the production router. | router map and route declarations | `UI_LOCAL` + `ZERO_WRITE` | all-15 matrix; aliases |
| Root construction | [D] Required builder renders the canonical launcher and legacy copy is absent. | router factory and `BenchBeepHomeScreen` callbacks | `UI_LOCAL` + `ZERO_WRITE` | Home recovery |
| Recovery presentation | [D] Exact copy plus active token colors are asserted. | `ProjectGate`, `buildTheme` | `ZERO_WRITE` | null-project recovery |
| Open outcome lifecycle | [D] Picker/loader seams cover cancel, failures, and success. | shared open action and provider | observed `PROJECTION_STATE` | four outcome tests |
| URI and child lifecycle | [D] Router URI and destination finders are asserted before/after load. | gate rebuild and GoRouter settling | `UI_LOCAL` + `ZERO_WRITE` | null, preloaded, success, route matrix |
| Writer boundary | [D] Representative fake list remains empty. | Add Component screen and writer provider | exercised `CANONICAL_EVENT` | write-capable child reveal |

## Relevant tests and helpers

- `_projectDestinations` is the single exact route/type inventory.
- `_buildCanonicalHome` supplies the required inert canonical root fixture.
- `_pumpRouter` is the shared production-router/provider/theme harness.
- `_loadedProject` provides explicit-fresh valid project state.
- `_RecordingAddComponentWriter.requests` is the zero-write observation seam.
- The 10 named widget tests cover recovery, pass-through, four open outcomes,
  canonical Home and legacy absence, all 15 targets, both aliases, and
  representative writer isolation.

## Dangerous combinations

- Changing `_buildCanonicalHome` and the router's required `homeBuilder`
  contract together can hide reintroduction of a parallel root surface.
- Changing `_projectDestinations` without the router map can hide a partially
  gated route inventory.
- Replacing `onOpened: () {}` behavior and URI assertions together can mask an
  unwanted success redirect to canonical `/project`.
- Broadening picker/loader fakes into real filesystem setup would confuse gate
  lifecycle coverage with ProjectLoader or Project ZIP ownership.
- Removing the representative writer assertion can let child mounting become
  indistinguishable from explicit canonical submission.
- Token assertions should compare the active extension rather than duplicate
  color literals or brittle pixel positions.

## Safe SNIPER slices

- Canonical Home only: `_buildCanonicalHome`, required router builder, and the
  Home recovery legacy-absence assertions.
- Recovery presentation only: null-state test, active theme tokens, and
  `ProjectGate` recovery subtree.
- One project-open outcome only: matching injected seam, URI/provider
  assertions, and existing feedback.
- One guarded destination only: `_projectDestinations`, router declaration,
  and the all-15 matrix.
- One alias only: redirect declaration and alias settlement test.
- Zero-write representative only: fake writer override, request list, and
  write-capable route reveal.

## Future extraction seams

- [S] Repeated URI/provider assertions could become small expectation helpers
  if doing so keeps each outcome's evidence explicit.
- [S] The route inventory could be shared with a pure router contract fixture
  only if production and test ownership remain independently inspectable.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when inventory, harness, seam-provider, fake-writer,
or test-name anchors change; `FLOW_DRIFT` when null/loaded/open or route-settle
behavior changes; `BOUNDARY_DRIFT` when provider, filesystem, or writer
ownership changes; `TEST_DRIFT` when any of the 10 outcome families move; and
`STRUCTURE_DRIFT` when route inventory or shared harness ownership splits.

## Known uncertainty

- [D] The route matrix proves gate composition and destination rendering, not
  every destination's internal behavior.
- [D] The fake loader proves state handoff shape without exercising real disk
  validation or Project ZIP behavior.
- [P] Additional consumers of the seam providers may require repository-wide
  inspection if their public scope changes.
