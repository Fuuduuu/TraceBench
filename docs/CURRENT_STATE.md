# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS`
Next recommended pass: `TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS`

## Live component-placement-v1 scope lock

The human selected Wizard Step 3 `Komponentide asetus v1` as the next
`SCOPE -> EHITUS -> LOCK` cycle. The current authority is:

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS
Lane: A
Mode: DOCS_SYNC
```

Entry evidence is branch `main`,
`HEAD == origin/main == 8e7b075f25a37d70f22d3d38ac26fdb61346ee52`,
divergence `0 0`, with no substantive or cached diff. The completed contour-v1
LOCK is the pushed predecessor at this baseline, and both Wizard target maps
plus their matching index rows are `MAINTAINED`.

This pass may change exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS.md`

No sixth current-pass file is authorized.

## Reserved implementation

```text
PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS
```

Exact future write allowlist:

- `lib/features/project/screens/new_project_wizard_screen.dart`
- `test/widget/new_project_wizard_screen_test.dart`

No third implementation file is authorized. Future authority becomes
executable only after independent acceptance and human push of this exact
five-file scope lock.

## Locked behavior and human decisions

The implementation replaces only the Step 3 placeholder with a private,
widget-local component-candidate editor. The closed Step 2 contour is a
read-only visual guide. An empty-canvas action adds one generic candidate; a
candidate can be selected, dragged with its center clamped to editor bounds,
and deleted when selected. Step 3 -> Step 4 -> Step 3 retains candidates and
positions, every candidate mutation marks the Wizard draft dirty, and count
plus selection state use text/icon semantics in addition to color.

Each candidate contains only a local draft key and transient editor-local
position. The contour is not a hard polygon-containment boundary. Step 3 stays
optional, has no `Edasi` gate, and remains `Vaadatud` after a visit rather than
becoming `Valmis`. Version 1 adds no bulk reset or placement limit. Wide
1440x900 and compact 390x760 layouts remain operable; Steps 4–6 remain
placeholders.

## Map lifecycle and boundary

Both exact implementation targets and their index rows are currently
`MAINTAINED`:

- Wizard source: `AUTO — 5+ independently testable behaviors`;
- Wizard test:
  `SCORE 8/12 — 27-test multi-family contour/navigation/responsive protected-boundary surface`.

The reserved implementation has:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted and pushed implementation, one later unnamed LOCK updates the
two maps from accepted committed source. It is not named or executed here.

The implementation remains `UI_LOCAL` + `ZERO_WRITE`. Generic candidates are
human-created visual proposals only. They establish no component identity,
type, value, designator, package, footprint, pins, contacts, board side,
electrical connectivity, net membership, measurement, diagnosis, or physical
validity. Their positions are not canonical `board_normalized` coordinates.

No category/type/footprint/template choice, size, rotation, snapping, grid,
polygon containment, Add Component, Board Canvas, provider, `ProjectCreator`,
project-state, persistence, event, fact, projection, schema, writer,
materializer, Project ZIP, AI/OCR/CV/photo/template derivation, router, Home,
app, package, asset, tool, or `_incoming` behavior is authorized.

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_SCOPE_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_IMPL_PASS
```

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
