# Active Scope Lock

## Route

Current: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Baseline and current authority

The lock begins at accepted baseline
`90432065e6702ff9199c7917b3f55fbe6f72e466`
(`docs: close out code map prompting integration`) with `HEAD == origin/main`,
empty tracked and cached diffs, and the prior route
`NEEDS_USER_DECISION -> NEEDS_USER_DECISION`.

`BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS` may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS.md`

This authority covers docs-only map-lifecycle governance and prior-closeout
ledger reconciliation. It does not authorize the map, index, Dart, runtime,
test, code-map standard, production map, tool, or scratch changes.

## Qualification and target

Target: `test/widget/board_canvas_screen_test.dart`

Deterministic future map:
`docs/code_maps/test/widget/board_canvas_screen_test.dart.md`

Accepted committed-state evidence:

- 10,413 physical lines;
- 143 `testWidgets` plus 10 plain `test` declarations;
- multiple independent navigator/filter, component, placement, measurement,
  painter, canvas, inspector, responsive/focus/navigation, writer/no-write,
  state, router, and filesystem test families; and
- worktree blob equal to the `HEAD` blob.

Qualification is `AUTO — >3000 lines + 3+ test families`. No target map file
or index row exists. `CODE_MAP_INDEX.md` contains only the actual maintained
production Board Canvas map. Changed Dart responsibility zone: none. Dart/test
write authority: none.

This docs-only lifecycle lock is the authorized remediation route. While the
required map is absent, relevant implementation or review stops as
`BLOCKED_CODE_MAP_REQUIRED`; after a draft exists but is `REVIEW_REQUIRED`,
stale, or unverifiable, it stops as `BLOCKED_CODE_MAP_STALE`. Only a verified
`MAINTAINED` map clears the map gate.

## Armed future map authority

After this scope lock is independently audited, accepted, committed, and pushed,
`BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS.md`

There is no fourth file, wildcard, optional expansion, or active-lock sync.
Source, production map, and target test remain inspect-only.

## Locked map contract

The future artifact is a `test` map. It must:

- describe accepted committed state only;
- target 120–220 lines and use no more than 12 meaningful zones;
- anchor on stable symbols, helpers, harnesses, and named test families, never
  maintained line numbers;
- cover file purpose, qualification, state/test-data flow, dependencies,
  write and protected-boundary evidence, zero-write assertions, impact matrix,
  helpers/harnesses, dangerous combinations, safe SNIPER slices,
  non-authorizing extraction observations, freshness triggers, and uncertainty;
- distinguish shared provider overrides, router/navigation lifecycle,
  synchronous temporary-directory/filesystem setup, writer fakes and no-write
  evidence, responsive/focus surfaces, and coupled production zones; and
- remain descriptive and non-authorizing, with no temporary/local-diff claim,
  proposed refactor, or extraction authorization.

The maintained production Board Canvas map is an independent dependency. It
remains unchanged and may be linked as inspect-only evidence without copying
production ownership into the test map.

## Locked lifecycle

Initial metadata:

- test map: `REVIEW_REQUIRED`
- matching index row: `REVIEW_REQUIRED`

Claude then performs a read-only map audit against accepted committed test
source, relevant production source/map, helpers, harnesses, focused tests, and
governance boundaries. Only this accepted result permits synchronization:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
```

The same map pass may then synchronize both statuses to `MAINTAINED` and
record audit evidence in its allowed artifact. A short final read-only Claude
audit is mandatory before staging. `BLOCKED_MAP_DRIFT` or
`SAFE_FOR_SNIPER_USE: NO` leaves both statuses `REVIEW_REQUIRED` and forbids
staging. The human alone stages the exact accepted three-file set.

## Preserved boundaries

No production or test Dart edit, map creation, index edit, production-map
change, test refactor/split, harness repair, Windows file-lock hardening,
runtime/product/route behavior, writer/event/fact/schema/materializer/
validator/projection/Project ZIP/placement/coordinate/net/electrical change,
package, asset, tool, generator, linter, watcher, hook, CI gate, `_incoming`,
scratch, staging, commit, or push is authorized in this scope lock.

## Model routing

`MODEL_ROUTING_CHECK result: PASS` — Codex drafts this Lane A docs-only lock,
Claude Code performs the independent read-only pre-staging audit, and the
human owns exact staging, commit, and push.
