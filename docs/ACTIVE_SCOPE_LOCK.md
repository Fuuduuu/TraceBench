# Active Scope Lock

## Route

Current: `BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_SCREEN_CODE_MAP_PASS`

Baseline: `5b5c346a6030b40b4071fb6ebc1e4593d2e2fd1b`
(`docs: close out code map standard bootstrap`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.
`docs/code_maps/CODE_MAP_STANDARD.md` is the binding map standard.

## Current docs-only authority

This scope-lock pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS.md`

It must not create or edit a code map or `CODE_MAP_INDEX.md`. Do not stage,
commit, or push from this pass.

## Armed map-pass allowlist

After this scope lock is audited, accepted, and pushed,
`BOARD_CANVAS_SCREEN_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_PASS.md`

If another file is required, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked target and qualification

Target:
`lib/features/board_canvas/screens/board_canvas_screen.dart`

The future map describes accepted committed source only. Qualification is
already prechecked as `AUTO — >5000 lines + 3+ responsibilities`: the source is
11,816 physical lines, owns more than five independently tested behaviors, and
contains canonical writer call paths alongside UI-local state and read-only
renderer/painter responsibilities. The map pass must reverify this evidence.

The 10,043-line, 147-test
`test/widget/board_canvas_screen_test.dart` is relevant inspect-only evidence.
Production and test qualification remain independent; this lock does not
authorize a test-file map.

## Required map content

The production map must:

- use stable symbol anchors and no maintained line-number anchors;
- describe responsibility zones, state/data flows, direct dependencies,
  evidence classes, write classes, protected boundaries, and zero-write zones;
- link relevant tests and helpers without creating their map;
- identify dangerous combinations and safe single-zone SNIPER slices;
- list future extraction seams only as non-authorizing observations;
- remain descriptive, committed-state-only, and subordinate to source, tests,
  canonical owners, `docs/POHIKIRI.md`, and active locks;
- contain no current route, commit identifier, PASS_ID, audit verdict, staging
  instruction, active allowlist, or refactor authorization;
- use no more than 12 responsibility zones; and
- target 150–250 lines and remain below 300 unless the human explicitly
  approves an exception.

`CODE_MAP_INDEX.md` gains exactly one row for this production map.

## Locked audit lifecycle

Initial draft:

- map status: `REVIEW_REQUIRED`
- index status: `REVIEW_REQUIRED`

Claude then performs the full read-only map-to-code audit and returns:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
```

Only `ACCEPT_AS_IS` or `ACCEPT_WITH_NITS` together with
`SAFE_FOR_SNIPER_USE: YES` permits the same map pass to record audit evidence
and change both statuses to `MAINTAINED`. Any substantive correction after the
first audit remains inside the three-file allowlist and must be covered by the
final audit.

A short final read-only Claude diff audit is mandatory after metadata
finalization and before staging. It must confirm exact scope, synchronized
`MAINTAINED` status, map/source consistency, and an exact safe staging set. A
blocked map or SNIPER safety `NO` leaves both statuses `REVIEW_REQUIRED` and
forbids staging.

## Preserved boundaries

No Dart, test, test-file map, `CODE_MAP_STANDARD.md`, Prompting Constitution,
`docs/FILE_MAP.md`, tool, linter, refactor, extraction, runtime, route behavior,
schema, writer, materializer, validator, projection, Project ZIP, event/fact,
canonical placement/coordinate/net/electrical, Board Canvas behavior, package,
asset, or `_incoming` change is authorized. Known scratch/design/generated
material remains untouched and outside every staging set.
