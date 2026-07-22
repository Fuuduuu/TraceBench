# Current State

Current pass: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`
Next recommended pass: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`

The current pass is a Lane B docs-only protected-surface scope lock. It may
change only the four operational/audit docs plus its new audit artifact; it
does not implement `board_outline_confirmed`, projection, writer, Project ZIP,
or wizard behavior.

## Locked direction

The human selected one project-level, human-confirmed Visual/Layout fact:
`board_outline_confirmed`. It uses normalized board geometry, optional paired
physical dimensions, explicit supersession, and conflict projection with no
latest-wins rule. It never establishes electrical, component, pin, placement,
measurement, diagnostic, photo, template, or AI-authored truth.

The exact event, geometry, supersession, projection, atomicity, allowlist, and
stop contracts are locked in `docs/ACTIVE_SCOPE_LOCK.md` and recorded in the
current audit artifact. The current V1 blank-project wizard contract remains
unchanged.

## Activation gate

The reserved implementation is not executable from this working-tree draft.
It becomes eligible only after independent Claude Code acceptance with
`SAFE_FOR_STAGING: YES`, exact human staging/commit/push of the accepted scope
lock, and a no-drift gate. No active-lock-sync pass is allowed or required.
