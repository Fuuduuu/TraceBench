# Code Map: `test/widget/project_gate_test.dart`

- Source: `test/widget/project_gate_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 12 tests spanning recovery, open outcomes, shared-shell identity, route inventory, provider/file boundaries, and nested navigation`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Verifies the shared loaded-project gate and shell composition through the
production router. The 12-test suite supplies controlled project state,
directory-picker/loader seams, a writer double, exact 15-destination inventory,
and file snapshots. It proves shell-free null recovery, loaded one-gate/one-
shell presentation, same shell element/state across all leaves, both aliases,
nested push/pop, provider/project identity, canonical Home, and byte-level
zero mutation.

## Qualification

`[D]` Committed source remains `SCORE 7/12`: it has five-plus responsibility
zones, multiple protected/provider/file/writer boundaries, more than three
behavior families, and coupled route/gate/shell blast radius. The physical-size
and repeated-whole-file-analysis dimensions remain zero.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Guarded destination inventory | `_projectDestinations` | Defines exact 15 path/destination-type pairs expected beneath one shared gate/shell. |
| Loaded project fixture | `_loadedProject`, `projectDirectory` | Builds explicit-fresh project state with configurable directory and empty canonical collections. |
| Canonical root fixture | `_buildCanonicalHome`, `BenchBeepHomeScreen` | Supplies the required canonical launcher surface with inert callbacks. |
| Router/provider harness | `_RouterSession`, `_pumpRouter`, `homeBuilder` | Builds the production router, overrides providers/seams/writer, mounts theme, and exposes URI/provider observations. |
| Route settling and file snapshot | `_pumpUntilRouterPath`, `_snapshotFiles`, `readAsBytesSync` | Waits for leaf transitions and captures exact recursive file bytes for zero-mutation checks. |
| Representative writer double | `_RecordingAddComponentWriter`, `requests` | Records component-write requests so recovery/reveal/navigation can prove zero calls. |
| Null recovery family | `null project keeps requested URI and shows shared recovery`, `all 15 real project destinations keep null recovery shell-free` | Verifies exact URI, one gate, no shell/destination, recovery UI, and all 15 null routes. |
| Loaded and open outcome family | `preloaded project renders the requested child immediately`, `successful load reveals child without changing original URI` | Verifies loaded/success reveal inside one gate/shell while cancel/failure cases retain recovery and URI. |
| Loaded all-route identity matrix | `all 15 loaded project destinations retain one gate and shell identity`, `WorkbenchShell` | Proves every exact destination, one gate/shell, same element/state, same project, and zero event/fact/file/writer/freshness mutation. |
| Root, aliases, and nested stack | `home recovery action resolves to the root route`, `legacy project redirects settle on their frozen destinations`, `project shell preserves nested push and pop behavior` | Covers canonical Home, both shell-free null aliases, and loaded push/pop with shell identity. |
| Write-capable reveal guard | `write-capable child reveal issues zero component writes`, `AddComponentScreen` | Proves gate success and shell/destination mounting do not submit the representative writer. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed test source. The map uses no line-number anchors.

## State and data flow

1. `_pumpRouter` creates a `ProviderContainer` with explicit project state and
   optional deterministic picker, loader, and writer overrides.
2. `buildTraceBenchRouter` selects the real route. One route-layer
   `ProjectGate` is outside the shared `WorkbenchShell`.
3. Null state renders recovery at the requested URI without mounting shell or
   destination. The 15-route null matrix repeats that contract for every real
   target; both redirect aliases settle on their canonical recovery URI.
4. Cancel and typed/generic failure retain null state and URI; successful load
   replaces the provider and reveals shell plus requested child without a
   default redirect to `/project`.
5. The loaded 15-route loop records the initial shell element/state and asserts
   both identities remain the same while `go` moves among every leaf.
6. That loop also preserves the exact project object, events/facts identities
   and values, freshness, recursive file bytes, and empty writer requests.
7. `push('/project/overview')` displays Overview inside the same shell;
   `pop()` returns canonical `/project` and Board Canvas with the same shell and
   loaded project.
8. Home recovery resolves to `/`, renders `BenchBeepHomeScreen`, and excludes
   the legacy Viewer strings.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `buildTraceBenchRouter`, `GoRouter` | system under test / harness | Supplies production tree, canonical URIs, aliases, `go`, `push`, and `pop`. |
| `ProjectGate` and seam providers | system under test / overrides | Own null/loaded selection and deterministic project opening. |
| `WorkbenchShell` | route-layer observation | Supplies shared loaded-project chrome whose absence/identity is asserted. |
| `projectStateProvider`, `ProviderContainer` | fixture/observation | Injects null/loaded state and proves replacement or identity preservation. |
| `ProjectState`, `ProjectManifest`, `KnownFacts` | fixture models | Build valid minimal loaded state. |
| `ProjectDirectoryOpenAction` behavior | indirect dependency | Supplies picker/loader/error/state-assignment flow through the gate. |
| Fifteen destination widget types | route observations | Prove correct child suppression/reveal. |
| `V2AddComponentWriter` | protected-boundary double | Detects unintended component write requests. |
| `dart:io` Directory/File | fixture and observation | Builds one temporary tree and snapshots bytes without production writes. |
| `buildTheme`, `BenchBeepHomeScreen` | presentation/root fixtures | Prove active recovery treatment and canonical Home. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Router construction/navigation | `UI_LOCAL` | URI/stack and widget construction only. |
| Recovery, shell, and child suppression/reveal | `ZERO_WRITE` | No writer or file mutation during route state changes. |
| Injected picker/loader seams | exercised `NONCANONICAL_FILE` read | Controlled values; no real loader filesystem access. |
| Successful loader result -> provider | observed `PROJECTION_STATE` | Loaded state replaces null without canonical event append. |
| `_RecordingAddComponentWriter.requests` | exercised `CANONICAL_EVENT` boundary | Remains empty during recovery/reveal/navigation. |
| Temporary fixture and `_snapshotFiles` | `NONCANONICAL_FILE` | Fixture creation/cleanup is test-only; snapshots prove product bytes unchanged. |
| Home/alias/nested routing | `UI_LOCAL` | Only route stack and rendered destination change. |

## Zero-write zones

- Recovery copy/tokens, shell absence/presence, destination identity, and URI
  observations are render/navigation-only.
- Cancel/failure preserve null provider state; success observes only the
  existing provider handoff.
- Loaded route loops and nested push/pop retain event/fact/freshness/file/writer
  state exactly.
- The writer double proves absence of requests, not writer internals.

## Impact matrix

| Family | Evidence | Coupling | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Destination inventory | `[D]` exact 15 tuples in null/loaded loops | router and destination types | `UI_LOCAL` / `ZERO_WRITE` | both 15-route matrices |
| Recovery presentation | `[D]` exact copy/tokens and shell absence | ProjectGate/source/theme | `ZERO_WRITE` | null case + null matrix |
| Open lifecycle | `[D]` picker/loader outcomes | open action/provider | observed `PROJECTION_STATE` | cancel, two failures, success |
| Shared shell identity | `[D]` same element/state across loaded leaves | ShellRoute/WorkbenchShell | `ZERO_WRITE` | loaded matrix |
| Nested stack | `[D]` push Overview, pop Canvas | GoRouter shell navigator | `UI_LOCAL` | push/pop case |
| Aliases/Home | `[D]` exact canonical paths and root | router redirects/launcher | `UI_LOCAL` | alias and Home cases |
| Mutation guards | `[D]` identities/values/file bytes/writer requests | protected writers/files/providers | `ZERO_WRITE` | loaded matrix + write-capable reveal |

## Relevant tests and helpers

- `_projectDestinations` is the single exact 15-route/type inventory.
- `_pumpRouter` owns production-router/provider/theme setup.
- `_pumpUntilRouterPath` avoids confusing URI observation with incomplete
  Navigator transitions.
- `_snapshotFiles` supplies recursive byte-level fixture evidence.
- `_loadedProject` supplies explicit-fresh valid state.
- The 12 widget tests cover one direct null case, preloaded reveal, four open
  outcomes, Home recovery, null all-15, loaded all-15 identity/mutation, both
  aliases, nested push/pop, and representative write-capable reveal.

## Dangerous combinations

- Moving `ProjectGate` inside the shell would make null recovery mount chrome
  and invalidate both null matrices.
- Changing the 15-route inventory without router-map review can hide a missing
  or differently wrapped destination.
- Replacing URI assertions together with success callback behavior can mask an
  unwanted `/project` redirect.
- Checking only widget count would miss shell replacement; element and state
  identities must remain paired.
- Nested `push` behavior exposes different route-provider/delegate observations;
  both the visible destination and final `pop` result matter.
- Broadening fixture setup into real loader/persistence calls would cross the
  gate-test boundary.

## Safe SNIPER slices

- Null recovery: exact test, gate subtree, shell absence, requested URI.
- One open outcome: injected seam, provider/URI, shell/destination result.
- Shared loaded composition: one route tuple, gate/shell count, identity, and
  mutation guard; preserve full matrix for inventory changes.
- One alias: redirect declaration and shell-free recovery settlement.
- Nested stack: push/pop test plus router shell structure.
- Writer guard: fake override/request list and write-capable reveal.

## Future extraction seams

- `[S]` Repeated loaded-state invariant assertions could become an expectation
  helper if identity/value evidence remains explicit.
- `[S]` Route inventory sharing is safe only if production and test ownership
  remain independently inspectable.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when inventory/harness/test-name/shell anchors change;
`FLOW_DRIFT` when null/loaded/open/route-settle/nested-stack behavior changes;
`BOUNDARY_DRIFT` when provider/file/writer ownership changes; `TEST_DRIFT` when
any of the 12 cases move; and `STRUCTURE_DRIFT` when route/gate/shell ownership
splits.

## Known uncertainty

- `[D]` Route matrices prove composition and destination rendering, not each
  destination's internal behavior.
- `[D]` Fake loader results do not exercise real disk validation or Project ZIP.
- `[P]` Other seam-provider consumers require broader inspection only if the
  public seam contract changes.
