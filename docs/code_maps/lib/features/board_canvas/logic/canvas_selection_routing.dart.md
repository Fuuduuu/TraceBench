# Code Map: `lib/features/board_canvas/logic/canvas_selection_routing.dart`

- Source: `lib/features/board_canvas/logic/canvas_selection_routing.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — independently tested reconciliation, filtering, measurement resolution and distinct selection/mode transitions`
- Audit evidence: none; source and map require the same independent diff review.

## File purpose

Owns reusable Canvas selection values and pure context-mode decisions. The host
stores the immutable result and performs UI effects. This is a domain-specific
value and policy module, not a notifier, provider, lifecycle owner or writer.
Its separate input events own independent behavior; qualification is not based
on counting getters or returned properties from one cohesive adapter.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Selection and mode vocabulary | `CanvasContextMode`, `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `canvasAnchor` | Retains empty/component/exact-placement distinctions, public IDs and optional Canvas anchor. |
| 2. Immutable reconciliation | `CanvasRoutingState`, `reconcile` | Validates exact key/component identity against caller-supplied visible inputs; retains known unplaced components and returns a new value for invalid selections without mutating input. |
| 3. Filter transition | `afterFilter` | Clears an ineligible selection while preserving the current context mode. |
| 4. Measurement and mode entry | `enterMode` | Preserves exact placement, resolves only a unique matching component placement, leaves zero/multiple component matches unresolved, and retains the accepted empty-selection first-visible fallback. Navigator entry preserves selection; Photos/Safety retain their selection-clearing policy. |
| 5. Canvas/dropdown/empty intents | `selectOnCanvas`, `selectFromDropdown`, `clearOnCanvas`, `_keepsCanvasMode` | Applies the existing context-specific Inspector/hidden policy without moving widget or project lifecycle here. |
| 6. Candidate exclusivity seam | `selectCandidate`, `clearsCandidateSelection`, `withSelection`, `withMode` | Candidate intent clears canonical selection and opens Add. A canonical selection tells the host to clear candidate-controller selection; no controller is called here. |

## State and data flow

1. [D] The host supplies an existing selection/mode, an insertion-ordered map
   of eligible placement keys to component IDs and visible component IDs.
2. [D] Eligibility, `board_normalized` filtering, key construction and category
   classification remain caller responsibilities. The module consumes identities,
   not private host placement entries, facts, widgets or project state.
3. [D] `reconcile` returns the original routing value when valid. Invalid
   placement selection retains the earlier Inspector/empty-inventory hiding rule;
   `afterFilter` intentionally preserves mode while clearing the hidden target.
4. [D] `enterMode` applies the accepted measurement target policy using map
   order only for empty selection. Zero/multiple matching placements remain
   component-only, so the host supplies no resolved Measurement placement.
5. [D] The host applies returned values in user callbacks and project-provider
   listeners. During build, reconciliation is a pure read of the returned key.
6. [D] Candidate and Navigator side effects stay in the host adapter. The
   module never creates a candidate, edits geometry or confirms a component.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:ui` `Offset` | value input | Preserves the existing optional Canvas anchor type. No rendering or coordinate conversion occurs here. |
| `board_canvas_screen.dart` | constructing caller, never imported | Owns state, eligible identities, category synchronization, candidate-controller effects, providers and widgets. |

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| All methods/getters | `ZERO_WRITE` | [D] Return immutable routing values or read their fields. No callbacks, providers, Session, services, filesystem or canonical events are imported. |
| Host application of a decision | `UI_LOCAL` | [D] Host state/controller selection changes are outside this module. |
| Resolved Measurement target | inspect-only protected coupling | [D] Host forwards one resolved placement to the unchanged Measurement workflow; this policy owns neither request construction nor saving. |

## Zero-write zones

The complete module is zero-write. A selection or mode change is not a fact,
canonical confirmation, candidate edit or persistence operation.

## Impact matrix

| Zone | Evidence | Coupled boundary | Tests |
| --- | --- | --- | --- |
| Reconciliation and identity | [D] Exact key/component matching, visible IDs | host lifecycle and selected-entry resolution | standalone `pure reconciliation`; BB-16 widget case |
| Measurement entry | [D] Unique match and retained empty fallback | Measurement save guards and accepted P0 policy | standalone measurement group; existing seven P0 widget cases |
| Filter | [D] Mode preserved after target invalidation | host visible identities and disabled save | all-mode standalone cases; BB-11 widget case |
| Navigator entry | [D] Selection retained | host category/classifier adapter | standalone entry case; both BB-09 widget cases |
| Candidate exclusivity | [D] Pure clearing decision | host must apply controller effect | standalone intent case; BB-08 widget case |

## Relevant tests and helpers

- `test/unit/canvas_selection_routing_test.dart` imports this library directly,
  without BoardCanvasScreen. It covers independent intent/mode cases, target
  resolution, exact anchor retention, reconciliation purity and invalidation.
- `test/widget/board_canvas_screen_test.dart` verifies host application through
  `selection routing module integration`, the accepted P0 target cases and
  existing writer/Session/Placement/Components/Inspector characterization.
- Host source-owner guards require the extracted library and no `_coerceSelection`.

## Dangerous combinations

- Treating component-only selection as empty can redirect a measurement.
- Ignoring `clearsCandidateSelection` leaves two visual selections active.
- Updating selection without the host category adapter breaks Navigator context.
- Applying reconciliation during build would reintroduce lifecycle mutation.
- Filter invalidation must not resolve another component or switch modes.

## Safe SNIPER slices

One intent policy with its standalone case and host integration regression;
measurement policy additionally retains the existing P0 writer-target checks.

## Future extraction seams

No additional extraction, state framework or canonical workflow is authorized.

## Freshness and review triggers

Review type/API changes, identity eligibility, map ordering, target resolution,
mode transitions, candidate effects and host application/lifecycle changes.

## Known uncertainty

- [D] The accepted empty-selection fallback selects the first visible placement;
  that does not establish technician intent. This extraction retains that risk.
- [D] `dart:ui` anchor compatibility means tests use Flutter's unit-test engine;
  the library has no dependency on the Canvas screen or widget tree.
- [D] Pure tests do not establish persistence, writer correctness or visual
  acceptance. Those remain separate existing owners and validation boundaries.
