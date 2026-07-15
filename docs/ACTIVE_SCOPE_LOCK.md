# Active Scope Lock

## Route

Current: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS`

Baseline: `20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`
(`docs: close out board canvas project navigation hub`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Current docs-only write authority

This scope-lock pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS.md`

No governance owner amendment, runtime behavior, test change, map update, tool,
staging, commit, or push is authorized in this pass.

## Future amendment authority

After this scope lock is independently audited, accepted, committed, and
pushed, `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS` may write exactly:

- `AGENTS.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/FILE_MAP.md`
- `docs/code_maps/CODE_MAP_STANDARD.md`

No wildcard, optional file, new file, or automatic expansion is authorized.
The amendment is Lane A docs-only governance work, so no active-lock sync is
required or authorized.

## Layered owner contract

1. `CODE_MAP_STANDARD.md` remains the only detailed owner of qualification,
   map templates, responsibility zones, evidence classes, write classes,
   SNIPER integration, drift/maintenance, and the map-audit model.
2. `PROMPTING_PROTOCOL.md` owns mandatory prompt fields and compact hooks.
3. `AGENTS.md` owns task-specific agent routing and stop behavior.
4. `AUDIT_CONTRACT.md` owns independent audit checks.
5. `FILE_MAP.md` owns documentation loading and ownership routing.

The future amendment must use compact pointers. It must not copy the full
qualification table, map template, or drift policy into another owner.

## Locked prompting contract

Every Codex `PASS_ID` prompt must require a preflight before acting: inspect
available repo-local skills, tools, helpers, fixtures, and scripts, then use the
narrowest applicable capability. Every such prompt and final report must carry:

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found
- capability actually used
- why applicable
- external tool required: YES/NO
```

`none applicable` is valid when supported by evidence. A capability never
expands the active allowlist. `external tool required: YES` is descriptive
only; it authorizes neither installation/invocation nor a new file or surface.

For implementation, repair, diagnostic, QA, refactor, or review work targeting
or materially depending on Dart production/test files, `CODE_MAP_PREFLIGHT`
must report:

- target files;
- `CODE_MAP_INDEX` lookup result;
- applicable maintained map path/status;
- qualification result when no map exists;
- changed responsibility zone and stable symbols;
- inspect-only coupled zones;
- explicitly excluded zones;
- direct dependencies;
- expected blast radius with evidence classes;
- write class;
- affected tests/helpers; and
- map disposition.

For diagnostic or review work that changes no source zone, report
`changed responsibility zone: none` and name the inspected zones/symbols.

Exactly one disposition applies per relevant target:

- `REVIEWED_NO_CHANGE`
- `UPDATE_REQUIRED`
- `NOT_APPLICABLE`

`REVIEWED_NO_CHANGE` requires an actual map review confirming the proposed or
accepted work would not materially stale the map. `UPDATE_REQUIRED` means the
proposed work, if accepted, would materially stale the map and routes a
separate docs-only map-maintenance pass after accepted committed source state.
`NOT_APPLICABLE` requires an index/qualification result showing no applicable
qualifying map or a non-qualifying file. It does not apply when a relevant Dart
target qualifies but lacks the required current map; that stops as
`BLOCKED_CODE_MAP_REQUIRED`.

## Stops, decomposition, and non-authorization

The future governance amendment must wire these exact stop tokens:

- `BLOCKED_CODE_MAP_REQUIRED`
- `BLOCKED_CODE_MAP_STALE`
- `BLOCKED_CODE_MAP_CONFLICT`
- `BLOCKED_ALLOWLIST_MISMATCH`
- `DECOMPOSE_REQUIRED`

`BLOCKED_CODE_MAP_REQUIRED` applies when a relevant Dart target qualifies under
the Standard but no required current map exists. `BLOCKED_CODE_MAP_STALE`
applies to a pre-existing stale, `REVIEW_REQUIRED`, or unverifiable map.
`BLOCKED_CODE_MAP_CONFLICT` applies when map claims contradict source, tests,
canonical owners, or active authority. A currently valid map that proposed
work, if accepted, would materially stale uses `UPDATE_REQUIRED`, not a
pre-existing stale-map blocker.

A mapped-file change crossing more than one independent responsibility zone
stops with `DECOMPOSE_REQUIRED` unless a new explicit human scope decision
authorizes the multi-zone work.

A map never authorizes writes, adds a file to an allowlist, overrides source,
tests, `POHIKIRI`, canonical owners, or the active lock, or turns speculative
extraction information into scope.

`DECOMPOSE_REQUIRED` is a stop outcome, not a fourth map disposition.

## Audit and loading contract

Claude must verify that the applicable index/map were checked; named zones and
symbols match map/source; diff and allowlist stayed inside the declared zone;
inspect-only and excluded zones stayed unchanged; write class has call-path
evidence; tests match the impact matrix; disposition is justified; and stale or
conflicting maps did not authorize work.

Maps remain task-specific and outside the default five-file read set. Routing
is:

- prompt construction -> `docs/PROMPTING_PROTOCOL.md`;
- lifecycle/qualification -> `docs/code_maps/CODE_MAP_STANDARD.md`;
- discovery/status -> `docs/code_maps/CODE_MAP_INDEX.md`;
- zones/impact -> the applicable maintained map; and
- audit -> `docs/AUDIT_CONTRACT.md`.

## Excluded surfaces

The future amendment may not edit `docs/code_maps/CODE_MAP_INDEX.md`, an
existing map, route docs, audit history, runtime, tests, schemas, tools,
packages, assets, `_incoming`, or scratch. It may not create maps, generators,
linters, CI, hooks, watchers, refactors, overview retirement, measurement-test
hardening, unrelated prompt-template/verdict cleanup, or protected product
behavior.
