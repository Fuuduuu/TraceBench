# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS`
Next: `NEEDS_USER_DECISION`

## Live lock queue

The accepted Home-to-Wizard implementation is committed and pushed. One exact
docs/map lock owns the map refresh, supplied implementation evidence, bounded
scope-evidence reconciliation, and route release:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Current write allowlist:

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

No thirteenth current-pass file is authorized. No Dart or test edit is
authorized.

All five affected maps and registry rows are `REVIEW_REQUIRED`. Their bodies
record only committed `HEAD`
`ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`: active Home create navigation,
the existing `/new-project` Wizard, honest six-step placeholder progress,
draft/cancellation behavior, responsive tests, and the zero-write boundary.
Independent map-to-code audit gates mechanical promotion of exactly those five
map headers and five index cells to `MAINTAINED`.

## Accepted implementation and route release

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Committed and pushed as
`ec2b82da1c112eaba12e4ae38ee323f8cd27d2fa`
(`feat: activate Home-to-Wizard flow`) with exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

The human-supplied independent audit returned
`AUDIT_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_STAGING: YES`. Both findings
were non-blocking; their verbatim wording was not supplied, so this queue
preserves their count/classification without inventing text.

The preceding nine-file scope result was independently
`ACCEPT_AS_IS / SAFE_FOR_STAGING: YES` and pushed as
`dbf0268001afd17ff5eee39bacf7ac82b97ee7d0`. Its omitted final-verdict record is
reconciled post-push only at the two designated evidence locations and does not
claim the original required recording order occurred.

After this lock, the executable queue is empty:

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS
Next: NEEDS_USER_DECISION
```

No successor PASS_ID or allowlist is armed. `Plaadi kontuur` is recorded only
as a possible future human decision, not a scheduled or authorized pass.

## Superseded direct foundation reservation (historical)

Every subsection below through `### Sequencing` preserves the original
two-file foundation lock as historical scope evidence. Later scope and
implementation work superseded and completed it; none of it is queued now.

### Current scope lock

The human selected the BenchBeep `Loo projekt nullist` redesign from the
non-executable `NEEDS_USER_DECISION` pointer. This pass owns only the exact
five-file docs set in `docs/ACTIVE_SCOPE_LOCK.md` and reserves one future pass:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file and no additional child pass are reserved.

### Future implementation slice

The future pass may implement only:

- a six-step Wizard shell based on the inspect-only design handoff;
- Step 1 fields for project name, device name, parent folder, and additional
  information;
- widget-local draft state;
- no derived child-folder preview and no writability check or claim;
- the selected parent path retained only as widget-local draft state;
- `Edasi` enabled only when the project name is nonblank and a parent path has
  been selected;
- no directory/file creation and no collision or writability guarantee;
- visible, non-functional Steps 2–6;
- step navigation that preserves the draft; and
- dirty-draft cancel confirmation.

This Step 1 treatment is a deliberate zero-write exception to the design
handoff. The live Wizard currently has a working create CTA that calls
`ProjectCreator.createProject`; success assigns `projectStateProvider` and
navigates to `/project`; typed failures are shown; and focused widget tests
cover the create flow. The future pass intentionally replaces that UI with the
temporary non-creating foundation. It must not call the creator, create a
project or persistent state, define or change project-name persistence or
directory naming, or change assets, dependencies, fonts, schemas, writers,
materializers, Project ZIP, canonical events, board outlines, markers,
components, Home, router, or adjacent runtime files. Final creation integration
requires a later separate route decision and is not authorized here.

### Human multi-zone decision and map disposition

The human explicitly authorizes
`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` to combine the responsibility
zones named by the maintained Wizard source and widget-test maps only as
required for this locked two-file `UI_LOCAL`/`ZERO_WRITE` foundation. No
`ProjectCreator`, persistence, writer, schema, materializer, Home, router, or
third-file change is authorized.

The future implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted committed implementation, the affected maps must be maintained
against that committed source in a separate docs-only lock/map pass. That
later work is not started, named, armed, or scheduled here.

### Sequencing

The future implementation authority is conditional on independent acceptance
and human push of this exact five-file lock. The implementation then routes
Codex to manual smoke, independent Claude audit, verdict recording, and exact
human staging under the repository contracts.

No closeout, release, pointer-reset, persistence, final-creation, or later
Wizard integration pass is reserved here. Any additional product decision
returns to `NEEDS_USER_DECISION`.

## Known unarmed work (unchanged)

Known unarmed work, recorded here so it stops living only in chat. None of it
is armed, reserved, or scheduled by this pass:

- **line-ending normalization.** Add `.gitattributes` and normalize. Verified
  content no-op for existing text blobs: `git grep -I -l -P '\r' HEAD` returns
  `0` of the `864` tracked text blobs; the other `11` of `875` tracked files
  are binary PNG assets excluded by that scan. Deferred on severity, not
  interference.
- **routing completeness.** Top-level `docs/*.md` files absent from
  `docs/FILE_MAP.md`, plus the missing `code_maps` and skills layers in
  `docs/MEMORY_REGISTRY.yml`. Three separate counts of the unrouted set have
  been reported. That pass must establish the number with a stated method and
  publish the method with the number; no earlier count may be inherited.
- **code-map coverage.** Unmapped Dart screens that may satisfy automatic
  qualification under `docs/code_maps/CODE_MAP_STANDARD.md`.

These three entries remain independent of the Wizard route. This scope lock
assigns them no PASS_ID, owner, schedule, or executable authority.
