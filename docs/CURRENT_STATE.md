# Current State

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

Accepted implementation baseline: `33cf477b6661d077b16b814965b1ac02bf953cb0`.
No further runtime implementation is reserved. The next module is for the human
to select; this bounded documentation sync does not authorize code changes.

Workflow defects and deferred features: [Workflow findings register](WORKFLOW_FINDINGS.md).
Current implementation ownership: [Architecture boundaries](ARCHITECTURE_BOUNDARIES.md).

## Implemented and accepted

| Commit | Implemented result |
| --- | --- |
| `7c45429` | Shared Wizard-to-Canvas geometry preserves candidate position, shape, size and rotation; canonical Placement coordinates remain unchanged. |
| `46ce43e` | Explicit Workbench projection refresh without ZIP export, with guarded same-project Session adoption preserving in-flight saves. |
| `aaf26da`, `10c63ce`, `db1003f` | Shared ComponentCandidateEditor, standalone ComponentNavigator and reusable Placement template/preview library. |
| `7addd06` | Hardened read-only Preflight: exact Git paths, rename handling, protected handoff classification and distinct verdicts. |
| `357ea6e` | Shared component-type/normalization and measurement-unit vocabulary, preserving consumer labels, defaults and writer values. |
| `21a6c7d` | BB-01: explicit component selection cannot silently become another component's measurement target. |
| `8887d65` | Canvas Selection & Mode Routing; BB-08/09/11/16 selection exclusivity, Navigator synchronization, filter-mode retention and pure reconciliation. |
| `b188be3` | CandidateDragSession; BB-02/14 thresholded reflow-safe drag, grab-offset retention and changed pointer-up completion. |
| `33cf477` | BB-04/05/06, mode-specific overlap precedence, unambiguous Inspector resolution and compact Navigator retention. |

- Board Canvas remains the primary warm black/gold Workbench. Its instrument bar
  and secondary compact shell preserve all twelve project destinations. Photos
  and Overview share the presentation foundation; nine other destination contents
  remain incompletely modernized.
- The seven-step Wizard, local creation/loading and shared noncanonical candidate
  editor exist. Components, Placement, Measurement, Inspector and photo modules
  retain their separate responsibilities and accepted writer boundaries.
- `CanvasRoutingState` is the single selection/mode decision owner. Visible Lisa
  allows candidate -> confirmed placement -> empty-space authoring. Outside
  visual Lisa, confirmed placements win overlaps. Selection alone writes no facts.
- Measurement retains its target/draft on empty or inert-candidate clicks. Inspector
  resolves a component-only selection only when exactly one eligible placement
  matches; zero/multiple matches remain unresolved. Only Measurement retains the
  accepted empty-selection first-visible fallback, which does not prove intent.
- An open Component Navigator remains usable across wide/compact layouts and
  compact placement-menu choices. Canvas selection synchronizes its component/category.

## Product priorities

Continue modularization and real reuse through a small human-selected module.
No next implementation has been selected or armed. The following remain backlog
items, not an executable sequence or authorization:

| Area | Remaining gap and required boundary |
| --- | --- |
| Data-correctness assessment | BB-10 canonical target loss and BB-13 repeated Placement Save require their own assessment; neither is closed by the routing corrections. |
| Interaction UX | Approximately 2 px mouse movement can lose a Canvas click to panning. Compact Navigator's Paiguta canvasele can enter a hidden-panel dead end. Candidate selection in compact/focus may enter authoring without visible controls/retry; hidden empty-space creation is fixed, these UX gaps are not. |
| Deferred product feature | Candidate -> component identity -> confirmed placement needs separate authorization and a persistent geometry-compatibility decision. Reuse existing writers without moving legacy placements. |
| Workspace acquisition | ZIP loading has no editable local project directory; local candidate sidecars do not travel in ZIP. Preserve transport compatibility and user files. |
| Presentation/lifecycle | Modernize remaining legacy contents in bounded tasks; improve Home/resume and project-derived labels; clarify Wizard background, canonical photo and reference-image roles. |
| Future | Phone capture guidance, photo proposals, repair maps, AI next steps and human-triggered AI memory remain subject to PROJECT_MEMORY return conditions. |

## Current behavior and limits

- `WorkbenchProjectionRefresh` offers Värskenda andmeid for STALE local projects.
  The existing Python materializer and directory loader feed guarded projection
  adoption. Failure preserves active Session/stale state and permits retry;
  project switches and newer accepted events cannot be overwritten. UNKNOWN is
  distinct and has no refresh action. No automatic background refresh exists.
- Canvas candidate edits persist in `.tracebench_local/component_candidates.json`;
  original `notes/wizard_intake.json` remains intake. Candidates are not confirmed
  components, placements, contacts, measurements or electrical facts. No local
  directory means session-only candidate editing. Candidate confirmation is deferred.
- `ProjectLoader.loadFromZipBytes` returns in-memory state without a writable
  directory. ZIP excludes local sidecars but can carry original optional intake.
- Home can continue an already-open Session; project Home navigation closes it.
  Durable resume and hardcoded example labels remain incomplete.

## Preserved unrelated draft and protected work

The earlier editor scope draft and its AUDIT_INDEX change remain foreign
uncommitted material, not implementation authority. Preserve them and the three
pre-existing generated Windows changes. This docs sync changes no runtime,
canonical contract, candidate confirmation, migration, ZIP behavior or dependency.

## History and ownership

The consolidation archives preserve committed operational files from `69e5bd4`,
before consolidation `49c65b9`:

- [Current-state history](archive/CURRENT_STATE_HISTORY_2026-10-29.md)
- [Queue history](archive/PASS_QUEUE_HISTORY_2026-10-29.md)
- [Scope history](archive/ACTIVE_SCOPE_LOCK_HISTORY_2026-10-29.md)

They are historical, not active reservations; their relative references retain
original docs/ context. Accepted audit evidence is unchanged. Product philosophy
and future AI/photo conditions: [PROJECT_MEMORY](PROJECT_MEMORY.md#future-aiphoto-return-conditions).
CURRENT_STATE owns priorities, PASS_QUEUE sequence and ACTIVE_SCOPE_LOCK the task
boundary. POHIKIRI and canonical semantic/protected owners remain authoritative.
