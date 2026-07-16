# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Lock state

No documentation or implementation write authority is active. The
`TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS` authority was released after
the accepted and pushed governance amendment
`f5c34dc776ec1380c13c47053b0ff535e25ad1fa`
(`docs: integrate code maps into prompting governance`). Claude returned
`ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; blockers none; nits none.

Accepted chain:

- scope lock `5a9098016efe057b8e64145117dd79778a2a5f69`;
- scope-audit reconciliation `7dd21a13f77f6e663d8e04de968043c67b3ec5be`;
- governance amendment `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`.

## Preserved governance boundaries

- `TOOL_SKILL_CHECK` is mandatory for every Codex `PASS_ID` prompt and final
  report; capability selection never expands write authority.
- `CODE_MAP_PREFLIGHT` is conditional on relevant Dart production/test work
  and reports evidence rather than granting scope.
- `CODE_MAP_STANDARD.md` remains the sole detailed map lifecycle owner; other
  owners retain only their prompt, routing, audit, or loading responsibilities.
- Maps narrow investigation only. Source, tests, canonical owners,
  `docs/POHIKIRI.md`, and active authority outrank them.
- The default read set remains exactly five files; map standard/index and
  source-specific maps remain task-specific and on-demand.

No code map, Board Canvas test-file map, measurement file-lock hardening,
overview retirement, runtime/test/schema/tool/package/asset change, generator,
linter, CI, hook, watcher, `_incoming` work, route/product/protected behavior,
active-lock sync, or implementation pass is authorized. Future work requires a
new human decision and an exact allowlist.

Closeout evidence:
`docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS.md`.
