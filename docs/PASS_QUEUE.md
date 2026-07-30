# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS`
Next: `NEEDS_USER_DECISION`

## Current LOCK queue

The accepted and pushed Step 3 component-placement implementation is being
closed by one docs/map LOCK:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Implementation identity:

- commit:
  `d83e27e291eb31447f9539d1d3b7443648e67355`
  (`feat: add Wizard component placement editor`);
- parent:
  `3e27cdbcdcada20ef4afb3eff69f36097a15937a`;
- exact committed set:
  `lib/features/project/screens/new_project_wizard_screen.dart` and
  `test/widget/new_project_wizard_screen_test.dart`.

Exact LOCK authority:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS.md`

No ninth file is authorized. The source, test, component-placement scope
artifact, third maps, and all unrelated docs are inspect-only.

## Accepted evidence and map state

Human manual smoke is `8/8 PASS`. The temporary implementation audit returned
`ACCEPT_AS_IS` with `SAFE_FOR_STAGING: YES` from a
`FRESH_CONTEXT_SAME_TOOL`. It was expressly not equivalent to a Claude-
independent audit, applied only while Claude was unavailable, and changed no
permanent policy or boundary.

Accepted validation is focused `34/34`, full `456/456`, serial full `456/456`,
validator `302/302`, targeted analysis `PASS`, exact formatting `PASS`, and
diff checks `PASS`.

Both target map bodies now describe the committed candidate key/position
model, read-only guide, add/select/drag/clamp/delete flows, Step 4 retention,
dirty assignments, optional/ungated `Vaadatud` semantics, responsive
pointer/scroll behavior, focused coverage, and `UI_LOCAL` + `ZERO_WRITE`
boundaries. Their headers and two exact index rows remain `REVIEW_REQUIRED`
until the bounded final audit.

## Sequencing

```text
TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

The final audit belongs to this LOCK and may only promote the two map headers
and two exact index rows to `MAINTAINED`, fill the artifact's existing verdict
block, and mirror that result into the matching ledger `Status` cell. It may
not alter either map body, any other index/ledger cell, the route, or a ninth
file. No extra closeout or map pass is inserted.

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. It changes no Add
Component, Board Canvas, provider, creator/project-state, persistence,
event/fact/projection, schema/writer/materializer, ZIP, AI/OCR/CV/photo,
router, Home, app, package, asset, tool, or `_incoming` behavior.

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
