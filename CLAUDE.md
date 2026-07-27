# Claude Code orientation

TraceBench is the local-first PCB repair workbench; BenchBeep is the product and BoardFact is its data-fact subsystem.

Read `AGENTS.md` first, then follow its exact five-file default read set in order before acting.

Never infer route, PASS_ID, allowlist, HEAD, branch divergence, staging state,
validation results, or test counts from memory, summaries, or earlier chats.
Re-read every one from the live worktree and Git at each use; stop on conflict.

Follow the Git-discipline rules owned by `AGENTS.md`.
