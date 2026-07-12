# Active Scope Lock

## Route

Current: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS`

Baseline: `25064a617571d79a56acd9f6759e936e5c47eeef` (`docs: close out benchbeep home startpage redesign`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Current docs-only authority

This pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS.md`

No Flutter implementation, runtime, test, asset, schema, writer, tool, route, package, or product behavior change is authorized in this pass. Do not stage, commit, or push.

## Approved design input

Human-approved reference:

- `_incoming/ui_redesign/Components/Board Canvas Component Navigator Menu Design.html`

Use it only for layout hierarchy, visual density, category drill-down, hover-versus-selection treatment, filter positioning, and inspector states.

Do not edit, copy, import, stage, or runtime-reference `_incoming`. Do not copy demonstration coordinates, synthetic project data, review-state dock, review-only JavaScript, HTML/CSS, or prototype shell geometry that conflicts with the existing Flutter Board Canvas. Preserve actual project coordinates and existing footprint rendering.

## Armed implementation allowlist

`BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS` may write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If any other file is required, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Implementation goal and panel topology

Implement a scalable Board Canvas component navigator as UI-local presentation/navigation in the one existing contextual right panel:

1. component categories
2. components in the selected category
3. selected component inspector

The three levels are mutually exclusive.

Back controls are exact:

- Level 2: `← Komponenditüübid`
- Level 3: `← <category name>`

Do not add accordion categories, permanently split category/list/inspector areas, multiple permanent right-side panels, a new standalone component page, a second component hub, a new route, or a permanent column.

## Fixed category model

Technician-facing order is fixed:

1. `Takistid`
2. `Kondensaatorid`
3. `Dioodid`
4. `Transistorid`
5. `Mikroskeemid`
6. `Konnektorid`
7. `Poolid ja trafod`
8. `Kaitsmed`
9. `Testpunktid`
10. `Muud / tundmatu`

Normally hide categories with no project components. When hide-unmeasured removes every visible component from a category that exists in the project, keep that category visible with zero-visible counts.

Classification is UI-local only. Do not edit or normalize canonical `ComponentFact.type` / component-kind data. The UI mapping must cover:

- `Takistid`: resistor, takisti, res, and pull-up / pull-down / shunt-like resistor kinds.
- `Kondensaatorid`: capacitor, cap, kondensaator.
- `Dioodid`: diode, diood, zener, schottky, and LED when currently represented as a diode-kind component.
- `Transistorid`: transistor, mosfet, fet, bjt.
- `Mikroskeemid`: ic, mcu, controller, chip, regulator, opamp, mikroskeem.
- `Konnektorid`: connector, socket, header, plug, konnektor.
- `Poolid ja trafod`: inductor, coil, choke, transformer, induktiiv.
- `Kaitsmed`: fuse, kaitse, and PTC when represented as a protection/fuse component.
- `Testpunktid`: testpoint, test point, tp, testpunkt.
- `Muud / tundmatu`: blank, unknown, and unrecognized values.

Do not infer canonical component identity or category from footprint/template geometry. Unrecognized canonical kind/type values use `Muud / tundmatu` rather than inventing a more specific fact.

## Category counts and interaction

Normal mode must state placement meaning explicitly:

- `<placed> / <total> paigutatud`
- `<unplaced> paigutamata`

`placed` means the component has at least one confirmed visual placement. `unplaced` means it has no confirmed visual placement. UI-local drafts, ghosts, and hover previews never count as placed.

Hide-unmeasured mode must state filtering meaning explicitly:

- `<visible> / <total> nähtaval`
- `<hidden> peidetud`

Do not use an unexplained `<N> / <N>` count. Each category row has a compact drill-down chevron.

Category hover:

- highlights all visible confirmed placements in that category
- excludes placements hidden by the global filter
- preserves the current selection
- opens neither category nor inspector
- does not pan or zoom
- clears only its temporary preview on pointer exit

Category click opens Level 2. A category with `0 / N nähtaval` remains clickable and shows exactly:

`Kõik selle grupi komponendid on mõõtmata ja peidetud.`

Do not automatically disable the filter.

## Category component list

Level 2 has two separate sections:

- `PAIGUTATUD`
- `PAIGUTAMATA`

Do not merge them into one flat list.

Each row shows:

- primary: human-readable component label
- secondary: component ID and compact technician-facing kind label
- zero related measurements: `Mõõtmata`
- one or more related measurements: `<N> mõõtmist`

Do not add partial/full measurement states, completion percentages, expected-measurement checklists, or measurement quality scoring.

Placement and measurement are independent. Support placed + measured, placed + unmeasured, unplaced + measured, and unplaced + unmeasured.

Within each placed/unplaced section sort:

1. components with one or more measurements
2. components with zero measurements
3. natural component-ID order within each group (`R1`, `R2`, `R10`, `R11`, never lexical `R1`, `R10`, `R11`, `R2`)

## Measurement association

Reuse the existing Board Canvas endpoint/component association semantics. `Mõõtmata` means zero related measurements under the existing rule that an endpoint equals the component ID or starts with `<componentId>.`.

Do not create a new ownership rule or change measurement writer/fact semantics.

## Component interaction

Component hover:

- highlights every visible placement for that component
- preserves current selection
- opens no inspector
- chooses no placement
- does not pan or zoom
- is visually distinct from persistent selection

Component click:

- opens the component inspector
- creates only UI-local component selection
- does not automatically choose a first placement
- writes no event

## One coherent UI-local selection model

Extend the existing typed selection model inside the allowed screen file as needed, with one coherent source such as:

- `EmptyCanvasSelection`
- `ComponentSelection`
- `ComponentPlacementSelection`

Component selection identifies a component without selecting a placement. Placement selection identifies an explicit placement. Existing placement selection, canvas tap-to-select, inspector context, and compatible workflows remain functional.

Do not maintain a second competing selected-component source. Selection remains volatile UI state and adds no canonical, pin, contact, net, trace, measurement, coordinate, or electrical semantics.

## Inspector behavior

For a component with one confirmed placement:

- show the placement
- provide explicit `Vaata canvasel`

For multiple confirmed placements:

- show a human-readable placement chooser
- start with no placement chosen
- allow hover to preview one placement temporarily
- require explicit click to select one placement

Specific-placement hierarchy:

- chosen placement: strongest solid gold outline/glow
- sibling placements of the same component: weaker or dimmed
- unrelated components: normal treatment

For an unplaced component:

- open the inspector normally
- show `Pole veel canvasele paigutatud`
- show explicit `Paiguta canvasele`

Clicking a component row must not start placement.

## Unplaced known-component placement dependency

`Paiguta canvasele` may start only the existing Board Canvas UI-local placement mode and a UI-local placement/template/ghost draft for the selected known component. It must not append an event immediately. Only the existing explicit confirmation/save path may write canonical placement.

Live code at this scope lock currently makes `_confirmAddComponentTemplatePlacement` depend on an existing `_PlacementEntry`. The implementation must prove that the known unplaced component can use the existing local draft and explicit save boundary entirely within the two-file allowlist, without writer/service/schema changes.

The implementation must first verify existing first-placement support and valid provenance/default inputs for coordinate space, board side, initial center/size/rotation, and source photo. Do not invent those values or infer writer/materializer acceptance from the UI alone.

Do not modify `v2_placement_writer.dart`, writer requests, event payloads, schema, validator, materializer, or projection semantics. Do not fake the action, add a dead button, or silently create a writer flow.

If the existing local flow cannot support this within the two-file allowlist, stop with `BLOCKED_PLACEMENT_FLOW_DEPENDENCY`.

## Persistent hide-unmeasured control

Add one persistent Canvas toolbar control outside the component navigator. It remains available in every right-panel mode.

- default action label: `Peida mõõtmata`
- active action label: `Näita mõõtmata`
- icon plus visible text

Default Board Canvas state shows all components. Hide-unmeasured is disabled. The filter is volatile UI-local state: do not persist it per session or project and do not write it to events or project files.

When active, hide unmeasured components from:

- canvas rendering and hit testing / selection eligibility
- category component lists
- category hover previews
- component hover previews

Unplaced unmeasured components disappear from the menu; they have no canvas placement to render.

If the selected component becomes hidden, clear selection, close its inspector, return to the appropriate category/list context, and leave no invisible active selection.

If zero placed components remain visible, keep the filter active, show exactly `Kõik komponendid on mõõtmata`, and keep `Näita mõõtmata` immediately available.

## Search exclusion

Do not add a search input, search icon, advanced filter, search state, or search empty state in this slice.

## Visual requirements

Preserve the existing BenchBeep Board Canvas identity and geometry: near-black shell, warm dark panels, cream primary text, muted beige secondary text, restrained green measurement/status indicators, existing left rail, canvas dominance, right-panel widths, medium/wide layouts, actual renderer coordinates, and existing footprint rendering.

- hover: temporary cool/neutral dashed treatment
- component selection: persistent gold
- explicit placement selection: strongest gold
- hidden: absent from rendering and interaction

Do not rely on color alone; use stroke style, weight, glow, icon, or copy where needed.

The navigator and its new production states must contain no review dock, `local · no write`, `renderer writes: none`, schema/debug/event terminology, or synthetic project title.

## Workflows that must remain green

Do not regress measurement entry, component identity creation, metadata editing, visual placement confirmation, the existing placement editor, add-component template flow, canvas tap selection, measurement badges, current inspector behavior, safety/evidence panel, focus mode, rail modes, medium/wide layout, projection-stale truthfulness, or explicit save guards.

No standalone page is removed.

## Future implementation test contract

The implementation test plan must cover at minimum:

1. fixed category mapping
2. fixed category order
3. categories absent from the project hidden in normal mode
4. normal placed/total and unplaced counts
5. filtered visible/total and hidden counts
6. category hover highlights all matching visible placements
7. category hover preserves existing selection
8. category click opens drill-down
9. back navigation between all three levels
10. separate `Paigutatud` and `Paigutamata` sections
11. measurement-first and natural-ID sorting
12. `Mõõtmata` versus `<N> mõõtmist`
13. component hover highlights only that component's visible placements
14. component click opens inspector without placement auto-selection
15. multiple placements start with none chosen
16. explicit placement selection applies the strongest visual treatment to one placement
17. unplaced component opens inspector without starting a draft
18. `Paiguta canvasele` explicitly starts the existing UI-local placement flow
19. navigation, hover, and filtering cause no writer call
20. default Board Canvas opens with all components visible
21. hide-unmeasured affects canvas and menu consistently
22. hiding the selected component clears selection and closes inspector
23. zero-visible category remains present and opens its compact message
24. zero-visible canvas shows `Kõik komponendid on mõõtmata`
25. `Näita mõõtmata` restores components
26. existing Board Canvas widget tests remain green

Use test-driven development and systematic debugging during implementation.

## Future implementation validation

Run:

```powershell
dart format `
  lib/features/board_canvas/screens/board_canvas_screen.dart `
  test/widget/board_canvas_screen_test.dart

flutter test test/widget/board_canvas_screen_test.dart
flutter test
python tools/validate_all.py
git diff --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Manual human visual review is required before the final Claude implementation audit. Tests alone do not establish visual acceptance.

## Protected boundaries and stop conditions

- Navigation, hover, selection, filtering, and drill-down create no event or canonical fact and do not mutate `known_facts.json`.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- No component, placement, measurement, AI/OCR/CV, electrical, evidence, repair, or canonical write semantic changes.
- No route, router, page, package, font, theme, asset, shared-model, service, writer, tool, `_incoming`, or standalone-screen edits.
- Renderer/painter and UI-local state create no truth.
- Preserve the existing explicit save/write boundaries and projection-stale behavior.
- Stop on charter conflict, unrelated tracked diff, validation failure outside the allowlist, `BLOCKED_ALLOWLIST_MISMATCH`, or `BLOCKED_PLACEMENT_FLOW_DEPENDENCY`.
- Do not stage, commit, or push without explicit later human instruction and an accepted exact staging set.
