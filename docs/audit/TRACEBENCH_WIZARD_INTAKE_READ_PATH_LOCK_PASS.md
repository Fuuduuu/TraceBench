# TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS

## Authority

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
Lane: B
Mode: DOCS_SYNC / LOCK
```

This docs/map LOCK records the accepted committed Wizard-intake read path,
refreshes exactly three existing code maps from committed `HEAD`, closes the
parent two-child route, and releases only to `NEEDS_USER_DECISION`. It changes
no runtime, test, Project ZIP contract, schema, tool, asset, package,
`_incoming`, scratch, canonical, writer, event, fact, placement, measurement,
or electrical behavior.

## Verified entry baseline

- Worktree: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main ==
  691fea67c6caa8bc9539f48b8baa0fbc6e94665b`
- Subject: `feat: render Wizard intake on Board Canvas`
- Divergence: `0 0`
- Entry substantive tracked diff: empty
- Entry staged set: empty
- Five porcelain-only tracked paths were individually hashed with
  `git hash-object --path=<path> <path>` and matched their `HEAD:<path>` blobs.
- Known untracked scratch was not read as authority and remains outside the
  exact material set.

## TOOL_SKILL_CHECK

- Relevant loader-qualified repo-local capability:
  `.agents/skills/tracebench-scope-lock`
- Capability used: route/baseline/allowlist/boundary discipline for this
  docs-only LOCK
- Why applicable: this pass records one accepted two-child lifecycle and
  freezes the exact post-implementation docs/map authority without reopening
  implementation
- Completion capability: `verification-before-completion`, used for fresh
  validator, anchor, diff, route, material-set, and staged-set evidence
- Repo-local helpers used: Git plumbing, `rg`, PowerShell raw-byte SHA-256
  reproduction, and `py -3 tools\validate_all.py`
- External tool required: `NO`
- Plugins, downloads, installs, and external write integrations: `NOT USED`

No capability expands the exact nine-file allowlist.

## Accepted parent authority

The accepted
`docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS.md` owns this
route:

```text
TRACEBENCH_WIZARD_INTAKE_READ_PATH_SCOPE_LOCK_PASS
-> TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
-> TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
-> TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
-> NEEDS_USER_DECISION
```

The parent classifies `notes/wizard_intake.json` as `NON_CANONICAL`,
`HUMAN_PROVIDED`, and `PRESENTATION_INPUT`; permits only the accepted model,
optional loader read path, and read-only Canvas presentation; and explicitly
defers the Wizard creation/write path.

## Committed Child 1 evidence

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_MODEL_LOADER_PASS
COMMIT: 8118acef186e28320938d4533ce5b16bd7f577bd
PARENT: d22765cd299e4243f9898956f0c2920374e342b2
SUBJECT: feat: add Wizard intake model loader
```

`git diff-tree --no-commit-id --name-status -r 8118acef...` returns exactly:

```text
M  lib/shared/models/project_state.dart
A  lib/shared/models/wizard_intake.dart
M  lib/shared/services/project_loader.dart
M  test/unit/project_loader_zip_test.dart
A  test/unit/wizard_intake_test.dart
```

Committed Git blobs at Child 1 are:

- `lib/shared/models/wizard_intake.dart` —
  `832a1d7e64c2026f0252a8517491477630f76c74`
- `lib/shared/models/project_state.dart` —
  `74e36e46aa73a92b10b501114f92390589fea73c`
- `lib/shared/services/project_loader.dart` —
  `a7deed2870567ae7b81cc800fb520e2e92fec4ba`
- `test/unit/wizard_intake_test.dart` —
  `6c2b569262077041e500b318aeeed80a71782ccd`
- `test/unit/project_loader_zip_test.dart` —
  `0e46eac4466e0606804d54924ca9c5fbeebc6fa3`

The existing Codex implementation report attributes these exact results:

- exact format: `PASS`, `5 files, 0 changed`
- targeted analysis: `PASS`, `no issues`
- focused model/loader tests: `44/44 PASS`
- event-parser regression: `4/4 PASS`
- full Flutter suite: `541/541 PASS`
- Python Project ZIP tests: `36/36 PASS`, `OK`
- `py -3 tools\validate_all.py`: `302/302 PASS`, `OK`
- both diff checks: `PASS`
- exact five-file material set and empty staged set: `PASS`

The human's current LOCK instruction identifies the Child 1 implementation
audit as accepted. Its raw external verdict token and findings are not
committed repo evidence, so this LOCK records
`CHILD_1_IMPLEMENTATION_AUDIT_RESULT: ACCEPTED` without inventing a more
specific verdict payload.

## Committed Child 2 evidence

```text
PASS_ID: TRACEBENCH_WIZARD_INTAKE_CANVAS_READONLY_PASS
COMMIT: 691fea67c6caa8bc9539f48b8baa0fbc6e94665b
PARENT: c8a5181ddcb5eadcc8bb521ebd196611a75296d9
SUBJECT: feat: render Wizard intake on Board Canvas
```

`git diff-tree --no-commit-id --name-status -r 691fea67...` returns exactly:

```text
M  lib/features/board_canvas/screens/board_canvas_screen.dart
M  test/widget/board_canvas_screen_test.dart
```

Committed Git blobs at Child 2 are:

- `lib/features/board_canvas/screens/board_canvas_screen.dart` —
  `8fffb3aeba08c7c906bf6c4be497597a522085fd`
- `test/widget/board_canvas_screen_test.dart` —
  `e7ffb9ba60221eda599716059d85bcfa4119ac2e`

The existing Codex implementation report attributes these exact results:

- exact format: `PASS`, `2 files, 0 changed`
- targeted analysis: `PASS`, `no issues`
- full Board Canvas target: `160/160 PASS`
- Wizard-intake/model-loader regressions: `44/44 PASS`
- full default-concurrency Flutter suite: `548/548 PASS`
- Python Project ZIP tests: `36/36 PASS`, `OK`
- `py -3 tools\validate_all.py`: `302/302 PASS`, `OK`
- both diff checks: `PASS`
- exact two-file material set and empty staged set: `PASS`

The human supplied:

```text
MANUAL_SMOKE: PASS 8/8
HUMAN_ATTESTATION: PASS
FIXTURE_REPOSITORY_MUTATIONS: NONE
```

The human's current LOCK instruction states that Child 2 is independently
audited, committed, and pushed. Its raw external verdict token and findings
are not committed repo evidence, so this LOCK records
`CHILD_2_IMPLEMENTATION_AUDIT_RESULT: ACCEPTED` without inventing a more
specific verdict payload. No additional Child 2 audit or manual-smoke run is
part of this LOCK.

## Committed behavior and boundaries

- Child 1 owns strict typed v1 parsing, exact/root-prefixed optional ZIP
  lookup, directory parity, silent absence, stable nonblocking invalid-intake
  warning, and noncanonical `ProjectState` intake/warning fields excluded from
  `debugJson`.
- Child 2 consumes only `ProjectState.wizardIntake` and
  `wizardIntakeWarning`; renders the photo, closed contour, and visual
  candidates read-only; derives true contour min/max bounds and one centered
  proportional fit with 3% padding clamped to 16–28 px; and shares that fit
  across all Wizard layers.
- Candidates are visible by default under `Visuaalsed kandidaadid`; the photo
  is hidden by default behind `Näita taustafotot` / `Peida taustafoto`;
  unavailable photo states are neutral; and the warning remains verbatim and
  non-modal.
- `_WizardIntakePainter` is non-interactive under `IgnorePointer`; candidate
  rotation occurs only in its private paint path. It does not enter placement
  hit testing, provider mutation, writer paths, or canonical geometry.
- One UI-local initial fit is tracked per active project/intake. Existing
  selection, hit testing, writers, routing, placement, measurement,
  responsive, and canonical behavior remain accepted.
- No `wizard_normalized` -> `board_normalized` conversion, candidate editing,
  component identity, placement, pin/contact, board-side, connection, net,
  measurement, diagnosis, evidence, event, fact, or persistent write is
  created by the read path.

## Map refresh and qualification

All three target source/test files are byte-identical to committed `HEAD` under
`git hash-object --path=<path> <path>` before map refresh.

| Source | Qualification | Accepted change disposition | Phase 1 map/index Status |
| --- | --- | --- | --- |
| `lib/shared/services/project_loader.dart` | `AUTO — 5+ independently testable behaviors` | `UPDATE_REQUIRED` | `REVIEW_REQUIRED` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `AUTO — >5000 lines + 3+ responsibilities` | `UPDATE_REQUIRED` | `REVIEW_REQUIRED` |
| `test/widget/board_canvas_screen_test.dart` | `AUTO — >3000 lines + 3+ test families` | `UPDATE_REQUIRED` | `REVIEW_REQUIRED` |

The maps now describe committed intake load/isolation flow, root-prefix
tolerance, direct `ProjectCreator.parseEvents` caller evidence, Wizard overlay
state, photo resolution, shared fit, render order, candidate rotation,
non-actionability, seven focused overlay tests, and preserved writer/canonical
boundaries. No fourth map is created. Maps remain descriptive and
non-authorizing.

## Project ZIP contract freeze

`docs/PROJECT_ZIP_SPEC.md` is byte-identical to `HEAD`:

- Git blob and filtered worktree blob:
  `7ef2fba99704c6454b7093061971e18444e3c0e8`
- Raw worktree bytes: `3139`
- Raw worktree SHA-256 from `Get-FileHash -Algorithm SHA256`:
  `4501ff6bfd116f03e5b94830229666b9bcd780cc58ba79e37ef81ff9a399b6cf`

This LOCK records no new Project ZIP semantics.

## Deferred creation/write path

The following remain explicitly deferred to a separately scoped human route:

- Wizard Step 1 `Täpsemalt`
- Step 6 review and `Loo projekt`
- Step 7 `Projekt loodud` and `Ava projekt`
- `ProjectCreator` integration
- manifest project/device fields
- photo copy into project `photos/`
- writing `notes/wizard_intake.json`
- provider assignment and Canvas route transition
- `.tracebench_local/canvas_preferences.json` read/write
- persisted zoom, pan, photo visibility, or initial-fit marker

`NEEDS_USER_DECISION` is non-executable. This LOCK arms no Wizard creation or
write implementation.

## Exact Phase 1 material set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/shared/services/project_loader.dart.md`
7. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
8. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
9. `docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS.md`

No tenth file is authorized.

## Route

```text
Current: TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS
Next: NEEDS_USER_DECISION
```

## Phase 1 validation

<!-- PHASE_1_VALIDATION_RESULTS_START -->

- baseline: `PASS` — branch `main`; `HEAD == origin/main ==
  691fea67c6caa8bc9539f48b8baa0fbc6e94665b`; divergence `0 0`; entry
  substantive tracked diff and staged set empty; five porcelain-only tracked
  paths content-identical to `HEAD`
- committed child material sets: `PASS` — Child 1 exact five paths; Child 2
  exact two paths
- `TOOL_SKILL_CHECK`: `PASS` — repo-local inventory inspected; narrow
  `tracebench-scope-lock` procedure and verification-before-completion used;
  capability did not widen the allowlist; nothing installed
- code-map preflight and qualifications: `PASS` — all `35`, `59`, and `40`
  responsibility-zone anchors respectively resolve in committed `HEAD`; the
  three automatic qualification predicates remain satisfied
- `docs/PROJECT_ZIP_SPEC.md` freeze: `PASS` — `3139` bytes; SHA-256
  `4501ff6bfd116f03e5b94830229666b9bcd780cc58ba79e37ef81ff9a399b6cf`;
  no diff
- `py -3 tools\doctor.py`: `PASS` — exit `0`; `[OK] doctor passed`
- `py -3 tools\validate_all.py`: `PASS` — exit `0`; `Ran 302 tests`; `OK`;
  `[OK] validate_all.py PASSED`
- route-owner, map/index, ledger, verdict, and freeze-anchor reproduction:
  `PASS`
- exact nine-file substantive material set: `PASS`; runtime/test diff empty;
  no fourth map; scratch preserved
- `git diff --check`: `PASS`
- `git diff --cached --check`: `PASS`
- staged set: empty
- `SELF_REFERENCE_AUDIT`: `PASS`

<!-- PHASE_1_VALIDATION_RESULTS_END -->

## Reproducible Phase 2 freeze anchors

All values below are raw local `worktree` UTF-8 byte observations for the
bounded Phase 1 -> Phase 2 comparison. They are not Git-blob identities unless
explicitly labelled above. The PowerShell reproducer uses
`[IO.File]::ReadAllBytes`, rejects a UTF-8 BOM, decodes/re-encodes with
`System.Text.UTF8Encoding($false)` without newline normalization, and hashes
with `System.Security.Cryptography.SHA256`.

Complete route-owner anchors:

- `docs/ACTIVE_SCOPE_LOCK.md`: bytes `109934`; SHA-256
  `8b24178698d221a9984794765f4bbd1f9151cde3cae777d157109c4cb0ca4a7c`
- `docs/CURRENT_STATE.md`: bytes `53567`; SHA-256
  `5b4b2011ec4b9a9369b65801323bb85a8978ff42b0990d4cc1c7fa8f8985c19a`
- `docs/PASS_QUEUE.md`: bytes `47960`; SHA-256
  `5b06ee98d36056954fd124fa14dd35c2cb26393a1f1e75e403047f79d6fd4777`

Complete protected-spec anchor:

- `docs/PROJECT_ZIP_SPEC.md`: bytes `3139`; SHA-256
  `4501ff6bfd116f03e5b94830229666b9bcd780cc58ba79e37ef81ff9a399b6cf`

For each map, replace only the value text `REVIEW_REQUIRED` inside the unique
Status line's surrounding backticks with `<MAP_STATUS>`, preserve both
backticks and every other byte, and hash the complete masked file:

- ProjectLoader map: bytes `15893`; SHA-256
  `9b7700e920e914b5f549290ba1adc542c8cf5b7706e30c004ae934d585654bae`
- Board Canvas production map: bytes `25622`;
  SHA-256 `419644841c5dc6154fa2c5d2bdc239436ef22437df8ee6ac6ffc013811c206b8`
- Board Canvas test map: bytes `23001`;
  SHA-256 `ac68abcb9161788240ffb25c9d5ee1b990a56d7624041a66d629b6b17b757a77`

For `docs/code_maps/CODE_MAP_INDEX.md`, split each of the three matching source
rows on literal `|`, replace segment index `4` with exactly ` <MAP_STATUS> `,
preserve every other segment and byte, rejoin the rows, replace only those rows
in the complete raw file, and hash it:

- Masked code-map index bytes: `2355`
- Masked code-map index SHA-256:
  `93cac3b51cafce9154fece79a8f106bc13d0f9165aed3bf0965390b5163391b0`

For `docs/AUDIT_INDEX.md`, locate the unique
`TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS` row, split on literal `|`,
replace segment index `3` with exactly ` <LOCK_STATUS_CELL> `, preserve every
other segment and byte, rejoin, replace only that row in the complete raw file,
and hash it:

- Masked audit index bytes: `79978`
- Masked audit index SHA-256:
  `1375d538850745bafbcb78da8de321ceaabeefdcce8cfd15b711b7b37f801608`

The designated verdict block uses the unique BEGIN/END markers below. Phase 1
requires one occurrence of each and an empty payload after removing one line
ending immediately after BEGIN and one immediately before END. The payload is
`0` UTF-8 bytes with SHA-256
`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

To freeze the artifact exterior, replace the raw verdict payload with
`<LOCK_VERDICT_BLOCK_INTERIOR>`. On the unique `Masked-artifact bytes` line,
replace only the value text inside the surrounding backticks with
`<MASKED_ARTIFACT_BYTES>` and preserve both existing backtick characters. On
the unique `Masked-artifact SHA-256` line, replace only the value text inside
the surrounding backticks with `<MASKED_ARTIFACT_SHA256>` and preserve both
existing backtick characters. Hash the resulting raw UTF-8 without
normalization.

- Masked-artifact bytes: `18528`
- Masked-artifact SHA-256: `7743c45a958b9ec0c0cb7e5d93100071d62324ad7f79055ae6ed8efd9d101a54`

## Bounded Phase 2 mutation authority

A clean independent map/LOCK audit may authorize only:

1. `REVIEW_REQUIRED` -> `MAINTAINED` in the Status header of exactly these
   three maps:
   - `docs/code_maps/lib/shared/services/project_loader.dart.md`
   - `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
   - `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
2. `REVIEW_REQUIRED` -> `MAINTAINED` in exactly the three matching
   `docs/code_maps/CODE_MAP_INDEX.md` Status cells:
   - `lib/shared/services/project_loader.dart`
   - `lib/features/board_canvas/screens/board_canvas_screen.dart`
   - `test/widget/board_canvas_screen_test.dart`
3. returned verdict text inside the designated block; and
4. a mechanical mirror in only this pass's `docs/AUDIT_INDEX.md` Status cell.

Phase 2 may not change map bodies, qualifications, Source, Type, Audit
evidence, another index/ledger row or cell, ledger Description, route prose,
Project ZIP spec, implementation source/tests, accepted parent SCOPE artifact,
runtime, tools, schemas, assets, packages, `_incoming`, scratch, or any other
byte. These eight logical coordinates are the complete Phase 2 authority; no
extra pass or fourth map is created.

## Independent Phase 2 map/LOCK audit contract

The auditor compares all three maps and index rows against committed `HEAD`,
reproduces every freeze anchor, checks the exact nine-file diff and attributed
implementation/manual-smoke evidence, and returns:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
MAP_BODY_FREEZE_RESULT: PASS / FAIL
MASKED_MAP_FREEZE_RESULT: PASS / FAIL
INDEX_FREEZE_RESULT: PASS / FAIL
LEDGER_FREEZE_RESULT: PASS / FAIL
ROUTE_OWNER_FREEZE_RESULT: PASS / FAIL
PROJECT_ZIP_SPEC_FREEZE_RESULT: PASS / FAIL
VERDICT_BLOCK_FREEZE_RESULT: PASS / FAIL
QUALIFICATION_RESULT: PASS / FAIL
PROMOTION_AUTHORIZATION: YES / NO
PROMOTION_MAPS: exact paths or NONE
PROMOTION_INDEX_ROWS: exact source rows or NONE
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact paths or NONE
CHILD_1_IMPLEMENTATION_EVIDENCE_RESULT: PASS / FAIL
CHILD_2_IMPLEMENTATION_EVIDENCE_RESULT: PASS / FAIL
MANUAL_SMOKE_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
VALIDATION_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
FINDINGS: ranked findings or NONE
```

The returned verdict belongs only inside the markers below.

<!-- TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_AUDIT_VERDICT: ACCEPT_AS_IS
MAP_BODY_FREEZE_RESULT: PASS
MASKED_MAP_FREEZE_RESULT: PASS
INDEX_FREEZE_RESULT: PASS
LEDGER_FREEZE_RESULT: PASS
ROUTE_OWNER_FREEZE_RESULT: PASS
PROJECT_ZIP_SPEC_FREEZE_RESULT: PASS
VERDICT_BLOCK_FREEZE_RESULT: PASS
QUALIFICATION_RESULT: PASS
PROMOTION_AUTHORIZATION: YES

PROMOTION_MAPS:
- docs/code_maps/lib/shared/services/project_loader.dart.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md

PROMOTION_INDEX_ROWS:
- lib/shared/services/project_loader.dart
- lib/features/board_canvas/screens/board_canvas_screen.dart
- test/widget/board_canvas_screen_test.dart

AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/lib/shared/services/project_loader.dart.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS.md

CHILD_1_IMPLEMENTATION_EVIDENCE_RESULT: PASS
CHILD_2_IMPLEMENTATION_EVIDENCE_RESULT: PASS
MANUAL_SMOKE_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
VALIDATION_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
PHASE_2_RECORDING_AUTHORIZATION: YES

FINDINGS:

NIT-1:
The Phase 1 validation line labels 35, 59, and 40 tokens as
responsibility-zone anchors. The Stable-symbol-anchor columns actually contain
35, 58, and 40 distinct anchors. The additional Board Canvas production token
is context.go from the Responsibility column, and it also resolves in committed
HEAD, so the substantive source-resolution claim remains true. The label is
imprecise only. No patch is authorized.

<!-- TRACEBENCH_WIZARD_INTAKE_READ_PATH_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, map/index, and route-owner files are checked
- no touched file asserts this LOCK's own acceptance, commit, push, or
  completed audit-pipeline position
- Child implementation audits, validation, manual smoke, commits, and push are
  explicitly attributed to already completed child evidence
- generic independent audit -> bounded recording -> exact staging policy is
  distinguished from claims about this LOCK
- the ledger Status is the neutral factual value
  `LOCK RECORD; designated verdict block empty`
- exactly one matching ledger row and one empty designated verdict block exist
