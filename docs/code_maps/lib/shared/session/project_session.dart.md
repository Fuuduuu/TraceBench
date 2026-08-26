# Code Map: `lib/shared/session/project_session.dart`

- Source: `lib/shared/session/project_session.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the nullable loaded-project session behind the public
`projectStateProvider`. `ProjectSession` provides generation-guarded full
replacement, explicit close, current-state canonical-event application,
event/operation identity deduplication, dedup-sidecar reset/reseed, and
projection-stale promotion. It owns only in-memory projection/session state;
canonical persistence, project loading/creation, filesystem, navigation,
writers, models, and schemas remain external.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Provider declaration | `projectStateProvider`, `NotifierProvider<ProjectSession, ProjectState?>`, `ProjectSession.new` | Exposes one nullable project provider whose notifier is the sole session owner. |
| Session initialization | `ProjectSession`, `build`, `_generation`, `_acceptedEventIds`, `_acceptedOperationIds` | Starts null at generation zero and clears both recoverable dedup sidecars whenever the notifier builds. |
| Guarded project open | `generation`, `openProject`, `_installProject` | Accepts a full project only for the current generation, installs it, and advances generation once. |
| Explicit close | `closeProject` | Clears state and dedup sidecars, then advances generation once. |
| Current-state event application | `applyCanonicalEvent`, `TraceBenchEvent.fromJson`, `projectionFreshness: current.projectionFreshness`, `isProjectionStale: true` | Rejects stale/null/duplicate results, composes an accepted returned event against current state, preserves explicit freshness input to `copyWith`, and promotes stale. |
| Guarded reload replacement | `replaceWithReloaded` | Replaces only a non-null current session at the matching generation, then advances once. |
| Dedup reset and normalization | `_installProject`, `_nonEmptyId`, `event.payload['client_operation_id']` | Resets/reseeds event and operation identities from every installed full state and normalizes blank IDs to absent. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every literal resolves in committed
source. The map uses no line-number anchors.

## State and data flow

1. Riverpod constructs `ProjectSession`; `build` returns null, resets
   generation to zero, and clears both sidecars.
2. An async caller captures `generation` before its await. `openProject` or
   `replaceWithReloaded` accepts the result only when that token still equals
   `_generation`; accepted full replacement installs state, rebuilds sidecars,
   and increments generation once.
3. `closeProject` always clears state and sidecars and advances generation, so
   every earlier async token becomes stale.
4. Writer callers capture the current generation and pass raw returned events
   to `applyCanonicalEvent`. The method re-reads `state`; it never composes from
   caller-captured pre-await `ProjectState`.
5. Event ID is checked against the sidecar and current events. Operation ID is
   checked against the sidecar and current event payloads. Either match is a
   no-op that changes neither state nor sidecars.
6. An accepted raw event becomes `TraceBenchEvent`, is appended to current
   events, preserves the current explicit `projectionFreshness` argument, and
   sets compatibility `isProjectionStale: true`; generation does not advance.
7. Accepted identities enter sidecars only after state replacement succeeds.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Riverpod `Notifier` / `NotifierProvider` | framework owner | Supplies provider identity, notifier lifecycle, and reactive nullable state. |
| `ProjectState` | owned in-memory state | Carries the active hydrated project, events, and projection freshness. |
| `TraceBenchEvent` | returned-event parser/model | Validates/parses a writer-returned map before in-memory composition. |
| App/acquisition/report/writer screens | inbound callers | Capture generation and request guarded open, reload, close, or event application. |
| `SeededProjectSession` | test-only subclass | Overrides `build` only in tests; production exposes no seeding API. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `openProject`, `replaceWithReloaded`, `closeProject` | `PROJECTION_STATE` | Replace or clear only the in-memory hydrated session and generation/dedup sidecars. |
| `applyCanonicalEvent` accepted result | `PROJECTION_STATE` | Mirrors an already writer-returned canonical event into current in-memory state and promotes stale; it does not append the canonical log. |
| Stale/null/duplicate result paths | `ZERO_WRITE` | Return false before state or sidecar mutation. |
| Generation and identity getters/helpers | `ZERO_WRITE` | Read or normalize in-memory values only. |

This owner does not invoke a V2 writer, allocate event sequence, change event
status, lock/append `events.jsonl`, load/create/export a project, materialize
facts, navigate, access the filesystem, or redefine evidence/freshness/schema
semantics. `isProjectionStale: true` is compatibility promotion of an already
accepted returned event, not canonical persistence.

## Zero-write zones

- `generation` and `_nonEmptyId` are read/normalization only.
- Rejected open/reload/apply paths mutate neither state, generation, nor dedup.
- Sidecar membership is recoverable process state and is never serialized.
- Provider declaration and `build` perform no project-file or event write.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Provider/build | `[D]` declaration and null/zero initialization | all provider consumers and seeded helper | `PROJECTION_STATE` owner setup | provider-start test plus provider-dependent widget suites |
| Open/close generation | `[D]` equality guard and single increments | app, acquisition, Home | `PROJECTION_STATE` | open, close, stale-open, stale-async widget tests |
| Event application | `[D]` current-state read and parsed append | four writer screens and Board Canvas writers | `PROJECTION_STATE` | two-event, stale-event, freshness, writer widget families |
| Event-ID dedup | `[D]` sidecar/current-event membership | writer result identity | `ZERO_WRITE` on duplicate | event-ID and full-replacement tests |
| Operation-ID dedup | `[D]` payload membership and sidecar | writer client-operation contracts | `ZERO_WRITE` on duplicate | operation-ID and full-replacement tests |
| Reload replacement | `[D]` non-null/matching-generation guard | customer report export/reload | `PROJECTION_STATE` | reload success/stale/null plus report widget tests |
| Install/reseed | `[D]` clear then current-event scan | full replacement and close | `PROJECTION_STATE` sidecar | close and replacement-reset tests |

## Relevant tests and helpers

- `test/unit/project_session_test.dart` supplies 13 direct tests for lifecycle,
  generation, current-state composition, event/operation dedup, stale/null
  no-ops, freshness promotion, and full-replacement reseeding.
- `test/helpers/seeded_project_session.dart` is a 14-line test-only adapter that
  calls `super.build()` before returning a supplied initial state.
- App/Home/acquisition/report widget suites cover stale awaited results and
  explicit Home close; Add/Edit/Measure/Board suites cover writer-result flow.

## Dangerous combinations

- Advancing generation for accepted events would invalidate other legitimate
  same-generation writer completions.
- Composing from caller-captured state can drop a distinct event that completed
  earlier or overwrite a newer full session.
- Updating dedup sidecars before stale/null/duplicate checks can poison a later
  valid retry.
- Failing to clear/reseed sidecars on full replacement can suppress valid
  identities in the next loaded project.
- Omitting explicit `projectionFreshness` preservation when calling
  `ProjectState.copyWith` can silently change compatibility semantics.
- Adding loaders, writers, routes, or persistence would make this owner a
  competing service rather than a narrow session boundary.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Initial provider state | declaration, `build` | seeded helper and consumers | provider-start test |
| One generation transition | `openProject`, `closeProject`, or `replaceWithReloaded` | async caller using it | matching/stale/null lifecycle tests |
| One dedup rule | `applyCanonicalEvent`, matching sidecar | writer event contract | event- or operation-ID tests plus replacement reset |
| Freshness promotion | accepted `copyWith` block | `ProjectState.copyWith` semantics | freshness test plus writer widget families |
| Full-state reseed | `_installProject` | event payload identity | close/replacement tests |

## Future extraction seams

- `[S]` Identity indexing could become a private value object only if reset,
  reseed, and mutation ordering remain directly auditable.
- `[S]` Generation tokens could become a small immutable type only with an
  explicit human architecture scope; the current integer API is cohesive.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when provider/session/public-operation anchors move;
`FLOW_DRIFT` when generation, current-state composition, reset, or reseed
ordering changes; `BOUNDARY_DRIFT` when canonical writers/filesystem/schema or
freshness semantics enter; `TEST_DRIFT` when the 13 direct contracts or caller
guard tests move; and `STRUCTURE_DRIFT` when provider ownership splits.

## Known uncertainty

- `[D]` Operation dedup inspects stored event payloads because
  `TraceBenchEvent` has no dedicated top-level operation-ID field.
- `[D]` The sidecars are recoverable accelerators; current event data remains a
  second dedup source.
- `[P]` Callers decide what a false result means for UI copy/navigation; this
  owner only guarantees no mutation.

