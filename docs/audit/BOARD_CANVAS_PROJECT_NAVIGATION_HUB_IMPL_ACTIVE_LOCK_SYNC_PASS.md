# BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only active-lock sync
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS`
- Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS`

This pass promotes the accepted two-file implementation reservation into active
write authority. It changes governance documentation only and implements no
runtime or test behavior.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 7b795c49b26463ae535b0ea980524d85ff88fa5f`
- Commit subject: `docs: lock board canvas project navigation hub`
- Direct parent: `a02d87ea1bd71f2eebfc5dfd79ef4b5f3b916c7e`
- Scope-lock commit is present and contains exactly its five docs-only files.
- Initial tracked diff: empty.
- Initial cached diff: empty.
- Initial `git diff --check`: PASS.
- Known untracked scratch remained untouched and outside scope.

## Supplied Claude scope-lock audit

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`
- Blockers: none.
- Nits: none.

The accepted scope-lock commit is:

- `7b795c49b26463ae535b0ea980524d85ff88fa5f`
- `docs: lock board canvas project navigation hub`

The `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS` ledger row is
reconciled to accepted/pushed/audited at that exact commit. No additional audit
result or staging permission is invented.

## Activated route and exact authority

Current:
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS`

Next:
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS`

The active implementation may write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No third file, wildcard, optional file, new file, or automatic expansion is
authorized. This sync itself changes neither allowed implementation file.

## Locked implementation

Add one compact `Projekt` action to the existing Board Canvas rail. It opens an
existing right-panel navigation mode and exposes exactly:

| Visible action | Existing destination |
| --- | --- |
| BenchBeep Home | `/` |
| Foto tõendid | `/project/photos` |
| Viitepildid | `/project/reference-images` |
| Advanced graph | `/project/graph` |
| Sündmused | `/project/events` |
| Teadaolevad faktid | `/project/known-facts` |
| Raport | `/project/report` |

All existing routes and route names remain unchanged. `/project/overview`
remains available. Component and measurement workflows, focus mode, existing
panel modes, Board Canvas visual dominance, and medium/wide reachability remain
preserved.

Panel selection is `UI_LOCAL`; panel rendering and existing-route navigation
are `ZERO_WRITE`. No action may invoke a writer or mutate an event, fact, file,
project state, or projection state.

## Code-map disposition

`REVIEWED_NO_CHANGE`

The maintained map already records GoRouter as an outbound navigation
dependency and classifies route navigation as UI-local/read-only. The
implementation must inspect that note against its accepted diff. If the seven
destinations merely extend the existing zero-write navigation inside Zone 1
screen orchestration and Zone 11 rail/responsive chrome, the disposition stays
`REVIEWED_NO_CHANGE`.

If the diff creates material responsibility drift, introduces a new owner, or
invalidates documented Zone 1 or Zone 11 claims, stop with
`DECOMPOSE_REQUIRED`. The maintained map is not in the active allowlist and
requires a separate docs-only map pass.

## Preserved boundaries and audit gate

This sync and the activated implementation exclude `app.dart`, `router.dart`,
new or renamed routes, overview retirement/redesign, a standalone page/dialog/
drawer, writer/event/fact/file/project-state/projection writes, component or
measurement workflow changes, broad redesign, refactor, extraction,
dependencies, assets, packages, `_incoming`, and code-map edits.

The implementation requires human visual approval in representative medium
and wide layouts before Claude audit. Its future Claude packet must say:

`USE ONLY AFTER MANUAL SMOKE PASS`

## Exact docs-only write set

This sync writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Nothing is staged, committed, or pushed.

## Validation record

- `python tools/validate_all.py`: PASS — 285 tests.
- `git diff --check`: PASS; line-ending notices only.
- Exact five-file docs allowlist: PASS.
- Exact two-file active implementation authority: PASS.
- `git diff --cached --name-status`: PASS — empty.
- Runtime, test, map, tool, and scratch tracked diff: PASS — empty.
- Route synchronization: PASS — implementation -> implementation post-audit.
- `HEAD == origin/main`: PASS — unchanged at
  `7b795c49b26463ae535b0ea980524d85ff88fa5f`.

## Model routing and audit state

`MODEL_ROUTING_CHECK`: PASS. Codex performs this Lane A docs-only transition,
Claude Code independently audits it, and the human owns exact staging, commit,
and push. This artifact remains `DRAFTED / PENDING CLAUDE AUDIT` and claims no
staging permission for the current sync.
