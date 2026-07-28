# TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS

## Pass identity

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Role: accepted implementation lock, code-map refresh, evidence
  reconciliation, and route release`
- `CODE_MAP_PREFLIGHT: REQUIRED`
- `CODE_MAP_DISPOSITION: REVIEW_REQUIRED`

## Authority gate

- Repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- Remote: `https://github.com/Fuuduuu/TraceBench.git`
- Branch: `main`
- `HEAD`: `ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`
- `origin/main`: `ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`
- Subject: `feat: activate Home-to-Wizard flow`
- Parent: `dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`
- Divergence: `0 0`
- Entry staged set: empty
- Entry substantive tracked diff: empty
- Pre-existing status-only tracked paths were verified content-identical to
  `HEAD`; known untracked scratch remained outside authority.

## Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
8. `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
9. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
10. `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
11. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`
12. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

No thirteenth file is authorized.

## TOOL_SKILL_CHECK

- Repo-local inventory checked:
  `.agents/skills/tracebench-audit-reconciliation`,
  `.agents/skills/tracebench-prompt-authoring`, and
  `.agents/skills/tracebench-scope-lock`
- Narrow capability used:
  `tracebench-audit-reconciliation`, only for the bounded predecessor
  artifact/ledger evidence repair
- `tracebench-scope-lock` was inspected but not used because its own trigger
  excludes implementation closeouts
- Map refresh and route release authority comes from this exact human-supplied
  twelve-file lock, not from a skill
- External tools, plugins, MCP writes, installs, downloads, and internet:
  `NOT USED`

## Accepted implementation identity

Git command:

```text
git diff-tree --no-commit-id --name-status -r
  ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa
```

Exact result:

```text
M  lib/app/app.dart
M  lib/features/home/screens/benchbeep_home_screen.dart
M  lib/features/project/screens/new_project_wizard_screen.dart
M  test/widget/benchbeep_home_screen_test.dart
M  test/widget/new_project_wizard_screen_test.dart
```

The commit is contained by `origin/main`; `HEAD == origin/main` proves the
pushed identity.

## Supplied implementation audit evidence

The human supplied the returned independent implementation result:

```text
AUDITED_PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
```

Exact accepted `SAFE_STAGING_SET`:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Returned findings:

- `NIT-1`: returned and classified as non-blocking; verbatim wording was not
  supplied in the repository or current authority handoff.
- `NIT-2`: returned and classified as non-blocking; verbatim wording was not
  supplied in the repository or current authority handoff.

This record preserves both findings separately by count and classification. It
does not invent either finding's wording, affected line, or remediation. The
returned `SAFE_FOR_STAGING: YES` result establishes that neither finding
required an implementation patch before the exact five-file staging set.

Manual-smoke evidence in the implementation thread reported a clean wide
render and found two misleading state claims before audit: a premature creation
promise and `Valmis` on visited non-functional steps. Both were corrected in
the accepted commit. The current source now states the zero-write boundary and
uses `Vaadatud` for visited placeholders.

## Committed source identity

All map claims were derived from committed `HEAD` source.

| Source | Physical lines | Git blob object id |
| --- | ---: | --- |
| `lib/app/app.dart` | 143 | `0fcf33eeda95f5e4b7ac5a6a2a562e2c2f5a58e7` |
| `lib/features/home/screens/benchbeep_home_screen.dart` | 1,221 | `86d075dd4ab2477bda6498695e22eba253e2c19b` |
| `lib/features/project/screens/new_project_wizard_screen.dart` | 1,203 | `a55c50b22652f70f8f3c36fa996e268ad16ef0e5` |
| `test/widget/benchbeep_home_screen_test.dart` | 1,174 | `655629ff19f257985b73ff728bf7fc0214087de2` |
| `test/widget/new_project_wizard_screen_test.dart` | 621 | `79901143bbe64bebaf9dcee95001df2f29d99dad` |

Physical lines are counted from the committed, content-identical worktree files
with `Get-Content -LiteralPath <path>`. Blob identities use
`git rev-parse HEAD:<path>`.

## CODE_MAP_PREFLIGHT

The implementation materially changed all five mapped targets. The index
lookup found one existing deterministic `MAINTAINED` map for each source, and
each map was stale against accepted `HEAD`.

| Source | Qualification | Accepted committed behavior requiring refresh |
| --- | --- | --- |
| `lib/app/app.dart` | `AUTO — production file owns 5+ independently testable behaviors` | `_buildLauncherHome` now supplies `onCreateProject` and opens `/new-project` through `_openWorkbench` without project-state assignment. |
| `lib/features/home/screens/benchbeep_home_screen.dart` | `AUTO — production file owns 5+ independently testable behaviors` | Public callback and `_LauncherRail` now expose an enabled, unbadged `Loo projekt nullist` action. |
| `lib/features/project/screens/new_project_wizard_screen.dart` | `AUTO — 5+ independently testable behaviors` | Six-step widget-local foundation replaces the creator form and owns honest zero-write copy, progress, draft retention, cancellation, and responsive layout. |
| `test/widget/benchbeep_home_screen_test.dart` | `SCORE 11/12` | Eighteen tests now include callback isolation and real `TraceBenchApp` Home-to-Wizard routing while preserving all prior Home flows. |
| `test/widget/new_project_wizard_screen_test.dart` | `SCORE 6/12 — multi-family responsive/navigation regression surface` | Eighteen tests now cover the six-step foundation, honest copy/status, navigation, retention, cancellation, responsive layout, and absence of creation. |

All five map headers and matching registry Status cells are
`REVIEW_REQUIRED`.

## Accepted behavior recorded by the maps

1. `BenchBeepHomeScreen` requires `onCreateProject` and threads it to
   `_LauncherRail`.
2. `Loo projekt nullist` is enabled and has no `Tulekul` badge.
3. `TraceBenchApp._buildLauncherHome` supplies
   `_openWorkbench(initialLocation: '/new-project')`.
4. The create action assigns no `projectStateProvider`, constructs no creation
   request, and invokes no `ProjectCreator`.
5. The Wizard exposes six exact Estonian step labels.
6. Step 1 holds project name, device name, selected parent path, and additional
   information only in widget state.
7. `Edasi` requires a nonblank project name and selected parent path.
8. Forward/back navigation retains the complete Step 1 draft.
9. Untouched cancel returns Home; touched cancel requires confirmation and
   `Jätka loomist` preserves the current step and draft.
10. Only completed Step 1 is `Valmis`; visited prior placeholder Steps 2–5
    are `Vaadatud`, while Step 6 remains current when reached and is never
    `Valmis`.
11. Steps 2–6 are honest placeholders; Step 6 has no create CTA.
12. The selected path creates no folder/file and final creation is not
    implemented.
13. Wide and compact Wizard layouts and wide/medium Home layouts have focused
    regression tests.
14. All unrelated sample, folder, ZIP, existing-project, hover, identity, and
    exit behavior remains covered.

## Write and protected boundaries

- No Dart or test file is changed by this docs/map lock.
- `lib/app/router.dart`, `ProjectCreator`, project persistence, schemas,
  writers, materializers, packages, assets, tools, and `_incoming` are
  unchanged.
- The new Home action is navigation-only.
- The Wizard is `UI_LOCAL` / `ZERO_WRITE`.
- No directory, file, project, manifest, event, fact, projection, outline,
  marker, component, Project ZIP output, or canonical semantic change occurs.
- Code maps are descriptive and non-authorizing.

## Map freeze anchors

For each map body, read the local worktree file as UTF-8 without BOM,
preserving its existing line endings. Take the raw substring from the first
character of `## File purpose` through EOF, encode it as UTF-8 without BOM, and
calculate SHA-256.

| Map | Body bytes | Body SHA-256 |
| --- | ---: | --- |
| `docs/code_maps/lib/app/app.dart.md` | 11,388 | `36e0e2ec7278ac5c66915fe71184f118994f203f343310b6c077450f72ffbefc` |
| `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md` | 12,977 | `f2dfc19f1472d1aab2b235add4997897c95d37238bce640242263e110520b874` |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | 12,719 | `ca8b2761ef18082ab963d7a2039d155897ebddf18d96da6e7897fa49c027147d` |
| `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md` | 13,616 | `97f12351db8f0a1cd21011d02a6fba4f2f49c24560b5a4dad91e68cf69b13163` |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | 11,768 | `4f068598e6d76017d70841f70a89e0cfcc0435aae23e542e97c806fb76a00c18` |

For each complete map, decode the raw file bytes as UTF-8 without
normalization; require exactly one literal
`- Status: \`REVIEW_REQUIRED\`` line; replace only that line's content with
`- Status: <MAP_STATUS_CELL>` while preserving its existing line ending;
re-encode as UTF-8 without BOM; and calculate SHA-256.

| Map | Masked-file bytes | Masked-file SHA-256 |
| --- | ---: | --- |
| `docs/code_maps/lib/app/app.dart.md` | 11,674 | `1caaacfe36fcefb2b3af2242ce86ef954c65af0b2991594ee6b0325cb75c448c` |
| `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md` | 13,335 | `219da514317c6ad38f7648c379f8e4e2abe8b88aa1f4bec48a41664a49831ddd` |
| `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md` | 13,070 | `f0e434e376883232e288f8fbcef8c6a014e9bdc00dc7b5529c34e9e8003a68a8` |
| `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md` | 13,896 | `6569ca117b0355ef3a442279b0a466b0d38a3ec51e6e398471afd65c8dd99e00` |
| `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md` | 12,113 | `05d09c96b91038d784f2cb462a6885cd1528a5d245f261d7452114752f17db57` |

For each matching `CODE_MAP_INDEX.md` row, split the raw row on literal `|`,
replace segment index `4` with exactly ` <MAP_STATUS_CELL> ` including one
leading and one trailing space, rejoin on literal `|`, encode the resulting row
as raw UTF-8 without BOM or a trailing newline, and calculate SHA-256.

| Source row | Masked-row bytes | Masked-row SHA-256 |
| --- | ---: | --- |
| `lib/app/app.dart` | 94 | `14e6427105135ea75a26fbead51aa7412f1dcb8e99f00ee960941470be5e77b0` |
| `lib/features/home/screens/benchbeep_home_screen.dart` | 166 | `d994ed528322f6c90fcffe31dfd7f0eacb303cc53376a8ca8791fdf248ad507a` |
| `lib/features/project/screens/new_project_wizard_screen.dart` | 180 | `645c84b6246775d34ab5c99a52cc31a56edf9fe7a40511f79ee9e1b57730aae1` |
| `test/widget/benchbeep_home_screen_test.dart` | 142 | `8d71e1d37608c6c6262c5cff408bb799425e3f8c15d3588564eebf7602f32c0f` |
| `test/widget/new_project_wizard_screen_test.dart` | 150 | `076bf07bbfc16e0f6477e8a633eda7fe0b20ba869746ac6d776bbae507b35f75` |

## Bounded promotion contract

A clean independent map audit may authorize only:

- `REVIEW_REQUIRED` -> `MAINTAINED` on the five map `Status` header lines; and
- `REVIEW_REQUIRED` -> `MAINTAINED` in the five matching index Status cells.

Exact promotion maps:

- `docs/code_maps/lib/app/app.dart.md`
- `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`

Exact promotion index rows:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`

Any map-body correction must be separately identified by the auditor and remain
inside this pass's exact five map paths. No clean promotion changes a map body,
metadata field other than `Status`, unrelated index row, route owner, runtime,
test, or predecessor evidence surface.

## Scope final-evidence reconciliation

The predecessor consolidated scope received the human-attested result:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
```

Git verifies its exact nine-file safe set in pushed commit
`dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`
(`docs: map and lock Home-to-Wizard implementation scope`), parent
`bef91f2c851032b8234db94fb27e47ae3212adf2`.

The final verdict was missing from the predecessor artifact's designated block
before staging. The current reconciliation changes only that block's interior
and the matching ledger row's Status cell. It explicitly records the result as
post-push reconciliation and does not claim that the original recording order
occurred.

Freeze proof for the predecessor artifact:

- Prefix algorithm: raw UTF-8 bytes from byte zero through the newline that
  terminates the unique final-diff `BLOCK_BEGIN` marker; no BOM or newline
  normalization.
- Prefix: 18,370 bytes;
  SHA-256 `f5da008dfdb17339c33dc2cd63d70e77e9a96a52511db5058d5df19938544b11`.
- Suffix algorithm: raw UTF-8 bytes beginning with the first byte of the unique
  final-diff `BLOCK_END` marker through EOF; no normalization.
- Suffix: 667 bytes;
  SHA-256 `0acd9d484e58539eb79c12c505c6958cef2a7bd251e60688bb6b2c25fef471c6`.
- Ledger-row algorithm: take the unique raw predecessor row, split on literal
  `|`, replace segment index `3` with exactly ` <SCOPE_STATUS_CELL> ` including
  one leading and one trailing space, rejoin on literal `|`, encode as UTF-8
  without BOM or trailing newline, and calculate SHA-256.
- Masked ledger row: 1,252 bytes;
  SHA-256 `c67d388df80b02d1c77f58269a9d6ac72a429271d48f1fab60a5cfdec7f67889`.

All three values match before and after reconciliation.

## Route

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Next: NEEDS_USER_DECISION
```

No executable successor is armed. `Plaadi kontuur` is recorded only as a
possible future human decision with no PASS_ID, allowlist, route position, or
implementation authority.

## Validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS_VALIDATION_BEGIN -->

- `py -3 tools\validate_all.py`: exit `1`; project-state validation and both
  sample-event validations passed before the environment failure; unittest
  discovery ran `302` tests in `20.224s` and returned
  `FAILED (errors=158)`. The failures are permission denials for generated
  `.codex/known_facts*.json` files and Windows temporary test directories/files.
  An unrestricted rerun was requested and rejected because its generated
  writes would leave the exact twelve-file lock. No workaround was attempted,
  and this validator result is not called green.
- `git diff --check`: exit `0`; no whitespace errors. Git emitted only
  LF-to-CRLF working-copy warnings.
- `git diff --cached --check`: exit `0`; no output.
- `git diff --name-status`: exactly the eleven authorized tracked files; the
  new lock artifact is untracked and therefore not emitted by this command.
- `git diff --cached --name-status`: no paths.
- `git status --porcelain=v1 -uall`: the new lock artifact is the twelfth
  pass-owned path; pre-existing content-identical status-only paths and known
  untracked scratch remain outside the substantive set.
- Exact changed-set proof: `PASS`; the union of `git diff --name-only` and the
  exact untracked lock-artifact lookup equals the twelve-file write allowlist,
  with no missing or extra path.
- Implementation commit-set proof: `PASS`; `git diff-tree` returns exactly the
  five expected Dart/test paths, and the commit is contained by `origin/main`.
- Code-map structure proof: `PASS`; each of five maps contains every Standard
  section, exactly one `REVIEW_REQUIRED` header, and exactly one matching
  `REVIEW_REQUIRED` index row.
- Committed-source proof: `PASS`; all five worktree targets are content-identical
  to `HEAD`, and the recorded Git blob identities match.
- Map/body/index anchor proof: `PASS`; all published byte counts and SHA-256
  values reproduce after the complete map refresh.
- Route proof: `PASS`; `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and
  `docs/ACTIVE_SCOPE_LOCK.md` agree on this lock -> `NEEDS_USER_DECISION`.
- Ledger proof: `PASS`; exactly one lock ledger row exists.
- Scope-reconciliation freeze proof: `PASS`; the predecessor artifact prefix,
  suffix, and masked ledger-row anchors reproduce before and after the bounded
  two-location reconciliation.
- Runtime boundary proof: `PASS`; `git diff --name-only -- '*.dart'` returns no
  path, and no test, router, creator, persistence, package, asset, tool, or
  `_incoming` file is in the substantive diff.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS_VALIDATION_END -->

## Independent lock/map audit contract

The independent auditor compares all five complete maps and five index rows
against committed `HEAD`, verifies the predecessor reconciliation freeze,
checks the exact twelve-file diff and route/boundary evidence, and returns:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
MAP_BODY_FREEZE_RESULT: PASS / FAIL
MASKED_MAP_FREEZE_RESULT: PASS / FAIL
INDEX_ROW_FREEZE_RESULT: PASS / FAIL
PROMOTION_AUTHORIZATION: YES / NO
PROMOTION_MAPS: exact paths or NONE
PROMOTION_INDEX_ROWS: exact source rows or NONE
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: exact paths or NONE
IMPLEMENTATION_EVIDENCE_RESULT: PASS / FAIL
SCOPE_RECONCILIATION_RESULT: PASS / FAIL
ROUTE_RESULT: PASS / FAIL
BOUNDARY_RESULT: PASS / FAIL
LEDGER_RESULT: PASS / FAIL
SELF_REFERENCE_AUDIT: PASS / FAIL
PHASE_2_RECORDING_AUTHORIZATION: YES / NO
```

The returned lock/map verdict belongs only inside:

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

```text
MAP_VERDICT: ACCEPT_AS_IS
MAP_AUDIT_VERDICT: ACCEPT_AS_IS
PROMOTION_AUTHORIZATION: YES
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES
SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/app.dart.md
- docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md
- docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md
- docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md
- docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
LEDGER_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
FINDINGS: NONE
```

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS_VERDICT_BLOCK_END -->

Ledger mirror: the Status cell of the unique matching
`TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS` row in
`docs/AUDIT_INDEX.md`.

## SELF_REFERENCE_AUDIT

- The supplied implementation verdict is explicitly attributed to
  `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS`.
- The reconciled scope verdict is explicitly attributed to
  `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS`.
- No touched route, artifact, or ledger text asserts this lock pass's own
  current audit, staging, commit, or push lifecycle position.
- `REVIEW_REQUIRED` describes map lifecycle state only.
- Conditional promotion and verdict-destination policy are not claims that the
  current lock has already received those results.

`SELF_REFERENCE_AUDIT: PASS`
