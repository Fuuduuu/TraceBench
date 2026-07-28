# Active Scope Lock

## Route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS`
Next: `NEEDS_USER_DECISION`

## Human lock and closeout authority

The human product/scope owner names this one post-build docs/map lock after the
accepted, committed, and pushed Home-to-Wizard implementation. It updates maps
from committed source, records supplied implementation evidence, performs the
bounded scope-evidence reconciliation, and releases the next pointer to the
non-executable `NEEDS_USER_DECISION` sentinel.

This authority changes no Dart or test file and creates no runtime,
implementation, contour, persistence, or protected-surface authority.

## Current docs/map authority

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Exact current write allowlist:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/app/app.dart.md`
- `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

No thirteenth file is authorized.

The authority baseline is committed and pushed `HEAD == origin/main ==
ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa` with subject
`feat: activate Home-to-Wizard flow`. Its parent is
`dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`, and the implementation commit
contains exactly:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`

All five materially changed after their prior maintained maps. This pass
updates each deterministic map from `git show HEAD:<source>` and changes only
the five matching index Status cells to `REVIEW_REQUIRED`. Map bodies describe
the accepted committed behavior:

- Home exposes and threads `onCreateProject`;
- `Loo projekt nullist` is enabled without `Tulekul`;
- `TraceBenchApp` opens
  `_openWorkbench(initialLocation: '/new-project')`;
- the six-step Wizard remains widget-local and zero-write;
- only completed Step 1 is `Valmis`; visited prior placeholder Steps 2–5 are
  `Vaadatud`, while Step 6 remains current when reached and is never `Valmis`;
- folder selection creates no folder or file and final creation is not
  implemented;
- draft retention, bounded navigation, mobile picker safety, and dirty-draft
  cancellation remain active;
- Step 6 exposes no final create action; and
- eighteen Home tests plus eighteen Wizard tests cover the accepted flow and
  boundaries.

The bounded map lifecycle is:

```text
update five map bodies and five index rows to REVIEW_REQUIRED
-> independent map-to-code audit
-> apply only audit-authorized corrections
-> promote exactly the five map headers and five index Status cells to
   MAINTAINED only after a clean returned map audit
-> record the returned lock verdict in the designated artifact block and
   matching ledger Status cell
-> exact human staging
```

## Accepted implementation and supplied audit evidence

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact committed and pushed implementation set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Git proves no sixth file in commit
`ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`. The human-supplied independent
implementation audit returned:

```text
AUDIT_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_STAGING: YES
```

Both returned findings were classified non-blocking. Their verbatim wording is
not present in the repository or current authority handoff, so this record
preserves two distinct NITs by count and classification without inventing
their wording or remediation. The accepted safe staging set and the pushed
commit are exactly the five paths above.

## Scope-evidence reconciliation boundary

The predecessor consolidated scope received
`AUDIT_VERDICT: ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`, then was committed
and pushed as `dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`
(`docs: map and lock Home-to-Wizard implementation scope`) with exactly its
nine authorized docs/map files.

Its final-verdict recording was omitted before that push. This pass records the
supplied result retrospectively only inside:

- the empty final-diff verdict block in
  `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`;
  and
- the Status cell of that pass's existing `docs/AUDIT_INDEX.md` row.

The reconciliation explicitly does not claim that the required pre-staging
recording order occurred. No other byte of the historical artifact or
description cell is authorized to move.

## Route release and possible future decision

The live route is:

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Next: NEEDS_USER_DECISION
```

No successor implementation or docs pass is armed, reserved, or scheduled.
`Plaadi kontuur` is recorded only as one possible future human product
decision. It has no PASS_ID, allowlist, implementation authority, or route
position.

The existing `/new-project` route remains unchanged. Router, persistence,
`ProjectCreator`, project-state assignment from the create action, canonical
writes, schemas, packages, assets, tools, `_incoming`, and unrelated Home
actions remain outside this docs/map lock.

## Live exclusions and stops

The current lock creates no runtime, test, router, persistence,
`ProjectCreator`, project-state, filesystem, event, fact, schema, writer,
materializer, projection, Project ZIP, asset, package, `_incoming`, tool, or
protected-surface write authority. Its maps are descriptive and
non-authorizing.

Stop if the current lock needs a thirteenth file; a Dart or test edit is
required; any target ceases to qualify or cannot be proven from committed
source; the implementation commit differs from its exact five-file audited
set; scope reconciliation requires any byte outside the designated block and
Status cell; any route owner disagrees; or any router, creator, persistence,
package, asset, tool, `_incoming`, or protected-surface edit becomes necessary.

## Superseded original lock (historical scope evidence)

The subsections below preserve the original two-file foundation reservation as
historical scope evidence. Later scope and implementation work superseded and
completed it; none of the following subsection text is current write
authority.

### Authority transition

Baseline `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e` contains the exact pushed
result of `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`. Its seven-file authority
is spent and retained only in Git and existing evidence.

The human's 2026-07-27 decision selected the BenchBeep
`Loo projekt nullist` redesign from the non-executable
`NEEDS_USER_DECISION` pointer. It authorizes only this docs-only scope lock.
No prior allowlist or product authority is inherited.

### Exact current write allowlist

`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` may write exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS.md`

No sixth file is authorized.

### Reserved implementation pass

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are authorized.
Future authority is conditional on independent acceptance and human push of
this exact five-file scope lock.

### Current behavior being temporarily replaced

The live Wizard has a working create flow. Its `wizard-create` CTA calls
`ProjectCreator.createProject`. A
`ProjectCreationSuccess` assigns the returned state to `projectStateProvider`
and navigates to `/project`; typed creation failures are presented to the user.
The focused Wizard widget suite covers the create CTA, destination
precondition, successful state/routing path, selected typed failures, and the
mobile picker gate.

The future pass intentionally replaces that working UI with a temporary,
non-creating Wizard foundation. `lib/app/router.dart` and both Home surfaces
remain unchanged. Reintroducing final creation integration, including a
functional final create CTA and service handoff, requires a later separate
human route decision and is not authorized or reserved here.

### Locked implementation behavior

The future pass may implement only:

- a six-step Wizard shell based on the exact inspect-only design handoff;
- Step 1 fields for `Projekti nimi`, `Seadme nimetus`,
  `Salvestuskoht`, and `Lisainfo`;
- widget-local draft state for all four values;
- parent-folder selection that stores only the returned path;
- `Edasi` enabled only when the project name is nonblank and a parent path is
  present;
- visible but non-functional Steps 2–6;
- forward/back navigation that preserves the draft; and
- dirty-draft cancel confirmation, while an untouched draft may return
  directly Home.

The implementation must preserve the existing BenchBeep identity and use only
existing theme, icon, and asset solutions. User-visible copy is Estonian and
state must not be communicated by color alone.

### Step 1 deliberate design exception

The zero-write boundary deliberately narrows the inspect-only design handoff:

- show no derived child-folder name preview;
- do not check or claim that the selected parent is writable;
- retain the selected parent path only in widget-local draft state;
- enable `Edasi` only when the project name is nonblank and a parent path has
  been selected;
- create no directory or file; and
- provide no collision or writability guarantee.

The selected parent path itself may be displayed as draft input. It must not be
presented as a validated final project path. This is an explicit design
exception required by the temporary foundation's `UI_LOCAL`/`ZERO_WRITE`
scope; canonical repo boundaries outrank the handoff.

### Zero-write boundary

The future pass must not:

- call `ProjectCreator.createProject`;
- assign a created project to application state or navigate to a created
  project;
- create or modify a directory, file, manifest, `events.jsonl`,
  `known_facts.json`, event, fact, projection, outline, marker, component, or
  Project ZIP artifact;
- derive or display a child-folder preview, check or claim writability, or
  promise collision-free or writable creation;
- define or change project-name persistence, project-directory naming,
  collision, overwrite, or final creation behavior;
- implement a final create CTA or functional Step 2–6 workflow; or
- add or change an asset, font, package, dependency, schema, writer,
  materializer, router, Home screen, or adjacent runtime file.

`lib/shared/services/project_creator.dart` and its persistence paths remain
inspect-only.

### Code-map and design-input boundary

This docs-only pass has `CODE_MAP_DISPOSITION: NOT_APPLICABLE`. The maintained
Wizard source and widget-test maps are read-only planning aids for the future
two-file slice; they grant no authority and are not updated here.

For `TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS`, the human explicitly
authorizes one bounded combination of the responsibility zones named by those
two maps, only as needed to replace the current create form with the locked
UI-local foundation:

- source-map zones: creator provider and injection seams; form and transient
  state lifecycle; platform capability gate; directory selection; creation
  request and submission; success projection and routing; failure and
  capability feedback; rendering and interaction locking;
- test-map zones: platform seam; creator seam and request capture; picker seam;
  in-memory project fixture; isolated widget/router harness; destination
  precondition; success request and routing; failure presentation; mobile
  picker gate.

This explicit multi-zone decision is bounded to the two future allowlist files
and `UI_LOCAL`/`ZERO_WRITE` behavior. It authorizes no change to
`ProjectCreator`, persistence, writers, schemas, materializers, Home, router,
or any other file. The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After that implementation is accepted and committed, map maintenance must
occur against the accepted committed source in a separate docs-only lock/map
pass. This pass neither starts nor names that later pass.

The exact design input is:

`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`

It is high-fidelity external visual/product input only, not route, runtime
truth, schema, acceptance evidence, or write authority. Its HTML, CSS,
JavaScript, SVG, PNG, fonts, and other bytes must not be copied, imported,
modified, staged, packaged, or referenced by runtime code. Canonical repo
owners and runtime contracts outrank it.

### Forbidden current surfaces

The current pass may not change Dart, Flutter, tests, code maps, schemas,
tools, assets, packages, writers, materializers, ZIP behavior, runtime files,
`_incoming`, `AGENTS.md`, `docs/POHIKIRI.md`, task-specific specs, archive
evidence, or `.agents/skills/**`.

No board-outline, marker, component, canonical-event, creator-persistence,
AI/OCR/photo/template/phone, Board Canvas redesign, or later Wizard authority
is reserved.

### Verdict recording and exact staging

For this artifact-bearing pass, preserve:

```text
independent audit
-> record returned verdict in the designated block and ledger Status cell
-> prove the bounded recording freeze
-> exact human staging
```

Staging, commit, and push remain human-owned. Broad staging commands are
forbidden.

### Stops

Stop if any sixth current file or third implementation file is required; if
the two-file slice cannot remain `UI_LOCAL`/`ZERO_WRITE`; if the design
handoff is missing or ambiguous; if any `ProjectCreator`, filesystem,
application-project-state, persistence, event, projection, schema, writer,
materializer, asset, package, router, Home, code-map, or `_incoming` change is
needed; if project-name storage or directory naming must be decided; if
validation exposes a scope-relevant failure; or if any protected decision
cannot remain deferred.
