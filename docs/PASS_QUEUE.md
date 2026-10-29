# Pass Queue

Current: `NEEDS_USER_DECISION`
Next: `SHARED_VOCABULARY_EXTRACTION`

## Immediate sequence

Projection refresh (`46ce43e`), shared candidate editor (`aaf26da`), standalone
Navigator (`10c63ce`) and Placement template/preview extraction (`db1003f`) are
committed implementation, not pending queue items. Documentation consolidation
(`49c65b9`) is also completed; do not restart it.

The planned next technical work is a small shared-vocabulary extraction for
component types, labels/normalization and measurement units, continuing
modularization and real code reuse. This documentation sync authorizes no code.

Candidate -> component identity -> confirmed visual placement continuity is a
deferred product feature, not the next technical task. Local candidate editing/persistence is
already available. Before canonical confirmation, an explicit protected human
task must settle persisted geometry compatibility and reuse the accepted
Components/Placement writers without moving existing placements. This queue
reserves no implementation, migration, scope-lock child or architecture review.

Other product backlog items remain under the priority owner: editable ZIP
acquisition, legacy destination content, Home/resume and photo-role clarity.
Selection of the next executable task remains with the human.

## Priority owner

[CURRENT_STATE product priorities](CURRENT_STATE.md#product-priorities) is the
single product-order list. Do not duplicate historical pass descriptions or
maintain a competing roadmap here.

## Execution policy

- Ordinary low-risk UI: compact task boundary -> implementation/focused tests
  -> human visual review where applicable -> one independent diff review
  -> exact human commit.
- Protected data/canonical work: explicit protected scope, regression/recovery
  evidence and independent review remain mandatory. New/changed canonical,
  writer, migration or ZIP contracts need the formal protected scope gate.
- Material map corrections belong with their bounded task and review, not an
  automatic maintenance/verdict-recording programme.
- No automatic RECON, architecture review or follow-up pass. Escalate only a
  named protected-data/scope conflict or actual technical blocker.

## Deferred and preserved

Candidate confirmation, persisted-geometry changes, ZIP workspace acquisition,
durable resume and future AI/capture remain unimplemented priorities; this queue
authorizes none of them. The two foreign editor-draft documents remain outside
this task and any proposed commit set.

## History

[Complete committed queue snapshot](archive/PASS_QUEUE_HISTORY_2026-10-29.md)
preserves the pre-consolidation committed queue at `69e5bd4`. It excludes the
unaccepted editor scope draft and is not an executable backlog.
