# BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Mode: docs-only route and implementation scope lock
- Current pass: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS`
- Next pass: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS`

No Flutter implementation, runtime, test, asset, schema, writer, tool, route, package, or product behavior was changed. Nothing was staged, committed, or pushed.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Remote: `Fuuduuu/TraceBench`
- `HEAD == origin/main == 25064a617571d79a56acd9f6759e936e5c47eeef`
- Commit subject: `docs: close out benchbeep home startpage redesign`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Only known untracked scratch/design/generated material was present.
- GitHub live verification confirmed the same commit and the pre-pass route `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` in the pushed route owners.

The repo docs and verified Git state matched the requested baseline, so this docs-only scope lock was allowed to proceed.

## Human-approved design source

`_incoming/ui_redesign/Components/Board Canvas Component Navigator Menu Design.html`

- Classification: `DESIGN_INPUT_ONLY`
- State: untracked, unstaged, read-only
- Pre-edit SHA-256: `266CD79BE79186B50429210258BB575BFD93C1B3396EFCDD0A641477ABA29E56`
- Approved uses: hierarchy, density, drill-down, hover-versus-selection treatment, filter positioning, and inspector states
- Excluded: demonstration coordinates, synthetic data, review-state dock, review-only JavaScript, HTML/CSS copying, and prototype shell geometry that conflicts with Flutter Board Canvas

The implementation must preserve actual project coordinates and the existing footprint renderer. `_incoming` must not be edited, copied, imported, staged, or runtime-referenced.

## Current docs allowlist

This pass wrote exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS.md`

## Armed implementation allowlist

`BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS` may write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If another file is required: `BLOCKED_ALLOWLIST_MISMATCH`.

## Live-code reconciliation

Read-only inspection established:

- Board Canvas already owns a typed, UI-local `CanvasSelection` with `EmptyCanvasSelection` and `ComponentPlacementSelection` in the allowed screen.
- Existing canvas hit testing, placement selector, empty-canvas clearing, and ordinary inspector context route through that local selection source.
- Add mode currently preserves a second untyped `_addComponentTemplatePlacementContextKey` and then clears `_canvasSelection`; the future navigator/placement integration must reconcile this rather than create or retain competing selected-component sources.
- Existing measurement-to-component association treats an endpoint as related when it equals the component ID or starts with `<componentId>.`; the navigator must reuse this rule.
- Existing painter/canvas input is placement-entry based, so UI-local filtered and hover-highlighted entry state can remain presentation-only.
- Existing actual placements preserve board-normalized project coordinates and footprint rendering.
- The current build returns a no-placement empty state before normal workbench rendering, so future unplaced-component navigation requires an intentional test-backed adjustment within the two-file implementation allowlist.
- The current placement confirmation path requires an existing `_PlacementEntry`; unplaced known-component placement therefore remains a mandatory dependency gate rather than an assumed capability.

The prior typed-selection audit was consulted only to confirm its established no-write/no-canonical-state boundary. No historical audit state was rewritten.

## Locked navigation and category decisions

One existing contextual right panel has three mutually exclusive levels:

1. `Komponenditüübid`
2. selected-category component list
3. selected component inspector

Back controls are `← Komponenditüübid` and `← <category name>`. No accordion, permanent split, extra permanent panel, new page/route, second hub, or detached component surface is authorized.

Fixed category order:

1. Takistid
2. Kondensaatorid
3. Dioodid
4. Transistorid
5. Mikroskeemid
6. Konnektorid
7. Poolid ja trafod
8. Kaitsmed
9. Testpunktid
10. Muud / tundmatu

The alias coverage and fallback mapping are locked in `docs/ACTIVE_SCOPE_LOCK.md`. Classification remains UI-local and must not normalize canonical component-kind/type values or infer identity/category from footprint/template geometry.

Normally empty categories are absent. Under hide-unmeasured, an existing category stays present even at zero visible components.

## Locked counts, lists, and sorting

Normal category rows explicitly show `<placed> / <total> paigutatud` and `<unplaced> paigutamata`. Filtered rows explicitly show `<visible> / <total> nähtaval` and `<hidden> peidetud`. Rows include compact drill-down chevrons.

Placed means at least one confirmed visual placement; unplaced means none. UI-local drafts, ghosts, and hover previews never affect these counts.

Category Level 2 keeps separate `PAIGUTATUD` and `PAIGUTAMATA` sections. Component rows show a human label, component ID, technician-facing kind, and `Mõõtmata` or `<N> mõõtmist`.

Placement and measurement remain independent. Within each section, measured components sort before unmeasured components, then by natural component-ID order (`R1`, `R2`, `R10`, `R11`). No completion percentage, partial/full state, expected checklist, or quality score is authorized.

## Locked hover, selection, and inspector behavior

- Category hover previews every matching visible placement without changing selection, opening a level, or moving the canvas.
- Component hover previews only that component's visible placements without choosing a placement or opening the inspector.
- Hover exits clear only temporary preview state.
- Component click creates UI-local component selection and opens the inspector with no automatic placement choice and no write.
- The existing typed model may add `ComponentSelection`, but one coherent selection source is mandatory; no second selected-component state is allowed.
- Component selection carries no placement choice. Placement selection remains explicit and compatible with canvas tap-to-select.
- One placement exposes `Vaata canvasel`.
- Multiple placements begin with none selected, allow temporary hover preview, and require explicit selection.
- Explicit placement uses the strongest solid gold treatment; sibling placements are weaker/dimmed; unrelated placements remain normal.
- Unplaced inspector copy is `Pole veel canvasele paigutatud` with explicit `Paiguta canvasele`.
- Component-row click never starts a placement draft.

All navigation, hover, filter, drill-down, and selection state is volatile UI-local state and writes no event or project file.

## Locked measurement filter

The Canvas toolbar, outside the navigator, has a persistent icon-plus-text control:

- default: `Peida mõõtmata`
- active: `Näita mõõtmata`

Default is all components visible. State is not persisted per session/project and is not written.

When active it removes unmeasured components from canvas rendering/hit testing, category lists, hover previews, and selection eligibility. If a selected component becomes hidden, selection is cleared, its inspector closes, and the UI returns to the appropriate list/category context. A zero-visible category remains clickable and shows `Kõik selle grupi komponendid on mõõtmata ja peidetud.` A zero-visible canvas keeps the filter active, shows `Kõik komponendid on mõõtmata`, and keeps `Näita mõõtmata` available.

No search UI or state is authorized.

## Unplaced placement dependency rule

`Paiguta canvasele` may only enter the existing Board Canvas UI-local placement/template/ghost draft for the selected known component. It must not append an event. Canonical placement remains behind the existing explicit confirmation/save path.

No placement writer/service request, event payload, schema, validator, materializer, or projection change is authorized. A fake/dead action or a new writer flow is forbidden.

If the current local flow cannot support the action entirely inside the two implementation files, stop with `BLOCKED_PLACEMENT_FLOW_DEPENDENCY`.

Implementation must first verify that the existing writer contract accepts a first visual placement and establish valid coordinate-space, board-side, initial center/size/rotation, and source-photo inputs without inventing semantics. This scope lock does not claim that dependency is already satisfied.

## Visual and workflow preservation

Preserve the near-black/warm-dark/gold/cream BenchBeep identity, muted beige secondary copy, restrained green measurement/status cues, existing rail, canvas dominance, right-panel widths, medium/wide layouts, actual coordinates, and footprint geometry.

Temporary hover uses a cool/neutral dashed treatment; component selection is persistent gold; explicit placement selection is strongest gold; hidden components are absent from rendering and interaction. State must not rely on color alone.

Do not introduce prototype/review/debug copy. Preserve measurement entry, identity creation, metadata edit, visual placement confirmation, placement editor, add-component template flow, tap selection, measurement badges, inspector behavior, safety/evidence, focus mode, rail modes, projection-stale truthfulness, and explicit save guards. No standalone page is removed.

## Protected boundaries

- Renderer/painter and UI-local presentation state create no truth.
- Navigation, hover, filtering, and selection append no event and do not mutate `known_facts.json`.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- No component, placement, measurement, AI/OCR/CV, electrical, evidence, repair, or canonical-write semantic changes.
- No route/router/page/package/font/theme/asset/shared-model/service/writer/tool/`_incoming`/standalone-screen edits.

## Future implementation verification gate

The 26 minimum behavior/test cases are enumerated in `docs/ACTIVE_SCOPE_LOCK.md`. Implementation must use test-driven development and systematic debugging, run focused and full Flutter tests plus repo validation, and pass manual human visual review before the final Claude implementation audit. Tests alone cannot establish visual acceptance.

## Route after this pass

Current: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS`

Next: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS`

Do not route through `NEEDS_USER_DECISION` between them.

## Validation

Final docs-pass validation evidence is recorded after all five allowed docs are present:

- `python tools/validate_all.py`: PASS; 285 tests ran, all OK
- `git diff --check`: PASS; warning-only Git line-ending notices
- `git diff --name-status`: exactly the four tracked route/ledger docs modified; the new audit artifact is untracked and visible in status
- `git diff --cached --name-status`: empty
- `git status --short --branch`: `main...origin/main`; exactly the four tracked docs plus this new audit artifact are in the pass write set; pre-existing scratch/design/generated untracked material remains unstaged
- Runtime/test/asset diff: empty
- Design-input SHA-256 after edits: `266CD79BE79186B50429210258BB575BFD93C1B3396EFCDD0A641477ABA29E56` (unchanged)

## Model routing

- GitHub: live baseline and pushed-route verification completed.
- Claude Design: completed human-approved design input; no new design generation required.
- Codex: bounded docs-only scope lock.
- Claude Code: independent read-only audit after Codex.
- Human: exact staging, commit, and push only after acceptance.
- Systematic debugging and test-driven development: required in the later implementation pass, not used to implement runtime in this docs-only lock.
- Figma, Adobe, Canva, and security skills: not required for this pass.
