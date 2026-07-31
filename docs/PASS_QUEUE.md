# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS`
Next: `NEEDS_USER_DECISION`

## Current LOCK queue

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Committed implementation authority is
`7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`, parent
`9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, with exact source/test set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

Human manual smoke is `PASS`. The attributed Claude implementation audit is
`ACCEPT_WITH_NITS` and safe for the exact implementation set, with order,
layering, ownership, boundary, and validation all `PASS`. Recorded validation
is focused `50/50`, full Flutter `472/472`, validator `302/302`, targeted
analysis `PASS`, and diff checks `PASS`.

## Map lifecycle

The accepted implementation made the two existing Wizard maps
`UPDATE_REQUIRED`; this LOCK refreshes them from committed `HEAD`. Both new
files qualify:

- photo editor production: `AUTO — 5+ independently testable behaviors`;
- photo editor focused test: `SCORE 7/12 — multi-family photo-layer/transform/gesture/responsive boundary coverage`.

The current registry contains all four actual maps. Every changed/new map
header and matching registry Status cell is `REVIEW_REQUIRED`.

The exact current docs/map authority is:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/lib/features/project/widgets/new_project_wizard_photo_editor.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_photo_editor_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS.md`

No eleventh file is queued.

## Bounded final audit and release

A clean final comparison is bounded to:

- verifying this exact LOCK diff against committed source, supplied
  implementation/manual-smoke evidence, and the four qualification results;
- promoting only the four map headers and four matching index rows from
  `REVIEW_REQUIRED` to `MAINTAINED`;
- filling only the designated verdict-block interior; and
- mechanically mirroring that returned result into the matching ledger Status
  cell.

It may not change map bodies, another metadata field, another registry row,
the ledger Description cell, route prose, source, tests, scope artifacts, or
any other content. No extra pass is created.

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
-> NEEDS_USER_DECISION
```

`NEEDS_USER_DECISION` is non-executable. There is no reserved successor or
runtime allowlist.

The cycle remains `UI_LOCAL` + `ZERO_WRITE`. No source copy, project photo,
canonical alignment/coordinate, provider, project state, event, fact,
projection, writer, materializer, AI/OCR/CV, router, Board Canvas, ZIP,
package, asset, tool, or protected-surface work is queued.

## Superseded accepted Step-4 queue (historical)

The following accepted queue text remains as immutable history for compatible
non-ordering decisions. Its Step-4 placement, Step 3/4/5 retention wording,
and photo-editor guide overlay are superseded by the current queue above.

### Current SCOPE queue

The human selected optional Wizard Step 4 `Foto ja joondamine v1` and fixed:

```text
SCOPE -> EHITUS -> LOCK
```

The current docs-only pass changes exactly the four route/ledger owners plus
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`.
No Dart, test, map, or map-index file changes during SCOPE.

Verified entry is branch `main`,
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`,
divergence `0 0`, empty staged/substantive diffs, released route
`NEEDS_USER_DECISION`, accepted predecessor ledger evidence, and maintained
Wizard maps.

### Reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact implementation allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

The pass adds one optional native-desktop photo-view step, shifts placeholders
to Steps 5–7, derives numbering from `_wizardSteps.length`, keeps Step 4
ungated/`Vaadatud`, retains parent-owned path/transform state, renders the
photo below fixed read-only guides, provides translate/zoom/rotate plus
a visible `0–100%` opacity slider defaulting to `65%`, `Nulli vaade`,
replace, and separate `Eemalda foto`, preserves cancel/navigation/resize
state, handles render failure honestly, marks all locked mutations dirty, and
stays operable at 1440x900 and 390x760. Opacity is clamped to `0.0..1.0`;
`0%` hides only the image layer, retains the draft and fixed guides, and shows
`Foto peidetud`, while `100%` is fully visible. Reset changes only
translation, scale, and rotation and preserves opacity; remove clears the
complete photo draft.

It is `UI_LOCAL` + `ZERO_WRITE`. No source mutation, project photo copy,
canonical alignment/coordinates, fact/event, reference solver, provider,
creator/project state, filesystem write, AI/OCR/CV, router, Board Canvas,
existing project-photo workflow, schema, materializer, package, asset, ZIP,
or protected surface is queued.

### Sequencing and map lifecycle

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

There is no prerequisite or separate map pass. Existing Wizard maps remain
`MAINTAINED` during EHITUS and have final disposition `UPDATE_REQUIRED`. The
two new files are qualified in the later LOCK from accepted committed source;
no map is pre-created. Manual smoke precedes the final implementation audit.

Stop on a fifth implementation file, a map edit during EHITUS, unsupported
mobile/web promise, parent-state violation, persistent/canonical path,
unrelated cleanup, or protected-surface expansion.

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
