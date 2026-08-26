# Code Map: `test/unit/project_session_test.dart`

- Source: `test/unit/project_session_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 13 tests across lifecycle, generation, dedup, freshness, replacement, and stale/null guard families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Provides direct in-memory contract evidence for `ProjectSession`. Thirteen
unit tests use isolated `ProviderContainer` instances to prove null/zero
initialization, guarded open/reload/close generation transitions, current-state
multi-event composition, event and operation dedup, projection-stale promotion,
stale/null no-ops, and full-replacement dedup reset/reseed. No filesystem,
writer, router, or production test-seeding API is used.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Container lifecycle | `createContainer`, `ProviderContainer`, `addTearDown` | Gives every test an isolated real provider/notifier lifecycle. |
| Initialization and open | `provider starts with null state and generation zero`, `matching-generation open succeeds and advances once`, `stale open is rejected without mutation` | Proves initial contract plus accepted/stale open behavior. |
| Close and sidecar reset | `close clears state and dedup sidecar and advances once` | Proves nulling, one generation advance, and identity reuse after reopen. |
| Same-generation event composition | `two distinct same-generation returned events both survive` | Proves sequential returned events compose against current state without generation advance. |
| Identity dedup | `duplicate event_id is not appended twice`, `duplicate client_operation_id is not appended twice` | Separately proves both accepted identity channels. |
| Freshness promotion | `accepted event promotes projection freshness to stale` | Locks authoritative stale plus compatibility boolean after accepted application. |
| Stale/null guards | `stale generation cannot apply an event or mutate dedup`, `null-session event apply and reload are no-ops` | Proves rejected operations mutate neither state, generation, nor recoverable identities. |
| Reload and full replacement | `matching-generation reload replaces state and advances once`, `stale reload cannot overwrite a newer session`, `full replacement resets and reseeds session dedup` | Proves guarded replacement, newer-session survival, and exact dedup reseeding. |
| Typed fixtures | `_project`, `_rawEvent`, `_storedEvent` | Builds minimal hydrated projects, raw returned events, and stored payload-operation variants. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every helper and exact test-title
literal resolves in committed test source. The map uses no line-number anchors.

## Qualification evidence

Reproducible vector: `0/2/2/2/0/1 = 7/12`.

- Physical size `0`: 365 lines, below 800.
- Independent responsibilities `2`: lifecycle, generation, event composition,
  two identity channels, freshness, stale/null guards, and replacement reseed.
- Canonical/protected boundaries `2`: returned canonical-event projection,
  generation ownership, dedup, and freshness coexist.
- Regression surface `2`: 13 tests across five-plus behavior families.
- Whole-file analysis tax `0`: no recurring broad-reconstruction evidence.
- Blast-radius ambiguity `1`: production session plus one caller family is
  normally required to estimate a behavior change.

## State and data flow

1. `createContainer` creates the real provider and schedules disposal.
2. `_project` supplies nullable session inputs with optional stored events and
   explicit freshness.
3. Open/reload/close tests call the notifier directly and observe both provider
   state identity and generation counts.
4. `_rawEvent` supplies top-level `client_operation_id`; `_storedEvent` supplies
   payload operation identity to exercise installation reseed.
5. Distinct-event coverage applies two events at one generation and requires
   both ordered IDs, proving current-state composition.
6. Dedup cases alter the non-duplicate identity while holding event or
   operation identity constant, isolating each rejection rule.
7. Stale/null cases retry the same raw event at a later valid generation to
   prove rejection did not poison dedup state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectSession`, `projectStateProvider` | system under test | Supplies the actual notifier, state, generation, and operations. |
| Riverpod `ProviderContainer` | harness | Hosts isolated provider lifecycles without widgets. |
| `ProjectState`, `ProjectManifest`, `KnownFacts` | fixture models | Build minimal hydrated sessions and explicit freshness states. |
| `TraceBenchEvent` | stored-event fixture | Seeds event ID and payload operation ID for reseed coverage. |
| Flutter test matchers | assertions | Compare identity, ordered event IDs, generations, and no-op results. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Direct notifier lifecycle calls | observed `PROJECTION_STATE` | Exercise only in-memory session state and sidecars. |
| Raw/stored event fixtures | `ZERO_WRITE` | Create maps/models in memory; no writer or schema service runs. |
| Event-application assertions | observed `PROJECTION_STATE` | Prove returned-event mirroring, not canonical persistence. |
| Stale/null rejection assertions | `ZERO_WRITE` | Require unchanged state/generation and later valid retry. |

The target does not invoke writer services, ProjectLoader, ProjectCreator,
ProjectExporter, materializer, route navigation, filesystem, locks, schemas,
or canonical append. It does not use `SeededProjectSession`; initialization is
tested through the production provider itself.

## Zero-write zones

- Every fixture and sidecar observation is process-local.
- No temporary directory or file is created.
- Rejected operations are asserted as no-ops before a valid retry.
- Generation and identity checks do not claim canonical event persistence.

## Impact matrix

| Family | Direct evidence | Coupling | Write class | Escalation |
| --- | --- | --- | --- | --- |
| Initialization/open | `[D]` provider/state/generation assertions | provider declaration/build | observed `PROJECTION_STATE` | exact lifecycle cases |
| Close/reset | `[D]` reopen and identity reuse | full-install sidecars | observed `PROJECTION_STATE` | close plus replacement case |
| Multi-event composition | `[D]` ordered two-event result | current-state read | observed `PROJECTION_STATE` | exact case + writer callers |
| Event/operation dedup | `[D]` independent identity changes | raw/stored event shapes | no-op duplicate | both dedup plus replacement case |
| Freshness | `[D]` explicit fresh input becomes stale | `ProjectState.copyWith` | observed `PROJECTION_STATE` | exact case + writer widget tests |
| Stale/null guards | `[D]` false result and later valid retry | caller generation capture | `ZERO_WRITE` rejection | guard cases + async widget regressions |
| Reload/reseed | `[D]` identity/generation/replacement assertions | customer report and open flows | observed `PROJECTION_STATE` | reload/reseed + report suite |

## Relevant tests and helpers

- All 13 `test` declarations are direct unit evidence; no widget pump occurs.
- App/Home/acquisition/report suites complement async caller behavior.
- Add/Edit/Measure/Board suites complement writer-result integration.
- `test/helpers/seeded_project_session.dart` is intentionally absent from this
  direct production-provider contract.

## Dangerous combinations

- Changing fixture event shape and production parsing together can make a
  false dedup success look valid.
- Dropping the later-valid retry from stale coverage would stop proving sidecar
  non-mutation.
- Checking only event count in the two-event case would not prove ordered
  current-state composition.
- Using the seeded helper here would bypass production `build` initialization.
- Adding real writers/filesystem would blur session projection and canonical
  persistence evidence.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Initial state/open | exact initialization/open titles | provider declaration/build | three open cases |
| Close reset | exact close title | install/reseed logic | close + replacement case |
| One identity channel | matching duplicate title and raw fixture | other identity channel | exact dedup + reseed case |
| Current-state composition | two-event title | `applyCanonicalEvent` | exact case + writer caller family |
| One stale guard | stale-event, stale-reload, or null title | caller capture site | exact unit + matching widget regression |
| Freshness promotion | freshness title | `ProjectState.copyWith` | exact case + writer widget families |

## Future extraction seams

- `[S]` Fixture builders could move to a unit-only helper if exact event-shape
  differences remain visible; no move is authorized.
- `[S]` Repeated open setup could become a local helper, but explicit
  generation expectations currently improve auditability.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helper or exact test-title anchors move;
`FLOW_DRIFT` when generation/current-state/dedup ordering changes;
`BOUNDARY_DRIFT` when writers/filesystem/schema enter; `TEST_DRIFT` when the
13-case inventory changes; and `STRUCTURE_DRIFT` when fixtures or behavior
families split.

## Known uncertainty

- `[D]` Unit tests prove in-memory notifier semantics, not caller-mounted UI
  messaging or persistence.
- `[P]` Additional future event representations would need new fixture coverage
  before this map could claim their dedup behavior.
- `[S]` Extraction observations are descriptive and non-authorizing.

