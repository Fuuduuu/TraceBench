# Current State

Current: `NEEDS_USER_DECISION`
Next: `SHARED_VOCABULARY_EXTRACTION`

Workflow defects and deferred features: [Workflow findings register](WORKFLOW_FINDINGS.md).

Verified implementation baseline: `db1003f401424d98c09a9ab3609129fd0a892a43`.
The next entry is planned technical modularization work, not an armed implementation
pass. The completed documentation consolidation is historical, not active
runtime authorization.

## Implemented and accepted

| Commit | Implemented result |
| --- | --- |
| `7c45429` | Shared Wizard-to-Canvas candidate geometry preserves reference-frame position, shape, size and rotation; persisted canonical Placement coordinates remain unchanged. |
| `46ce43e` | Safe explicit Workbench projection refresh, including same-project Session adoption that preserves in-flight canonical saves. No ZIP export is required. |
| `aaf26da` | One ComponentCandidateEditor serves Wizard Step 4 and Canvas. Candidates can be added, selected, dragged, resized and rotated; Canvas edits have a durable local draft. |
| `10c63ce` | Component Navigator is an independently importable widget, with public fact/ID inputs and host-owned selection/filter/placement actions. |
| `db1003f` | Placement template catalogue, chooser, summaries and preview/ghost painter are a reusable standalone library; Placement workflow and writer ownership are unchanged. |

- Seven-step New Project Wizard, local creation and directory loading exist.
- Board Canvas is the primary warm black/gold Workbench. Compact project-menu
  navigation preserves all twelve destinations; Photos and Overview share its
  presentation foundation. The other nine destination contents are not fully
  modernized.
- Components, Placement, Measurement, Inspector and photo workflows retain
  their existing owner modules and explicit canonical writer boundaries.
- Event log, Python materializer, tri-state freshness, validation and ZIP
  transport are implemented. Accepted events can make derived views stale.

## Product priorities

Planned next technical work is a small shared-vocabulary extraction for component
types, labels/normalization and measurement units, continuing modularization and
real code reuse. This documentation sync authorizes no implementation.

| Priority | Remaining user-visible gap and required outcome |
| --- | --- |
| Deferred product feature | Candidate -> component identity -> confirmed visual placement remains in the backlog, requiring separate authorization and geometry-compatibility decisions. Reuse existing writers; first bind an explicit persistent geometry distinction so confirming a candidate cannot move legacy placements or change its shape. Canonical confirmation is not implemented or authorized here. |
| P1/P2 | Make ZIP acquisition produce an equivalent editable local workspace; current ZIP loading has no local project directory and local candidate edits do not travel in ZIP. Preserve compatibility and user files. |
| P2 | Modernize the nine remaining legacy destination contents in bounded feature tasks, retaining all routes and existing functionality. |
| P2 | Improve Home/resume lifecycle and use project-derived labels. Home currently closes Session; hardcoded examples remain. |
| P2 | Make Wizard background, canonical photo evidence and local reference-image roles clearer while preserving their different evidence and ZIP meanings. |
| Future | Phone capture guidance, photo proposals, visual traces/repair maps, AI next-step suggestions and human-controlled AI memory, subject to PROJECT_MEMORY return conditions. |

## Current behavior and limits

- `ProjectSession.applyCanonicalEvent` composes accepted events and marks stale;
  it does not rebuild known facts. `WorkbenchProjectionRefresh` now offers
  `Värskenda andmeid` for STALE projects. `ProjectProjectionRefresher` invokes the
  existing Python materializer and directory loader; guarded Session adoption
  installs only matching fresh known facts. Errors preserve active state and
  offer retry. This is explicit desktop/local-directory refresh, not background
  materialization. UNKNOWN retains its distinct warning and has no refresh action.
- Wizard and Canvas share candidate UI/geometry. Canvas owns load/save lifecycle
  through `.tracebench_local/component_candidates.json`; original
  `notes/wizard_intake.json` is not rewritten. These editable visual drafts are
  not confirmed components, placements, contacts, measurements or electrical facts.
  Existing-component identity/Placement remains a separate accepted workflow.
- `ProjectLoader.loadFromZipBytes` returns in-memory state without a writable
  `projectDirectory`. Candidate edits in that context are session-only. ZIP
  export excludes local sidecars and retains original optional Wizard intake.
- Home continues an already-open Session but project Home navigation closes it.
  Durable resume is incomplete; launcher/Overview still contain examples such
  as Pelle PV20 and Töölaud nr 1.

## Preserved unrelated draft and protected work

An earlier editor scope draft and its AUDIT_INDEX change remain uncommitted
foreign material. They are preserved, not current implementation authority;
the accepted editor implementation is established by `aaf26da`.

This documentation sync enables no candidate confirmation/migration, automatic
refresh, ZIP acquisition change, camera/AI feature or legacy-page redesign.
Rendering and local drafts do not create truth. AI/photo return conditions:
[PROJECT_MEMORY](PROJECT_MEMORY.md#future-aiphoto-return-conditions).

## History and ownership

The consolidation archives preserve the complete committed operational files
from `69e5bd4`, before the consolidation commit `49c65b9`:

- [Current-state history](archive/CURRENT_STATE_HISTORY_2026-10-29.md)
- [Queue history](archive/PASS_QUEUE_HISTORY_2026-10-29.md)
- [Scope history](archive/ACTIVE_SCOPE_LOCK_HISTORY_2026-10-29.md)

They are historical, not active reservations. Their relative references retain
the original docs/ context. Existing audit evidence remains unchanged.
Product boundaries: POHIKIRI, PROJECT_MEMORY, TRUTH_INDEX and PROTECTED_SURFACES.
Task/protected boundary: ACTIVE_SCOPE_LOCK. Sequence: PASS_QUEUE.
