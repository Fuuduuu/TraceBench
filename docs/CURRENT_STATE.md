# Current State

Current: `DOCS_WORKFLOW_CONSOLIDATION`
Next: `P1_WORKBENCH_PROJECTION_REFRESH`

Runtime baseline: `69e5bd4112c478ac904f1da70c40018325da53cf`.
This human-authorized task changes documentation only. The next entry is a
product priority, not implementation authority or a reserved child pass.

## Implemented and accepted

- Seven-step New Project Wizard, local project creation and folder loading.
- Board Canvas as the primary warm black/gold Workbench; compact project-menu
  navigation preserves all twelve destinations. Photos and Overview share the
  visual foundation; remaining legacy destination content is not fully modernized.
- Existing Components, Placement, Measurement, Inspector and photo workflows
  use their accepted owner modules and canonical writers.
- Shared Wizard-to-Canvas candidate geometry preserves the reference-frame
  pose, shape and rotation. Shared Geometry source is committed at `7c45429`;
  its accepted map maintenance is committed at the runtime baseline.
- Event log, materializer, project validation and ZIP transport exist. A saved
  event can be present in Session while known_facts-driven views remain stale.

## Product priorities

| Priority | User-visible gap and required outcome |
| --- | --- |
| P1, first | Provide an explicit safe Workbench projection refresh using the existing materializer and guarded reload, without requiring ZIP export. Preserve events, project identity and stale-result guards. |
| P1 | Share one ComponentCandidateEditor between Wizard Step 4 and Canvas; allow existing candidates to be selected/edited and new ones drawn. Preserve original identity/geometry and local durable drafts. |
| P1 | Join candidate -> component identity -> confirmed visual placement into a continuous technician workflow. Reuse canonical writers; resolve a persistent geometry distinction before confirmation so old placements do not move. |
| P1/P2 | Make ZIP acquisition produce an equivalent editable local workspace rather than only an in-memory view; preserve ZIP compatibility and avoid overwriting user files. |
| P2 | Improve Home/resume lifecycle and replace hardcoded project labels with project-derived identity. Home currently closes the active Session. |
| P2 | Clearly distinguish Wizard background, canonical photo evidence and local reference images in the UI, preserving their different evidence and ZIP meanings. |
| Future | Phone capture guidance, photo candidate proposals, visual traces/repair maps, AI next-step suggestions and technician-controlled AI memory, subject to the return conditions in PROJECT_MEMORY. |

## Current gaps and source evidence

- `ProjectSession.applyCanonicalEvent` appends accepted in-memory events and
  marks stale; it does not regenerate knownFacts.
- `ProjectExporter.exportProjectZip` materializes before export, and the report
  screen reloads afterward. That coupled path is not the requested standalone
  Workbench refresh.
- `ProjectLoader.loadFromZipBytes` builds an in-memory ProjectState without a
  local projectDirectory, unlike directory loading.
- Wizard candidates remain read-only on Canvas. The old purple Add preview
  also supplies canonical Placement anchors; replacing candidate editing must
  preserve the separate existing-component Placement flow.
- Home's continue action uses an already-open Session; Home navigation closes
  it. Durable resume is incomplete. Launcher/Overview still include hardcoded
  examples such as Pelle PV20 and Töölaud nr 1.

## Preserved draft and deferred work

A ComponentCandidateEditor scope draft was prepared but was not independently
accepted or committed. Its contents may inform future work, but do not authorize
implementation. The draft and its audit-ledger change remain preserved outside
the documentation-consolidation commit set.

No candidate confirmation/migration, automatic projection rebuilding, ZIP
acquisition change, camera/AI feature or legacy-page modernization is enabled
by this documentation task. Rendering and candidates do not create truth.
AI/photo return conditions: [PROJECT_MEMORY](PROJECT_MEMORY.md#future-aiphoto-return-conditions).

## History and ownership

The complete committed operational files from the stated baseline are
byte-preserved historical snapshots:

- [Current-state history](archive/CURRENT_STATE_HISTORY_2026-10-29.md)
- [Queue history](archive/PASS_QUEUE_HISTORY_2026-10-29.md)
- [Scope history](archive/ACTIVE_SCOPE_LOCK_HISTORY_2026-10-29.md)

Snapshots are not current authority. Their relative references retain the
original docs/ context. Previous audit verdicts remain in AUDIT_INDEX/audit.
Product boundaries: POHIKIRI, PROJECT_MEMORY, TRUTH_INDEX and PROTECTED_SURFACES.
Task boundary: ACTIVE_SCOPE_LOCK. Sequence: PASS_QUEUE. Do not reload history
unless an exact decision or evidence reference is needed.
