# Current State

Current pass: NEEDS_USER_DECISION
Next recommended pass: NEEDS_USER_DECISION

## Status

No active implementation lock is armed.

Latest pushed baseline:
- `4390255c51609396977a16f60b14c2b6bee50d8c feat: add board canvas right-panel component creation`

Latest closed work:
- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` is implemented and pushed.
- Closeout pass: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_POST_AUDIT_PASS`.
- Review status: `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; Claude audit was not supplied for this pass.
- Reviewer path: GPT/Pro review plus local validation plus manual smoke plus user-approved push.
- GPT/Pro verdict before staging: `ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.

## Latest product direction

BenchBeep is a local-first Visual First PCB repair workbench.

Technician-facing core:
- `Koht -> Väärtus -> Ühik -> Salvesta`

Primary workflow rule:
- VISUAL FIRST.
- The technician stays on the board.
- Board Canvas plus right-side panel/menu is the primary workflow surface.
- Old Add/Edit/Measure-style pages are transitional migration/removal debt, not the primary technician workflow.
- AI may propose and organize, but the human confirms canonical facts.

## Right-panel component creation closeout

Board Canvas right-panel now has compact component identity creation.

Implemented behavior:
- Creation is available from the Board Canvas right panel.
- Creation uses the existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- Creation writes only `component_created`.
- Creation is explicit human action only via `Loo komponent`.
- Successful create appends the returned event to local `projectState.events` if not already present.
- Successful create marks projection stale.
- Flow does not route to the standalone Add Component page.
- Flow does not create visual placement.
- Flow does not place the component on canvas.
- Flow does not create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.

Visible rich labels from design input map only to writer-safe canonical `componentKind` values:
- `Generic / unclassified` -> `unknown`
- `Resistor / capacitor / diode / passive` -> `passive`
- `IC dual-side / quad-side / dense grid` -> `ic`
- `Connector / header` -> `connector`
- `Regulator / relay / module` -> `regulator`

No new canonical `componentKind` values were introduced.

Manual smoke recorded for closeout:
- unique component ID creates component successfully.
- duplicate component ID is rejected by writer/validator.
- duplicate ID UI shows friendly Estonian copy: `Komponendi ID on juba kasutusel. Vali uus Koht / ID.`
- raw validator/Python details are not shown for duplicate ID.

Validation recorded for implementation:
- `dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`: PASS
- `flutter test test/widget/board_canvas_screen_test.dart`: PASS, 116/116
- `flutter test`: PASS
- `python tools/validate_all.py`: PASS, 285 tests OK
- `git diff --check`: PASS
- `git diff --cached --name-status`: empty before commit/push

## Candidate future work

Candidates only; no route is armed:
1. Board Canvas metadata edit flow.
2. Fullscreen Exit/Välju affordance.
3. Home lockup refresh.
4. Later right-panel route migration/removal only after replacements and dependency audit.

## Canonical split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Canonical owner pointers

- Route and latest handoff: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`.
- Active allowlist and forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`.
- Durable product memory and Visual First rule: `docs/PROJECT_MEMORY.md`.
- Fact/event law and protected data boundaries: `docs/TRUTH_INDEX.md`.
- UI/workflow policy: `docs/UI_WORKFLOWS.md`.
- Audit/pass provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Documentation map/read priority: `docs/FILE_MAP.md`.

## Non-negotiable safety reminders

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- Board Canvas renderer/painter remains read-only.
- Writer/schema/materializer/validator/tool files unchanged.
- Router unchanged.
- Standalone Add/Edit/Measure screens unchanged.
- `_incoming` is design/provenance input only and was not imported or staged.
- No broad staging: never `git add .`, never `git add -A`, never `git commit -am`.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`