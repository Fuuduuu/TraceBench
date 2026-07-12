# Current State

Current pass: `TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS`

## Charter and pushed baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop authority.

Verified pushed baseline: `f858a0e7c2e87c827f553ab1476be1547d3416b1` (`docs: close out component category navigator`).

## Active objective

This docs-only pass locks a repo-local, task-specific code-map standard under future `docs/code_maps/**`. Maps will be descriptive, symbol-anchored, committed-state-only navigation and impact evidence. They will not be canonical runtime truth and cannot authorize writes, refactors, protected changes, files, or scope.

The next bootstrap pass may create exactly:

- `docs/code_maps/CODE_MAP_STANDARD.md`
- `docs/code_maps/CODE_MAP_INDEX.md`

No production or test code map is authorized yet. The standard bootstrap and the first production map remain separate passes.

## Boundaries and evidence

Code maps remain outside the five-file default read set and load only for the exact mapped task. Bootstrap v1 is Dart-focused; production and test maps qualify independently; the index lists actual maps only. Later mapped-file work reports `REVIEWED_NO_CHANGE`, `UPDATE_REQUIRED`, or `NOT_APPLICABLE`.

No runtime, test, schema, tool, `_incoming`, Board Canvas map, prompting-constitution, automatic lint/tooling, refactor, or `docs/FILE_MAP.md` change is open.

Detailed scope evidence: `docs/audit/TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS.md`.
