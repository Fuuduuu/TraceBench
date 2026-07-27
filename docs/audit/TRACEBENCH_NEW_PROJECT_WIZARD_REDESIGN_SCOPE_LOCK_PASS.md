# TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS

PASS_ID: `TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS`

Lane: `A`

Mode: `DOCS_SYNC`

Profile: `SCOPE_LOCK / DOCS_ONLY`

## Human route decision

On 2026-07-27 the human selected the BenchBeep
`Loo projekt nullist` redesign from the non-executable
`NEEDS_USER_DECISION` pointer. This decision replaces the spent
`TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS` route with:

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
```

No separate closeout, release, pointer-reset, code-map, or additional child
pass is created.

## Verified baseline

- repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- remote: `origin` -> `https://github.com/Fuuduuu/TraceBench.git`
- branch: `main`
- `HEAD` and `origin/main`:
  `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e`
- divergence: `0 0`
- baseline subject: `docs: repair archive attestation and evidence ownership`
- tracked diff: empty
- cached diff: empty
- starting route:
  `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS` ->
  `NEEDS_USER_DECISION`
- status-only tracked paths were verified content-identical to their
  corresponding `HEAD` blobs with `git hash-object -- <path>` and
  `git rev-parse HEAD:<path>`; none was edited
- existing untracked/scratch paths and four stashes were retained

The baseline commit contains the exact seven-file evidence-integrity repair
result. Its former authority is spent.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: the three loader-qualified repo skills in
  `.agents/skills/**`, `docs/CODEX_TOOLING_POLICY.md`, Git, maintained Wizard
  maps, and `tools/validate_all.py`
- capability actually used: `tracebench-scope-lock`
- why applicable: the immediate work is a docs-only future-pass route and
  exact-allowlist reservation with runtime and protected surfaces excluded
- external tool required: `NO`

No plugin, MCP write, internet access, install, download, dependency change,
or external integration is used.

## CODE_MAP_PREFLIGHT

Applicability for this docs-only pass:
`CODE_MAP_DISPOSITION: NOT_APPLICABLE`.

The following `MAINTAINED` maps were read only to bound the future
implementation slice:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`

The mapped Dart source, focused widget test, and
`lib/shared/services/project_creator.dart` were inspected. No source
responsibility zone and no code map changes in this pass.

For the reserved future implementation, the human explicitly authorizes a
bounded multi-zone combination because replacing the current create form with
the temporary foundation necessarily changes responsibilities described
across both maintained maps:

- production zones: creator provider and injection seams; form and transient
  state lifecycle; platform capability gate; directory selection; creation
  request and submission; success projection and routing; failure and
  capability feedback; rendering and interaction locking;
- test zones: platform seam; creator seam and request capture; picker seam;
  in-memory project fixture; isolated widget/router harness; destination
  precondition; success request and routing; failure presentation; mobile
  picker gate.

The combination is authorized only inside:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

The expected blast radius is the replacement of current create-flow UI,
transient state, interactions, and focused widget coverage inside those two
files. `ProjectCreator`, its writer/materializer/persistence paths,
`projectStateProvider`, Home, and router are inspect-only coupled zones; no
writer, schema, materializer, persistence, Home, router, or third-file change
is authorized. The future write class is `UI_LOCAL`/`ZERO_WRITE`.

The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After the implementation is independently accepted and committed, the maps
must be maintained against accepted committed source in a separate docs-only
lock/map pass. No such pass is started or named here.

## Source intake

Exact source:

`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`

The required `README.md` and editable design-handoff HTML are present and were
read as high-fidelity external visual/product input. The source is not route,
runtime truth, schema, acceptance evidence, or write authority. It must not be
copied, imported, modified, staged, packaged, or referenced by runtime code.
Existing repo theme, icons, assets, source, tests, and canonical owners
outrank it.

## Exact scope-lock diff

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS.md`

No sixth file is authorized.

## Locked implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are reserved.
Activation is conditional on independent acceptance and human push of this
exact five-file scope lock.

## Existing create flow being replaced

The current Wizard is functional:

- its `wizard-create` CTA enters `_createProject`;
- `_createProject` calls `ProjectCreator.createProject`;
- `ProjectCreationSuccess` assigns the returned state to
  `projectStateProvider` and navigates to `/project`;
- typed creation failures are displayed to the user; and
- `test/widget/new_project_wizard_screen_test.dart` covers the create CTA,
  destination precondition, successful provider/navigation path, selected
  typed failures, and the mobile picker gate.

The reserved implementation intentionally replaces this working UI with a
temporary non-creating foundation. Both Home surfaces and
`lib/app/router.dart` remain unchanged. Final creation integration requires a
later separate human route decision and is outside this scope lock.

The future pass is limited to a six-step shell, Step 1 project-name/device/
parent-folder/additional-information draft UI, widget-local state,
name-plus-parent gating for `Edasi`, visible non-functional Steps 2–6,
draft-preserving navigation, and dirty-draft cancel confirmation.

## Step 1 deliberate design exception

For this temporary foundation:

- no derived child-folder name preview is shown;
- parent writability is neither checked nor claimed;
- the selected parent path remains only widget-local draft state;
- `Edasi` requires only a nonblank project name and a selected parent path;
- no directory or file is created; and
- no collision or writability guarantee is given.

The selected parent path may be displayed only as unvalidated draft input.
This is a deliberate deviation from the inspect-only design handoff, required
by the scope lock's zero-write boundary.

## Excluded persistence and protected surfaces

The future implementation must not call `ProjectCreator.createProject` or
create/modify a directory, file, manifest, event, fact, projection, outline,
marker, component, `events.jsonl`, `known_facts.json`, or Project ZIP
artifact. It must not derive a child-folder preview; check or claim
writability; promise collision-free creation; or define or change project-name
persistence, directory naming, collision, overwrite, or final creation
behavior.

No asset, font, dependency, package, schema, writer, materializer, router,
Home, code-map, `_incoming`, AI/OCR/photo/template/phone, Board Canvas
redesign, or adjacent runtime change is authorized.

## Validation evidence

- `git diff --check`: exit `0`
- `git diff --cached --check`: exit `0`
- `py -3 tools\validate_all.py`: exit `1`; this correction's fresh run
  discovered `302` tests (`Ran 302 tests in 20.161s`) and ended with `158`
  errors after `PermissionError` failures writing under repository `.codex`
  and Windows temporary directories in the managed sandbox
- no unsandboxed rerun or workaround was performed because the required writes
  exceed this pass's exact five-file authority
- validator result: environment-blocked and not green; no touched-doc
  validation finding was emitted before the permission failure
- `git diff --name-status`: exit `0`; exactly the four modified tracked
  route/ledger files
- scoped untracked artifact check: exactly this artifact; combined changed set
  equals the five-file allowlist path-by-path
- `git diff --cached --name-status`: exit `0`; empty
- `git status --porcelain=v1`: exit `0`; authorized changes plus the unchanged
  pre-existing status-only and scratch inventory
- all five unrelated tracked status-only paths remain blob-identical to
  `HEAD`; the 102-path foreign untracked inventory and four-entry stash list
  remain unchanged
- all three route owners record the same
  `TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` tuple
- Flutter tests were not run because this pass changes documentation only

## Independent verdict recording

Designated empty block:
`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS_VERDICT_BLOCK`.

Ledger mirror:
the `Status` cell of the
`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` row in
`docs/AUDIT_INDEX.md`.

The only post-audit content changes permitted before exact human staging are
the returned canonical verdict in this block and its mechanical mirror in that
one ledger Status cell. The changed-file set must remain the same and the
bounded freeze must prove that no other byte moved.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->

## SELF_REFERENCE_AUDIT

- the artifact, ledger row, and three route owners use time-invariant scope,
  authority, baseline, and workflow language
- no touched file asserts this pass's own staging or audit-pipeline position
- generic audit/staging rules are distinguished from claims about this pass
