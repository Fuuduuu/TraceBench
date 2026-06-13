# V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass with allowlist-limited updates after an already accepted/pushed runtime implementation.

## AGENTS/skills usage note

- Required reads and prompt discipline were followed from:
  - `AGENTS.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/PROTECTED_SURFACES.md`
  - `docs/CODEX_TOOLING_POLICY.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/WORK_INTAKE_INDEX.md`
- Repo-local skills consulted before writing:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`

## Tool/plugin/download report

### Available local capabilities

- PowerShell filesystem + repo tooling (`git`, read/write files).
- Python runtime (`py -3`) is available.
- Existing local plugins/app connectors are available in the environment (for optional later work), but no plugin/MCP enablement was used.

### Candidate downloads

- None required for this docs-only scope-lock pass.
- No package/dependency/plugin/tool/runtime downloads, installs, or enablement actions were performed.

## Preconditions

- `git status --short --branch` was clean for tracked files (`main` with expected untracked scratch artifacts only).
- branch: `main`.
- `git log --oneline --decorate -8` confirmed latest commits and previous accepted passes.
- No staged runtime/test/schema/tool artifacts were present at start.
- Route docs were updated to a single active current/new next pair before writing scope-lock content.

## Current-code read-only evidence

### `lib/features/components/screens/edit_component_screen.dart`

- Components are read from `projectState.knownFacts.components`.
- There is no explicit `components.isEmpty` guard before building the form.
- The component dropdown always renders with `items: components.map(...)`; with zero components this renders an empty selection list.
- The route/action remains in the same screen and uses existing edit/confirmation workflow.

### `lib/features/components/services/v2_edit_component_writer.dart`

- Request path is constrained by `_hasKnownComponent`; unknown IDs are rejected as `unknownComponent`.
- Existing-component-only edit path is enforced through `componentId` lookup.
- Event construction remains `component_updated` with confirmed human action (`actor`, `source`, `confirmation`).
- No `sequence` field is present in the candidate event payload map.

### `test/widget/edit_component_screen_test.dart`

- Fixture supports `includeComponents: false` in `_inlineProjectState(...)` and therefore can model an empty-project component state.
- Existing focused tests do not assert empty-state UX behavior (all current assertions assume one component is available).
- Existing tests do assert:
  - human-confirmed form/action gate,
  - existing-component request constraints,
  - forbidden non-canonical wording, and
  - `component_updated` writer behavior.

### `lib/app/router.dart`

- Existing Add Component route is already present as `name: 'add-component'` with path `components/add`.
- Edit route is `name: 'edit-component'` on `components/edit`.
- The route path needed for empty-state recovery already exists; no route architecture change is required.

## Exact UX risk summary

- When project known-facts has zero components, users can still open a full edit UI shell with:
  - empty component dropdown,
  - edit form fields visible,
  - no explicit “no components” instruction.
- This can be confusing and appears to invite editing without a valid target, increasing accidental misuse risk and violating the intended existing-component semantics.

## Chosen future UX policy

- Show explicit empty-state messaging when no components are available:
  - Heading: `Komponente pole veel`
  - Body: `Muuta saab ainult olemasolevat komponenti. Lisa esmalt komponent ja tule siis muutma.`
- Do not display the editable component form as an active target-edit state in empty mode; keep it clearly non-actionable.
- Keep edit action/save path disabled/absent until a real component exists.
- Offer a safe Add Component action only if existing route is available (`/project/components/add`).
- Do not auto-create a component in this path.
- Do not navigate through route or architecture changes; only a narrow in-screen UX correction is allowed.

## Accepted future implementation scope

Future implementation can touch only:

- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/edit_component_screen_test.dart`
- optional narrow route/overview assertion tests only if a minimal Add Component navigation check is needed.

No runtime/schema/tool/model behavior implementation is part of this lock.

## Allowed files / allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_PASS.md`

## Forbidden files/surfaces

- `lib/features/components/services/v2_edit_component_writer.dart`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- `validator` / `materializer` / `writer service` semantic updates
- `Project ZIP`
- `Board Canvas`
- `Reference Images` runtime
- `AI/OCR/CV`
- `Activity Timeline`
- `Photo Markup`
- `Repair Map`
- `Visual Trace Shape Assist`
- Save Measurement, Add Component, or unrelated feature redesign surfaces
- Adding `sequence` to V2 events
- Canonical event-model shifts in this lock pass
- `Project ZIP`/schema/sample/platform/generated artifact/package lockfile changes

## Required tests for future implementation

1. With no components, Edit Component shows the explicit empty-state heading and body.
2. With no components, the edit form/dropdown is absent or non-actionable.
3. With no components, no writer call occurs and edit/save remains disabled or unavailable.
4. Optional: if Add Component action is provided, it routes to existing `add-component` surface without creating events.
5. With components, existing behavior remains:
   - target selection and human confirmation required,
   - `component_updated` request payload unchanged in shape and fields.
6. Boundary tests remain:
   - no `sequence` in V2 events,
   - no `MeasurementEventWriter` or writer-service runtime path from this UX step,
   - no AI/confidence/probability/diagnosis phrasing in this UX path.

## Explicit non-goals

- No broad Edit Component redesign.
- No component creation flow changes.
- No writer/validator/materializer/schema/projection semantic changes.
- No changes to Save Measurement, Board Canvas, Route architecture, AI/OCR/CV, or event semantics.
- No `clientOperationId`/`sequence` policy change for V2 event model.

## Boundary preservation notes

- Preserve accepted V2 edit contract:
  - existing-component-only target,
  - writer via existing accepted V2 adapter pattern,
  - `actor.type = human`,
  - `source.type = explicit_user_confirmation`,
  - `confirmation.confirmed = true`.
- Preserve project-level invariant that `events.jsonl` is canonical truth and `known_facts.json` is projection cache.
- Preserve no AI/hints-to-truth promotion and no component auto-resolution from hints/candidates/photos/context.

## Validation performed

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Scope drift check

PASS. `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` now point to the same current and next passes and only docs files in the explicit allowlist were modified.

## Route decision

- Current: `V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_PASS`
- Next: `V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_POST_AUDIT_PASS`

## Verdict

PASS candidate if the lock is docs-only, route-consistent, and no forbidden surfaces are touched.

## safe_for_reaudit

YES
