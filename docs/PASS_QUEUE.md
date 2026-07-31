# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS`
Next: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS`

## Current correction SCOPE queue

The human supersedes only the accepted Step-4 placement of
`Foto ja joondamine`. This docs-only correction freezes the in-progress
four-file implementation and preserves the existing EHITUS identity and
allowlist.

Verified entry is branch `main`,
`HEAD == origin/main == 0a585156de6d2f6b0eb2b9ae04db28811148f854`,
divergence `0 0`, empty staged set, and exactly four material implementation
paths. The correction changes only the four route/ledger owners plus
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS.md`.

## Frozen carryover and reserved EHITUS

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact unchanged implementation allowlist and frozen carryover:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is queued. The four exact worktree/blob identity
pairs are recorded in `docs/ACTIVE_SCOPE_LOCK.md` and the correction artifact;
they may change only after this correction is accepted and pushed and the same
EHITUS pass resumes.

## Revised implementation queue

The queued order is now:

```text
1 Projekti andmed
2 Foto ja joondamine
3 Plaadi kontuur
4 Komponentide asetus
5 Probleemi kirjeldus
6 Kontroll ja kinnitus
7 Kokkuvõte
```

Step 2 is optional, ungated, and visited-only `Vaadatud`; it owns selection
and editable photo transform/opacity and contains no contour/component guide
overlay. Step 3 renders the same photo as an inert background under editable
contour points. Step 4 renders the same photo plus fixed contour guide under
editable candidates. No photo is a valid state for both editors. Photo state
persists through Steps 2-4 and resize, while later photo mutation never moves
contour points or candidate identities/positions.

All numbering is length-derived. The Step 3 contour gate and `Valmis`, Step 4
optional `Vaadatud`, picker/filter/cancel/error behavior, default `65%`
opacity, `0%` hidden-with-draft-retained state, `100%`, reset preserving
opacity, replacement, separate full removal, parent-owned state, dirty
mutations, native-desktop platform boundary, wide/compact interaction, and
`UI_LOCAL` + `ZERO_WRITE` limits remain queued unchanged. No canonical
coordinate conversion is introduced.

Focused tests must be reordered for the exact catalogue, progress and
navigation; prove the photo-only Step 2 editor; prove the read-only photo
background in Step 3 and photo-plus-contour guides in Step 4; prove no-photo
operation; prove unchanged contour/candidate positions across later photo
changes; and preserve all accepted photo/contour/component and zero-write
coverage.

## Sequencing and map lifecycle

```text
TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_FIRST_ORDER_SCOPE_PASS
-> TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
-> one later unnamed LOCK
-> NEEDS_USER_DECISION
```

The existing Wizard maps remain committed-HEAD `MAINTAINED` records but the
material implementation disposition is `UPDATE_REQUIRED`. The two new files
are qualified only in the later LOCK from accepted committed source. No map
edit or separate map pass is queued during EHITUS.

Stop on any change to the four implementation blobs during this correction,
a fifth implementation file, canonical coordinate conversion, contour or
candidate motion coupled to photo mutation, unsupported platform/persistence
promise, map edit during EHITUS, unrelated cleanup, or protected-surface
expansion.

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
