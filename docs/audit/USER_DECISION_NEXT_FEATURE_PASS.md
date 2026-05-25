# USER_DECISION_NEXT_FEATURE_PASS

Status: completed

Lane: DOCS_SYNC / DECISION_ONLY

## Selected next milestone

- Selected: `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_AUDIT_PASS` (DOCS_SYNC / AUDIT_ONLY)
- Chosen after `FLUTTER_ZIP_EXPORT_POLISH_SCOPE_REVIEW_PASS` completion.
- Rationale:
  - Export handoff stabilization is complete.
  - The product currently depends on imported/prebuilt projects.
  - A new project wizard is the highest-value next milestone.
  - It enables starting from a blank project before:
    - component/pin write flows,
    - repair-action write flow.

## Deferred candidates

- `PROJECT_IMPORT_EXPORT_SMOKE_TEST_PASS`
- `COMPONENT_PIN_WRITE_SCOPE_AUDIT_PASS`
- `REPAIR_ACTION_WRITE_SCOPE_AUDIT_PASS`
- `WINDOWS_RUNNER_SCOPE_LOCK_PASS`
- `FLUTTER_PROCESS_LIFECYCLE_HARDENING_PASS`

## Deferred candidate treatment

- These remain out of scope for this decision pass.
- No implementation was started or planned in this pass.

## Routing alignment

- `USER_DECISION_NEXT_FEATURE_PASS` is completed.
- `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_AUDIT_PASS` is the next recommended implementation-planning pass.

## Forbidden-surface confirmation

- No implementation files modified.
- No tools, schemas, samples, assets, pubspec, or code surface changes in this pass.
