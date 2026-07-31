# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

## Live photo-alignment-v1 LOCK

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry is branch `main` with
`HEAD == origin/main == 7f9ca14d1b4227113a665a6b5e4242eeb9f7a8ea`,
parent `9fd8dd31e1541d41878daf5c9618a86a37ca39fb`, subject
`feat: add photo-first Wizard alignment flow`, divergence `0 0`, empty
staged and substantive tracked diffs, and the exact committed implementation
set:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

The human-supplied manual-smoke result is `PASS`. The supplied Claude
implementation audit returned `ACCEPT_WITH_NITS`,
`SAFE_FOR_STAGING: YES`, and `PASS` for order, layering, ownership,
boundary, and validation. Attributed validation is focused tests `50/50`,
full Flutter tests `472/472`, validator `302/302`, targeted analysis
`PASS`, and diff checks `PASS`.

The durable implementation findings remain:

- `LOW`: hardcoded visible ordinals have limited regression coverage;
- `LOW`: three smoke items relied on the global `PASS` plus automated
  coverage;
- `NIT`: obsolete guide-absence keys;
- `NIT`: the label test checks membership rather than exact order; and
- `NIT`: 28 pre-existing analyzer issues are outside the implementation
  allowlist.

## Current docs/map authority

This LOCK changes only:

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

No eleventh file is authorized. Dart, tests, accepted scope artifacts, runtime,
project state, persistence, canonical surfaces, router, Board Canvas, packages,
assets, tools, and scratch remain outside authority.

## Map qualification and route

The existing Wizard screen and integration-test maps are refreshed from
committed `HEAD`. The new photo editor qualifies automatically through five
or more independently testable behaviors. Its seven-test focused suite
qualifies at `SCORE 7/12` through multi-family photo-layer, transform,
gesture, responsive, and zero-write coverage.

All four map headers and matching index rows are `REVIEW_REQUIRED`. A clean
final comparison may change only those eight status locations, the designated
verdict-block interior, and the matching ledger Status cell; it may not change
a map body, route owner, description cell, runtime/test file, or any other
content.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_LOCK_PASS
Next: NEEDS_USER_DECISION
```

The route returns to the non-executable decision sentinel. No successor or
extra pass is armed.

The committed implementation and this LOCK remain `UI_LOCAL` +
`ZERO_WRITE`: photo path/transform/opacity, contour, and candidates stay
Wizard-local; no file copy, canonical photo/alignment, provider, project-state,
event, fact, projection, writer, materializer, AI/OCR/CV, ZIP, router, or
protected-surface authority exists.

## Superseded accepted Step-4 photo scope (historical)

The accepted prior photo scope remains immutable and supplies all compatible
non-ordering constraints. Its Step-4 placement, Step 3/4/5 navigation wording,
and guide overlays inside the photo editor are superseded. The following
level-three sections are retained historical evidence.

### Live photo-alignment-v1 scope

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

At entry, branch `main` has
`HEAD == origin/main == 4dcec544acd0fbcee416c219cef1a10f52a4280f`
(`docs: lock Wizard component placement v1`), divergence `0 0`, no staged
paths, and no substantive worktree diff. Pre-existing tracked porcelain
entries are content-identical to `HEAD`; known scratch remains outside
authority.

The predecessor component-placement LOCK is accepted and pushed, its final
ledger record is accepted, and both Wizard maps plus their index rows are
`MAINTAINED`. Its route released to `NEEDS_USER_DECISION`; this human decision
opens a fresh authority rather than extending the spent LOCK.

This SCOPE pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS.md`

No Dart, test, map, map-index, package, asset, schema, tool, or `_incoming`
file changes now.

### Reserved implementation

`TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS` is reserved with
exactly four implementation files:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/features/project/widgets/new_project_wizard_photo_editor.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/widget/new_project_wizard_photo_editor_test.dart`

No fifth implementation file is authorized. Activation is conditional on an
accepted independent audit and human push of this exact five-file scope lock.

### Locked product behavior

The future pass inserts optional Step 4 `Foto ja joondamine`, shifts the
current Steps 4–6 to Steps 5–7 while preserving their labels, details, icons,
and optional/required badge semantics, and derives every count, number, bound,
and final-step decision from `_wizardSteps.length`. Step 4 stays ungated and
becomes `Vaadatud`, never `Valmis`.

A native desktop picker may return one `jpg`, `jpeg`, `png`, or `webp` path.
Cancel preserves the existing draft. Accepted selection/replacement starts at
centered `BoxFit.contain`, zero normalized translation, scale `1.0`, and
rotation `0.0`, with finite opacity `0.65` clamped to `0.0..1.0`. The photo
can be translated, zoomed within `0.25..8.0`, rotated with radians normalized
to `[-π, π)`, and adjusted through a visible `0–100%` opacity slider. At
`0%`, only the image layer is fully hidden, the draft remains selected, and
the UI shows `Foto peidetud`; `100%` is fully visible.

Only the photo transforms or changes opacity. The closed contour and component
candidates remain fixed read-only guides in their existing editor-normalized
coordinates above the photo, including at `0%`. Step 3/4/5 navigation and
responsive resize retain path, translation, scale, rotation, and opacity.
Accepted selection, transform or opacity changes, reset, replacement, and
removal mark the Wizard draft dirty. `Nulli vaade` resets translation, scale,
and rotation only, preserving the selected path and current opacity;
`Eemalda foto` separately clears the complete photo draft. Decode/render
failure remains visible and non-destructive. Both 1440x900 and 390x760 remain
operable.

### Platform, ownership, and boundary

Version 1 makes no mobile/web picker promise. The Wizard parent owns the
authoritative nullable path, editor-normalized translation, finite bounded
scale, normalized rotation, finite clamped opacity, and dirty state. The child
editor owns only gesture-lifetime ephemeral state; no provider, singleton,
route handoff, or child-only authoritative controller is allowed.

The implementation is `UI_LOCAL` + `ZERO_WRITE`. `Joondamine` is only a
presentation transform. There is no source copy/modification, project photo
file, sidecar/ledger/hash/EXIF, fact/event, canonical coordinate output,
reference point or solver, creator/project state/provider/filesystem write,
AI/OCR/CV, router, Board Canvas, existing project-photo workflow, schema,
validator, materializer, package, asset, or Project ZIP authority.

### Code-map plan and route

The existing Wizard source/test maps are `MAINTAINED` now and become
`UPDATE_REQUIRED` after material implementation. The two new files are absent
and must be qualified only in the later unnamed LOCK from committed source.
No maps are created or updated during EHITUS, and no prerequisite or separate
map pass exists.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_PHOTO_ALIGNMENT_V1_IMPL_PASS
```

After accepted and pushed implementation, one unnamed LOCK updates the
existing maps, qualifies both new files, and then routes to
`NEEDS_USER_DECISION`. Its `PASS_ID` is not reserved here.

## Superseded original scope record (historical)

This Lane A docs sync records the human's 2026-07-27 choice of the BenchBeep
`Loo projekt nullist` redesign as the next priority and locks one narrow future
implementation pass. It changes no product behavior now.

The original direct
`TRACEBENCH_NEW_PROJECT_WIZARD_REDESIGN_SCOPE_LOCK_PASS` ->
`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` pointer and two-file allowlist
below remain historical scope evidence. Later scope and implementation work
superseded and completed that reservation; none of it is current authority.

### Authority basis

Baseline `b228a0b8dcfaf9b779b8c5ac5d14d7be2b001c5e`
(`docs: repair archive attestation and evidence ownership`) contains the
finished `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`. Entry evidence showed
`HEAD == origin/main`, branch `main`, divergence `0 0`, and empty tracked and
cached diffs. The prior seven-file repair authority is spent.

The explicit human decision replaces the non-executable
`NEEDS_USER_DECISION` pointer with this five-file docs-only lock. No prior
allowlist is inherited and no separate closeout, release, or pointer-reset pass
is created.

### Locked implementation

`TRACEBENCH_NEW_PROJECT_WIZARD_FOUNDATION_PASS` may later change exactly:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

It is limited to a six-step Wizard shell, Step 1 project-data draft UI,
step navigation, and dirty-draft cancel confirmation. All values remain
widget-local. Steps 2–6 are visible but not implemented.

The live Wizard currently has a working `wizard-create` CTA:
`_createProject` calls `ProjectCreator.createProject`; success assigns
`projectStateProvider` and navigates to `/project`; typed creation failures are
shown to the user; and focused widget tests cover that create flow. The future
pass intentionally replaces this working UI with a temporary non-creating
foundation. It must not call the creator or create a directory, file, manifest,
event, projection, fact, or other persistent state. Home and router stay
unchanged. Final creation integration requires a later separate route decision
and is not authorized here.

Step 1 deliberately deviates from the design handoff: it shows no derived
child-folder preview, performs and claims no writability check, retains only
the selected parent path as widget-local draft state, gates `Edasi` solely on
a nonblank project name plus a selected parent path, creates no directory or
file, and gives no collision or writability guarantee.

The human explicitly authorizes the future two-file pass to combine the
affected responsibility zones named by the maintained Wizard source and test
maps only for this `UI_LOCAL`/`ZERO_WRITE` foundation. It authorizes no
`ProjectCreator`, persistence, writer, schema, materializer, Home, or router
change. Its `CODE_MAP_DISPOSITION: UPDATE_REQUIRED`; after accepted committed
implementation, map maintenance belongs to a separate unnamed and unarmed
docs-only lock/map pass.

### Source and boundary

The exact design handoff under
`_incoming/ui_redesign/TraceBench_new_project_wizard/design_handoff_loo_projekt_nullist`
is high-fidelity visual/product input only. It is inspect-only and must not be
copied, imported, modified, staged, or runtime-referenced. Existing theme,
icons, assets, source, tests, and canonical owners outrank it.

No board-outline, marker, component, canonical event, creator persistence,
schema, writer, materializer, package, asset, Project ZIP, AI/OCR/photo/
template/phone, or Board Canvas redesign authority is created.
