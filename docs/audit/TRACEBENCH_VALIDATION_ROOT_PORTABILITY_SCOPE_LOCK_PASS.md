# TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS

```text
PASS_ID: TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS
Lane: A
Mode: DOCS_SYNC / SCOPE_LOCK
```

## Purpose

Lock one docs-only F-09 cycle that removes clone-location dependence from the
asset/sample synchronization test without changing the test, validator,
runtime, samples, assets, or any product behavior in this SCOPE.

## Verified baseline

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main == 5fb92e71ca3822ae31b3b091f3f94e6a38abd284`
- subject: `docs: reconcile compact lock phase2 state`

The accepted reconciliation artifact, prior Wizard LOCKs, map/index state,
runtime, tests, tools, schemas, specs, samples, assets, unrelated porcelain,
scratch, `_incoming`, and stashes remain outside this SCOPE's write authority.

## Exact current SCOPE write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS.md`

No sixth SCOPE file is authorized. This pass changes no runtime, test, tool,
map, map index, spec, schema, sample, asset, package, pubspec, Project ZIP,
`_incoming`, scratch, or historical audit byte.

## Causal finding

`tests/test_asset_sample_sync.py` currently sets:

```python
base = Path(r"C:/Users/Kasutaja/Desktop/TraceBench")
```

The test's eight existing comparison pairs therefore resolve through one
user-specific clone even when another checkout or process CWD launches the
test. A run may validate the wrong clone when that original path exists or fail
against that unrelated path when it does not.

`tools/validate_all.py` already derives `ROOT` from its own resolved file,
discovers the Python tests beneath that root, and requires no repair. The
comparison root and a directly testable relocation seam fit inside the existing
test file, proving that no second implementation file is needed.

Residual risk is deliberately bounded: this F-09 cycle fixes only the
clone-location dependency in `tests/test_asset_sample_sync.py`. Independent
audit identified separate process-CWD-relative assumptions in
`tests/test_pelle_pv20_sample.py`, `tests/test_materialize_known_facts.py`,
`tests/test_schema_samples.py`, and `tests/test_graph_projection.py`. Those
sibling tests currently work under `tools/validate_all.py` because that runner
intentionally invokes tests with repository `ROOT` as `cwd`; they remain out of
scope for this one-file implementation cycle. GREEN step 2 proves only that
`tests/test_asset_sample_sync.py` is independent of process CWD and clone
location. Neither this implementation nor its final LOCK may claim that every
Python test is independently process-CWD portable. Do not register or repair
the sibling-test residual in `docs/WORK_INTAKE_INDEX.md`, which is outside this
SCOPE allowlist.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_VALIDATION_ROOT_PORTABILITY_PASS
Lane: A
Mode: QA_PASS
```

Exact future write allowlist:

1. `tests/test_asset_sample_sync.py`

No second implementation file is authorized. The reservation activates only
after independent acceptance and human push of this exact five-file SCOPE.

## Portability contract

- Derive repository root from the test file's own resolved location.
- Do not use a username-specific or clone-specific absolute path.
- Do not replace the defect with `Path.cwd()` or another process-CWD
  dependency.
- Preserve exactly the existing eight source/asset comparison pairs.
- Preserve all sample and asset bytes.
- Preserve SHA-256 comparison semantics.
- Preserve existing failure messages; root derivation mechanically requires no
  copy change.
- A small pure root-resolution helper inside this same test file is allowed
  when needed to test relocation directly.
- Do not perform F-10 sample deduplication or fixture movement.
- Do not change assets, packages, pubspec files, Project ZIP, tools, validators,
  runtime, maps, specs, or schemas.

`Path(__file__).resolve().parents[1]` is an acceptable implementation shape,
but the locked requirement is behavior rather than one mandatory syntax.

## RED and GREEN contract

The implementation must begin with a genuine same-file behavioral RED. A
permitted sequence is to expose the current hardcoded result through a small
pure root-resolution seam, then add a regression that supplies a synthetic
relocated absolute `.../tests/test_asset_sample_sync.py` location while the
process CWD is unrelated. The assertion expects the synthetic clone root and
must fail because the retained old behavior returns the original clone.

A missing symbol, finder-only assertion, or production-source text grep is not
qualifying RED evidence.

GREEN must include:

1. `py -3 -m unittest tests.test_asset_sample_sync` from repository root;
2. the same test file launched by its absolute path from an unrelated temporary
   CWD;
3. `py -3 tools\doctor.py`;
4. `py -3 tools\validate_all.py`;
5. `git diff --check`; and
6. `git diff --cached --check`.

No Flutter manual smoke is required because this is Python validation
infrastructure only.

## Code-map disposition

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

The future target is a Python test outside Dart code-map bootstrap. No code map
or `docs/code_maps/CODE_MAP_INDEX.md` edit is authorized.

## Route and boundary

```text
TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS
-> TRACEBENCH_VALIDATION_ROOT_PORTABILITY_PASS
-> TRACEBENCH_VALIDATION_ROOT_PORTABILITY_LOCK_PASS
-> TRACEBENCH_WINDOWS_DISTRIBUTION_MODEL_DECISION_PASS
```

The named LOCK is a later docs-only evidence/route pass derived from accepted
committed implementation. Its file set is not current authority. F-03 is not
implemented in this cycle.

Stop if the implementation needs a second file; process CWD becomes an input;
any comparison pair, hash semantics, or failure copy changes; a sample or asset
byte must move or change; F-10 or F-03 work is required; Project ZIP, package,
pubspec, tool, validator, runtime, map, spec, schema, or protected behavior must
change; a sixth SCOPE file appears; route owners disagree; or unrelated
material or a stash changes.

## Tool and skill check

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found: tracebench-scope-lock and tracebench-prompt-authoring; repo doctor and validator
- capability actually used: docs-only scope reservation, real-diff audit handoff construction, and local read-only inspection/validation
- why applicable: this pass reserves one exact future implementation and creates its independent SCOPE-audit handoff
- external tool required: NO
```

## Verdict block

The designated interior is intentionally empty. Independent audit output may
be recorded only in a separately authorized bounded Phase 2.

<!-- TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
PHASE_2_RECORDING_AUTHORIZATION: YES

BASELINE_RESULT: PASS
ALLOWLIST_RESULT: PASS
RESIDUAL_RISK_RESULT: PASS
FUTURE_IMPLEMENTATION_ALLOWLIST_RESULT: PASS
ROUTE_RESULT: PASS
PRESERVATION_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS.md

FINDINGS / RESIDUAL:

- MEDIUM-1 from the previous audit is RESOLVED.
- This cycle fixes only the clone-location dependency in
  tests/test_asset_sample_sync.py.
- Separate process-CWD-relative assumptions remain outside this scope in:
  - tests/test_pelle_pv20_sample.py
  - tests/test_materialize_known_facts.py
  - tests/test_schema_samples.py
  - tests/test_graph_projection.py
- tools/validate_all.py currently supplies repo ROOT as cwd, so those sibling
  tests remain functional in the normal validation lane.
- Neither this implementation nor its final LOCK may claim suite-wide
  process-CWD portability.
- F-02 remains a carried remediation item and is not part of this cycle.

<!-- TRACEBENCH_VALIDATION_ROOT_PORTABILITY_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
