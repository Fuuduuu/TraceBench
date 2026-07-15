# TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only governance scope lock
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS`

This pass locks one later docs-only amendment that integrates code maps and
tool/skill preflight into TraceBench prompting and audit governance. It does
not perform that amendment, edit a map/index, or change runtime/test behavior.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`
- Commit subject: `docs: close out board canvas project navigation hub`
- Initial route: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Tracked diff before editing: empty.
- Cached diff before editing: empty.
- `git diff --check` before editing: PASS.
- Only known untracked scratch/design/generated files were present; they remain
  untouched, unstaged, and outside scope.

The no-active-pass route permits this human-selected governance scope lock.
No product-charter or active-authority conflict was found.

## Tool and skill preflight

`TOOL_SKILL_CHECK`:

- Relevant capability found: YES.
- Capabilities used: repo-local
  `.agents/skills/tracebench-scope-lock/SKILL.md`, `androbuss-pass-runner`,
  `verification-before-completion`, canonical documentation owners, the
  maintained code-map/index lookup, `rg`-based ledger checks, Git scope checks,
  and `tools/validate_all.py`.
- Why applicable: the pass requires an exact docs-only allowlist, layered-owner
  design without duplication, a prior-audit reconciliation, deterministic
  route state, and fresh validation before completion claims.
- External tools required: NO.

The repo-local scope-lock skill supplies the matching docs-only workflow. The
repository has no `scripts/` directory and no specialized documentation
generator or validator is required. Existing tools do not provide a stronger
code-map governance check than the named canonical docs plus the required
validator and focused Git/ledger checks.

## Prior closeout reconciliation

`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS` is accepted, pushed,
and audited at:

- `20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`
- `docs: close out board canvas project navigation hub`
- Claude: `AUDIT_VERDICT: ACCEPT_AS_IS`
- Claude: `SAFE_FOR_STAGING: YES`
- Blockers: none.
- Nits: none.

Git confirms that the commit contains exactly the four operational route docs
plus its closeout artifact. Its `docs/AUDIT_INDEX.md` row is reconciled from
`DRAFTED / PENDING CLAUDE AUDIT` to that accepted/pushed/audited state.

## Existing code-map evidence

`docs/code_maps/CODE_MAP_STANDARD.md` already owns the detailed Dart v1 map
framework: qualification, deterministic map paths, the map template,
responsibility zones, evidence/write classes, SNIPER integration, drift and
maintenance, map audit, concision, and non-authorization.

`docs/code_maps/CODE_MAP_INDEX.md` currently lists exactly one actual map:

- source: `lib/features/board_canvas/screens/board_canvas_screen.dart`;
- map: `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`;
- type: production;
- status: `MAINTAINED`.

The maintained Board Canvas map demonstrates the intended compact preflight
inputs: stable symbols, responsibility zones, direct dependencies, impact
evidence classes, write classes, inspect-only coupling, tests/helpers, and
map-disposition evidence inputs. This scope lock neither changes nor re-audits
that map.

## Layered owner contract

The future amendment must preserve these exclusive responsibilities:

| Owner | Future integration responsibility |
| --- | --- |
| `docs/code_maps/CODE_MAP_STANDARD.md` | Only detailed owner of qualification, map template, responsibility zones, evidence/write classes, SNIPER integration, drift/maintenance, and map-audit model. |
| `docs/PROMPTING_PROTOCOL.md` | Mandatory prompt/report fields and compact code-map hooks. |
| `AGENTS.md` | Task-specific agent loading/routing and stop behavior. |
| `docs/AUDIT_CONTRACT.md` | Independent audit checks for preflight, zones, evidence, tests, and disposition. |
| `docs/FILE_MAP.md` | Documentation ownership, discovery, and task-specific loading rules. |

The other four owners must point to `CODE_MAP_STANDARD.md`. They must not copy
its full qualification table, map template, evidence/write vocabulary, or
drift policy.

## Exact future amendment allowlist

After this scope lock is independently audited, accepted, committed, and
pushed, `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS` may write exactly:

- `AGENTS.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/FILE_MAP.md`
- `docs/code_maps/CODE_MAP_STANDARD.md`

The intended narrow changes are:

- `AGENTS.md`: add task-specific Dart map discovery/routing and exact stop
  behavior without adding maps to the default read set;
- `PROMPTING_PROTOCOL.md`: add mandatory `TOOL_SKILL_CHECK` and conditional
  `CODE_MAP_PREFLIGHT` prompt/report hooks;
- `AUDIT_CONTRACT.md`: add independent verification duties without copying map
  lifecycle mechanics;
- `FILE_MAP.md`: add ownership/loading rows for the standard, index, and exact
  applicable maps; and
- `CODE_MAP_STANDARD.md`: add only the compact governance-integration interface
  and clarify the three dispositions where needed while retaining detailed
  lifecycle ownership.

No wildcard, optional file, new file, or automatic expansion is authorized.

## Locked tool and skill preflight

Every Codex `PASS_ID` prompt must require a preflight before acting: inspect
available repo-local skills, tools, helpers, fixtures, and scripts, then use the
narrowest applicable capability. Every such prompt and final report must
include:

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found
- capability actually used
- why applicable
- external tool required: YES/NO
```

`none applicable` is valid when supported by evidence. A skill, tool, helper,
fixture, script, plugin, or other capability can improve execution inside an
allowlist but never expand that allowlist. `external tool required: YES` is
descriptive only and authorizes neither installation/invocation nor additional
files or surfaces.

## Locked code-map preflight

`CODE_MAP_PREFLIGHT` is mandatory for implementation, repair, diagnostic, QA,
refactor, or review work that targets or materially depends on Dart production
or test files.

It must report:

- target files;
- `CODE_MAP_INDEX` lookup result;
- applicable maintained map path and status;
- qualification result when no map exists;
- changed responsibility zone and stable symbols;
- inspect-only coupled zones;
- explicitly excluded zones;
- direct dependencies;
- expected blast radius with evidence classes;
- write class;
- affected tests/helpers; and
- map disposition.

For diagnostic or review work that changes no source zone, the preflight must
report `changed responsibility zone: none` and identify the zones/symbols
actually inspected.

The preflight is task-specific. It does not make every map a default read and
does not require a nonexistent test map merely because a production map exists.

## Map dispositions

Exactly one disposition must be reported per relevant target:

- `REVIEWED_NO_CHANGE`: an actual map review confirms proposed or accepted
  source work would not materially stale the map.
- `UPDATE_REQUIRED`: proposed source work, if accepted, would materially stale
  the map; route a separate docs-only map-maintenance pass after the source
  state is accepted and committed.
- `NOT_APPLICABLE`: index lookup plus qualification establishes no applicable
  qualifying map, or the target does not qualify.

A disposition reports evidence; it does not authorize implementation or map
maintenance. `NOT_APPLICABLE` is not valid when a relevant Dart target qualifies
but lacks the required current map; that is `BLOCKED_CODE_MAP_REQUIRED`.

## Stop-token set

The future amendment must wire these exact stop tokens:

| Stop token | Locked use |
| --- | --- |
| `BLOCKED_CODE_MAP_REQUIRED` | A relevant Dart target qualifies under the Standard but no required current map exists. |
| `BLOCKED_CODE_MAP_STALE` | The applicable pre-existing map/index is stale, `REVIEW_REQUIRED`, or unverifiable for the needed claim. |
| `BLOCKED_CODE_MAP_CONFLICT` | Map claims conflict with source, tests, canonical owners, or active authority. |
| `BLOCKED_ALLOWLIST_MISMATCH` | Needed source, test, map, or governance work falls outside the active allowlist. |
| `DECOMPOSE_REQUIRED` | Proposed mapped-file work crosses more than one independent responsibility zone without a new explicit human scope decision. |

These tokens do not create automatic map requirements for non-qualifying
files. Qualification remains owned by `CODE_MAP_STANDARD.md`. A currently valid
map that proposed work, if accepted, would materially stale uses
`UPDATE_REQUIRED` and a later map-maintenance pass, not a pre-existing
stale-map blocker.

## Non-authorization and decomposition

A map:

- never authorizes a write;
- never adds a file to an allowlist;
- never overrides source, tests, `docs/POHIKIRI.md`, canonical owners, or the
  active lock; and
- never converts speculative/future extraction information into scope.

When mapped-file work crosses more than one independent responsibility zone,
the agent must stop with `DECOMPOSE_REQUIRED` unless a new explicit human scope
decision authorizes the multi-zone work. A map narrows analysis; it does not
broaden the pass.

`DECOMPOSE_REQUIRED` is a stop outcome, not a fourth disposition.

## Independent audit duty

The future `AUDIT_CONTRACT.md` hook must require Claude to verify:

- the applicable index and map were actually checked;
- named zones and stable symbols match map and source;
- the diff stayed inside the declared responsibility zone and active allowlist;
- inspect-only and excluded zones stayed unchanged;
- write class is supported by actual call-path evidence;
- affected tests match the impact matrix;
- disposition is justified; and
- stale or conflicting maps did not silently authorize implementation.

Claude remains read-only and must use source/tests/canonical owners/active
authority over any conflicting map claim.

## Loading and discovery policy

Maps remain task-specific and outside the default five-file read set.

Routing is fixed as:

- prompt construction -> `docs/PROMPTING_PROTOCOL.md`;
- map lifecycle and qualification ->
  `docs/code_maps/CODE_MAP_STANDARD.md`;
- map discovery and status -> `docs/code_maps/CODE_MAP_INDEX.md`;
- exact zones and impact -> the applicable maintained map; and
- independent audit -> `docs/AUDIT_CONTRACT.md`.

`AGENTS.md` and `FILE_MAP.md` must express this as conditional task routing,
not as a default-read expansion.

## Future route and audit lifecycle

After this scope lock is accepted and pushed:

`TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS`

After the amendment is accepted and pushed:

`TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS`

No active-lock sync is required or authorized. The amendment is Lane A
docs-only governance work with no runtime or test write authority.

## Future amendment validation

The amendment must run:

- `python tools/validate_all.py`;
- `git diff --check`;
- `git diff --name-status`;
- `git diff --cached --name-status`;
- `git status --short --branch`;
- a no-`||`/glued-row check for `docs/AUDIT_INDEX.md` when applicable; and
- exact allowlist and forbidden-surface checks proving index/maps/runtime/tests/
  tools/schemas/packages remain unchanged.

## Exclusions and stop conditions

This scope lock and the future amendment exclude:

- `docs/code_maps/CODE_MAP_INDEX.md` and every existing code map;
- new production or test maps;
- route docs and audit history during the amendment, except the later
  closeout's separately scoped evidence changes;
- runtime, tests, schemas, tools, packages, dependencies, assets, `_incoming`,
  and scratch;
- automatic generators, linters, CI, hooks, or watchers;
- refactors, unrelated prompt-template or legacy-verdict cleanup, overview
  retirement, measurement-test hardening, and product or protected-surface
  changes.

Stop with the applicable locked token or pass-level blocker for baseline
mismatch, dirty tracked/cached state, governance conflict, allowlist mismatch,
map requirement/staleness/conflict, or multi-zone work.

## Exact current scope-lock write set

This pass writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS.md`

Nothing is staged, committed, or pushed.

## Validation record

- `python tools/validate_all.py`: PASS — 285 tests.
- `git diff --check`: PASS.
- Changed-file allowlist: PASS — exact five scope-lock docs.
- `git diff --cached --name-status`: PASS — empty.
- Route synchronization: PASS — scope lock -> direct docs amendment.
- `docs/AUDIT_INDEX.md` no-`||`/glued-row check: PASS.
- `CODE_MAP_INDEX.md`, existing maps, future amendment owners, runtime, tests,
  schemas, tools, packages, assets, and `_incoming` tracked diff: PASS — empty.
- `HEAD == origin/main`: PASS — unchanged at
  `20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`.

## Model routing and audit state

`MODEL_ROUTING_CHECK`: PASS. Codex drafts this Lane A docs-only scope lock,
Claude Code performs the independent repo-local audit, and the human owns exact
staging, commit, and push. This artifact remains
`DRAFTED / PENDING CLAUDE AUDIT` and claims no staging permission.
