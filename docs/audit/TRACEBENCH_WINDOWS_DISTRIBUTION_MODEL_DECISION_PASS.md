# TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS

```text
PASS_ID: TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
Lane: B
Mode: DOCS_ONLY / PRODUCT_ARCHITECTURE_DECISION / PHASE_1
```

## Purpose

Record the standalone/offline Windows distribution-model decision from live
runtime evidence, establish one durable architecture owner, and route next to
the carried projection-freshness provenance decision without implementing
either remediation.

## Verified baseline

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main == 80b2db1c5ca7b72f16981d8f1caeb7707812b28d`
- subject: `docs: lock validation root portability`
- Phase 1 entry staged set: empty
- Phase 1 entry unmerged set: empty

The preceding validation-root portability final LOCK is committed at this
baseline. Its artifact verdict block and ledger Status contain the recorded
independent result, and all three operational owners route to this decision.

## Exact Phase 1 write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md`
6. `docs/audit/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS.md`

No seventh path is authorized. Runtime, tests, tools, schemas, maps, assets,
packages, `pubspec.yaml`, the Windows runner, installer/build surfaces,
Project ZIP implementation, prior audit artifacts, scratch, `_incoming`,
unrelated porcelain, and every stash are read-only.

## Causal evidence

| Live owner | Verified dependency |
|---|---|
| `lib/shared/services/python_runner.dart` | `PythonRunner` probes `py -3`, `python3`, then `python`; absent an explicit `repoRootPath`, its execution root is `Directory.current`. |
| `lib/shared/services/project_creator.dart` | Default project creation discovers Python and invokes relative `tools/materialize_known_facts.py`. The Wizard constructs `ProjectCreator()` without a production support-root override. |
| `lib/shared/services/project_exporter.dart` | Export discovers Python, invokes relative `tools/materialize_known_facts.py`, then relative `tools/export_project_zip.py`; the report provider constructs `ProjectExporter()` with defaults. |
| Accepted V2 writer services | Add, edit, placement, and measurement providers construct their services with default `PythonRunner` behavior and invoke relative `tools/event_writer_service.py`. |
| Python tool dependency closure | `event_writer_service.py` invokes `validate_events_jsonl.py`, which resolves `schemas/events.schema.json`; `export_project_zip.py` invokes the materializer through its current interpreter. |
| `pubspec.yaml` | Flutter assets include brand/sample content only; no Python runtime or `tools/` support bundle is packaged. |

The accepted create, export, and writer paths therefore depend on a
developer-machine Python command and repository-relative support files. A
normal installed build cannot currently guarantee those paths without a
developer environment. This is a distribution/runtime-ownership gap, not a
finding that accepted tool semantics are wrong.

## Product architecture decision

BenchBeep's first supported packaged desktop model is a standalone Windows
desktop application with an application-owned, version-pinned, offline support
bundle containing the private Python runtime and the runtime Python
tools/resources required by accepted local product flows.

The production contract requires:

- no Python installation/configuration by normal users;
- no source checkout or repository-root launch requirement;
- no process-CWD or PATH-selected Python dependency;
- absolute tool/resource resolution from an installed app-owned support root;
- runtime/tool version coupling to the BenchBeep build/release;
- explicit safe failure for a missing, corrupt, incompatible, or incomplete
  support bundle;
- no silent production fallback to arbitrary system Python; and
- offline operation after installation for accepted local flows.

Dependency injection and explicit developer overrides may remain for tests and
repository development. They are not the supported end-user contract and may
not weaken deterministic production selection.

## Rejected alternatives

- `SYSTEM_PYTHON_REQUIRED`: rejected as machine-dependent and non-standalone.
- `SOURCE_CHECKOUT_REQUIRED`: rejected because a developer checkout is not a
  product distribution.
- `DOWNLOAD_RUNTIME_ON_FIRST_RUN`: rejected because it violates offline and
  deterministic operation.
- `PORT_ALL_PYTHON_TO_DART_NOW`: rejected for this remediation because it
  would reopen broad accepted tool semantics without necessity.

## Semantics, supply chain, and platform boundary

Existing materializer, exporter, validator, and writer behavior remains
canonical. No event, schema, canonical fact, writer, validator, materializer,
projection, Project ZIP, confirmation, or evidence semantic change is made or
authorized. No runtime/tool rewrite or Dart port is performed.

There is no first-run or runtime download. The exact bundled-runtime artifact,
tool/resource manifest, installed support-root mechanism, installer, signing
and integrity implementation, update mechanism, failure UX, and applicable
license/notice set remain questions for a later F-03 implementation SCOPE.

Windows desktop is the first packaged target. Mobile, macOS, and Linux
packaging remain outside this decision.

## Durable owner

`docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md` owns only the durable
product and architecture contract. It contains no baseline, route, audit,
staging, commit, push, or pass-lifecycle state.

## Route and deferred work

```text
TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_DECISION_PASS
```

The next pass decides the persisted projection-freshness provenance contract
before any F-02 implementation SCOPE. This decision preauthorizes no exact
schema property or provenance-field name.

F-03 implementation remains deferred. It later requires its own
`SCOPE -> EHITUS -> LOCK` sequence with exact packaging, runtime, tool,
resource, test, installer/build, and validation allowlists.

## Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

This pass changes no Dart responsibility zone. The named Dart files are
read-only causal evidence, and no map or map-index change is required or
authorized.

## Phase 1 validation contract

The Phase 1 executor verifies:

- the exact six-file material set and empty staged/unmerged sets;
- agreement of all three operational route owners;
- one dedicated durable spec and one unique neutral ledger row;
- exactly one BEGIN marker, one END marker, and an empty verdict interior;
- absence of pass lifecycle/current-state claims from the durable spec;
- no F-03 implementation and no accepted exact F-02 provenance field;
- byte preservation of runtime, tests, tools, pubspec, maps, schemas, assets,
  prior artifacts, unrelated material, and stashes;
- `py -3 tools\doctor.py`;
- `py -3 tools\validate_all.py`;
- `git diff --check`;
- `git diff --cached --check`; and
- a complete added-line self-reference sweep across all six files.

## Tool and skill check

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found: tracebench-prompt-authoring; repo doctor and validator
- capability actually used: post-change independent audit handoff construction, causal source inspection, docs-only recording, and local validation
- why applicable: the real six-file decision diff requires a compact repo-local Claude audit packet
- external tool required: NO
```

## Phase 1 audit and self-reference contract

The artifact's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. The artifact's Phase 1 form makes no claim
that this decision pass is accepted, staged, committed, or pushed.

Independent audit reviews the complete six-file Phase 1 diff, causal evidence,
decision coherence, standalone/offline and production/development boundaries,
absence of a hidden system-Python fallback, semantic freeze, route, allowlist,
preservation, and all added-line self-reference claims.

Only a separately authorized bounded Phase 2 may fill the designated verdict
interior and mechanically mirror the returned payload into this PASS_ID's
unique `docs/AUDIT_INDEX.md` Status cell before exact staging.

## Verdict block

<!-- TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS_VERDICT_BLOCK_BEGIN -->

BASELINE_RESULT: PASS
CAUSAL_RESULT: PASS
DECISION_COHERENCE_RESULT: PASS
STANDALONE_OFFLINE_RESULT: PASS
PRODUCTION_DEVELOPMENT_BOUNDARY_RESULT: PASS
SYSTEM_PYTHON_FALLBACK_RESULT: PASS
IMPLEMENTATION_LEAKAGE_RESULT: PASS
SUPPLY_CHAIN_BOUNDARY_RESULT: PASS
F02_ROUTE_RESULT: PASS
ALLOWLIST_RESULT: PASS
PRESERVATION_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/spec/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL.md
- docs/audit/TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS.md

FINDINGS:
NONE

<!-- TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS_VERDICT_BLOCK_END -->
