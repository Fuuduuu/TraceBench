# TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS
Lane: B
Mode: SCOPE_AMENDMENT / DOCS_ONLY / PHASE_1
```

## Purpose

Amend only the accepted Child-A fixture authority after deterministic full
validation proved that the original six-file SCOPE omitted the repository's
second mirrored materializer-owned projection fixture. This amendment changes
no implementation byte and does not restart Child A.

## Verified baseline and entry state

- worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD == origin/main == be2f0b6b7fc431597e91f4656be756b519c16eac`
- subject: `docs: lock projection freshness provenance scope`
- Phase 1 entry staged set: empty
- Phase 1 entry unmerged set: empty

Commit `be2f0b6b7fc431597e91f4656be756b519c16eac` contains the accepted original
SCOPE with its populated verdict block and ledger payload. That artifact stays
byte-frozen. At this amendment's Phase 1 entry, the blocked Child-A worktree
diff consists only of its original six implementation paths.

## Exact current amendment write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS.md`

No sixth amendment path is authorized. All implementation, specs, maps,
packages, other docs, prior artifacts, scratch, `_incoming`, unrelated
porcelain, and every stash are read-only.

## Frozen Child-A entry evidence

The entry implementation set is exactly:

1. `tools/materialize_known_facts.py`
2. `schemas/known_facts.schema.json`
3. `tests/test_materialize_known_facts.py`
4. `tests/test_schema_samples.py`
5. `samples/pelle_pv20_minimal/known_facts.json`
6. `assets/samples/pelle_pv20_minimal/known_facts.json`

```text
LOCAL_WORKTREE_OBSERVATION_ONLY
produced from the current checkout representation
not a committed/reproducible authority
not a future expected value
```

All byte lengths and SHA-256 values in the table below are local Phase 1 entry
observations over worktree bytes, not durable Git-blob anchors. Each was measured with
`Get-FileHash -Algorithm SHA256 -LiteralPath <path>`; byte lengths use
`(Get-Item -LiteralPath <path>).Length`.

| Path | Worktree bytes | Worktree SHA-256 |
| --- | ---: | --- |
| `tools/materialize_known_facts.py` | 38258 | `C721BD4606F9AA4B08890194173A94155CD94FEF04B602E62F5380BD4B4796A0` |
| `schemas/known_facts.schema.json` | 13836 | `E5BAC6FB3B7E61222B04E2B4ACF0CDD8C84B955E3EBCED9557BE3FB41AB119D1` |
| `tests/test_materialize_known_facts.py` | 140670 | `6A38F7A8EA0025509F41B46083497FE6A1354011C3AE71EFEB0819B9F7E5BEA2` |
| `tests/test_schema_samples.py` | 9424 | `6F1D2555C2DBB736EA59E2890A553FDD5168ADCB06125EA44A45D94E17C0D515` |
| `samples/pelle_pv20_minimal/known_facts.json` | 3003 | `4E59CE512E1712FDF188FCE78ACC2A0CE212968ADF27D8E20AAB64B981ECE8AF` |
| `assets/samples/pelle_pv20_minimal/known_facts.json` | 3003 | `4E59CE512E1712FDF188FCE78ACC2A0CE212968ADF27D8E20AAB64B981ECE8AF` |

Those six worktree-byte observations must remain identical at amendment exit.
No reset, restore, stash, reformat, regeneration, or other mutation of them is
part of this docs-only pass.

## Authoritative blocker and causal confirmation

```text
SCOPE_INCOMPLETE / DERIVED_FIXTURE_NOT_REGENERATED
```

The blocker is deterministic:

- `tools/validate_all.py` defines exactly two validation fixture families:
  `pelle_pv20_minimal` and `board_canvas_positive_smoke`;
- `tools/validate_project_zip.py` invokes the current materializer and requires
  canonical equality between regenerated and provided `known_facts.json`;
- the current producer emits mandatory provenance for every successful output,
  so an old derived projection without that envelope mismatches by
  construction; and
- `tests/test_asset_sample_sync.py` requires the positive-smoke sample and
  asset `known_facts.json` files to remain byte-identical.

The mechanically regenerated projection adds only the provenance envelope:

```json
"projection_provenance": {
  "projection_contract_version": "1.0",
  "events_sha256": "<sha256 of the exact event bytes consumed by this run>"
}
```

No transcribed digest is authoritative or a future expected value. Child A
must re-derive it mechanically from the exact byte snapshot it parses.

## MEDIUM-1 — fixture checkout-byte reproducibility

Exact-byte provenance makes checkout byte representation semantically relevant
for committed derived fixtures. The repository currently has no effective EOL
attribute for the four fixture event logs, so it does not determine those
checkout bytes across Git EOL configurations. A committed
`known_facts.json` fixture-provenance digest is therefore not clean-clone
reproducible until fixture event checkout EOL is pinned.

At correction entry, `git check-attr text eol -- <four fixture paths>` reports
both attributes unspecified, local `core.autocrlf` is `true`, and
`git ls-files --eol -- <four fixture paths>` reports index LF with mixed
worktree representation. These are local diagnostic observations only; they
do not pin a future digest.

## Exact Child-A amendment

Old Child-A allowlist count: `6`.

New Child-A allowlist count: `8`.

Exact amended implementation allowlist:

1. `tools/materialize_known_facts.py`
2. `schemas/known_facts.schema.json`
3. `tests/test_materialize_known_facts.py`
4. `tests/test_schema_samples.py`
5. `samples/pelle_pv20_minimal/known_facts.json`
6. `assets/samples/pelle_pv20_minimal/known_facts.json`
7. `samples/board_canvas_positive_smoke/known_facts.json`
8. `assets/samples/board_canvas_positive_smoke/known_facts.json`

No ninth Child-A path is authorized. Paths 7–8 are materializer-owned derived
fixtures of the same class as paths 5–6. After this amendment is independently
accepted and human-committed/pushed, Child A must regenerate both added files
mechanically from the unchanged positive-smoke `events.jsonl`; it may not hand
edit or copy one output over the other. The generated pair must be
byte-identical.

Fixture hashes are derived only after the accepted EOL pass from the exact LF
event bytes then consumed by the materializer. Neither fixture family's digest
is pre-pinned by this amendment.

### Necessity and sufficiency boundary

- The sample path is necessary for the main validator's exported Project ZIP
  to pass deterministic rematerialization equality.
- The asset path is necessary for the existing sample/asset SHA-256 sync gate.
- Together they cover the only other `VALIDATION_FIXTURES` family beyond
  Pelle.
- The existing generated comparison shows no projection change beyond the
  provenance envelope.
- No metadata, report, manifest, event input, validator, schema, tool, test,
  Project ZIP owner, or other output requires mutation for this blocker.

The resumed implementation must prove sufficiency with focused tests, asset
sync, doctor, full `validate_all`, and both Git diff checks. This Phase 1
amendment does not require `validate_all` to become green before the two newly
authorized fixture regenerations occur.

## Preserved producer and protected contracts

All original Child-A semantics remain unchanged:

- one captured `events.jsonl` byte snapshot;
- parser and SHA-256 use that same snapshot;
- exact-byte lowercase SHA-256;
- projection contract version `1.0`;
- provenance on empty and non-empty successful outputs;
- optional-for-reading legacy schema compatibility; and
- no event, fact, evidence, ordering, writer, materialization, canonical, or
  Project ZIP path/contract semantic change.

Both fixture families' `metadata/schema_versions.json`,
`exports/customer_report.md`, `manifest.json`, and `events.jsonl` remain
frozen. No validator suppression or exemption is authorized.

## Required fixture EOL pass

```text
PASS_ID: TRACEBENCH_PROJECTION_FRESHNESS_FIXTURE_EOL_PASS
Lane: B
Mode: REPO_CONFIGURATION_PASS / TDD_STYLE_BEHAVIORAL_VALIDATION
```

Exact future write allowlist:

1. `.gitattributes`

No second tracked implementation path is authorized. The policy is limited to:

```gitattributes
samples/pelle_pv20_minimal/events.jsonl text eol=lf
assets/samples/pelle_pv20_minimal/events.jsonl text eol=lf
samples/board_canvas_positive_smoke/events.jsonl text eol=lf
assets/samples/board_canvas_positive_smoke/events.jsonl text eol=lf
```

No broad `*.jsonl` rule is permitted. No fixture event or known-facts file,
user-project behavior, materializer, schema, test, validator, ZIP owner, Dart
source, package, or map changes in this pass.

Behavioral RED must prove there is no effective `eol=lf` attribute for the
four paths and that the same stored event content can yield different
checkout-byte SHA-256 values under different Git EOL configurations. GREEN
must prove:

- `git check-attr text eol -- <each exact path>` returns `text: set` and
  `eol: lf`;
- independent temporary clean checkouts with `core.autocrlf=true` and `false`
  produce byte-identical LF copies for all four paths;
- SHA-256 values match within each corresponding sample/assets pair; and
- stored event JSON and event semantics are unchanged.

No fixture `known_facts.json` regeneration occurs in the EOL pass. After its
accepted commit/push, the human may restore or re-checkout only those four
otherwise-unmodified worktree files so the current checkout adopts the
committed LF policy before Child A resumes.

## Route and unchanged future authority

```text
TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_FIXTURE_EOL_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PRODUCER_SCHEMA_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_CODE_MAP_PREFLIGHT_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_LOADER_UI_PASS
-> TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS
```

The amendment does not restart Child A. After independent amendment acceptance
and human commit/push, the EOL pass runs first. The frozen six-file diff may
resume only after that pass is independently accepted, committed, and pushed,
and after the human has adopted the four-file LF checkout policy. Child A then
adds the two mechanically regenerated fixture paths and completes its original
validation contract under the exact eight-file authority.

The exact Code Map bootstrap allowlist and complete Child-B qualification
inventory, the exact twenty-file Child-B allowlist, all map activation gates,
the final-LOCK reservation, and all protected boundaries remain semantically
unchanged from the accepted original SCOPE.

```text
CODE_MAP_DISPOSITION: NOT_APPLICABLE
```

This docs-only amendment targets no Dart production or test file and changes
no map or Code Map index.

## Tool and skill check

```text
TOOL_SKILL_CHECK:
- relevant skill/tool/helper found: receiving-code-review; tracebench-scope-lock; verification-before-completion; Git attribute/EOL inspection; repo doctor and diff checks
- capability actually used: MEDIUM-1 verification, docs-only route/allowlist correction, freeze anchoring, and re-audit handoff
- why applicable: the first amendment pinned a checkout-dependent digest before fixture EOL was reproducible across clean clones
- external tool required: NO
```

## Phase 1 validation and audit contract

Phase 1 must prove:

- baseline `HEAD` and `origin/main` unchanged;
- exactly five amendment docs changed in addition to the frozen six-file
  implementation diff;
- all six entry implementation worktree byte lengths and SHA-256 values
  unchanged;
- neither newly authorized implementation fixture changed during amendment;
- route-owner agreement;
- no normative fixture digest remains and any retained worktree hash evidence
  is explicitly `LOCAL_WORKTREE_OBSERVATION_ONLY`;
- the future EOL pass writes only `.gitattributes` and its policy names exactly
  the four fixture event paths without a broad glob;
- `.gitattributes` and all fixture inputs/outputs remain unchanged in this
  docs-only correction;
- old Child-A count `6`, new count `8`, and exactly two added paths;
- original SCOPE artifact, maps, specs, packages, runtime, tests, schemas,
  tools, fixtures, scratch, unrelated porcelain, and stashes preserved except
  for the five explicit docs coordinates;
- one neutral ledger row;
- one BEGIN marker, one END marker, and empty verdict interior;
- `git diff --check` and `git diff --cached --check`; and
- complete five-file `SELF_REFERENCE_AUDIT`.

The artifact's Phase 1 ledger Status is `REVIEW_REQUIRED`, and its designated
Phase 1 verdict interior is empty. Its Phase 1 form makes no claim that this
amendment is accepted, staged, committed, or pushed.

Independent audit must verify MEDIUM-1 resolution, absence of a normative or
future expected digest, explicit local-observation labeling, exact one-file
EOL-pass authority, four exact path-specific LF rules, deterministic RED/GREEN
contract, deterministic blocker, exact two-path necessity and sufficiency,
derived-fixture equivalence, absence of validator suppression, frozen six-file
implementation bytes, unchanged map/Child-B/final-LOCK authority, exact
five-file amendment set, route coherence, and self-reference safety.

Only a separately authorized bounded Phase 2 may fill the verdict interior
and mechanically mirror the returned normalized payload into this PASS_ID's
unique `docs/AUDIT_INDEX.md` Status cell before exact human staging.

## Verdict block

<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_BEGIN -->

BASELINE_RESULT: PASS
ALLOWLIST_RESULT: PASS
MEDIUM_1_RESULT: RESOLVED
LOCAL_OBSERVATION_LABEL_RESULT: PASS
REPRODUCIBILITY_RISK_RESULT: PASS
FIXTURE_EOL_PASS_RESULT: PASS
FOUR_POLICY_RESULT: PASS
CHILD_A_ALLOWLIST_RESULT: PASS
ROUTE_RESULT: PASS
PRESERVATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
TOOL_SKILL_CHECK: PASS_WITH_NIT
CODE_MAP_DISPOSITION: NOT_APPLICABLE
PHASE_2_RECORDING_AUTHORIZATION: YES

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS.md

FINDINGS:

NIT-1:
TOOL_SKILL_CHECK lists non-repo-local capabilities alongside repo-local ones
without distinguishing them. Authority was not widened. Non-blocking.
MUST NOT be patched in Phase 2.

NIT-2:
docs/ACTIVE_SCOPE_LOCK.md contains one Child-A allowlist preamble that omits
the newly inserted FIXTURE_EOL gate, while the same file's route and stricter
gate section plus all other route owners state the correct ordering.
Non-blocking. MUST NOT be patched in Phase 2.
<!-- TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_SCOPE_AMENDMENT_PASS_VERDICT_BLOCK_END -->
