# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock state

No active implementation lock is armed.

`BENCHBEEP_STARTUP_INTRO_IMPL_PASS` has been closed out by `BENCHBEEP_STARTUP_INTRO_IMPL_POST_AUDIT_PASS`.

## Released implementation allowlist

The following implementation files were recorded as the safe implementation set for the pushed startup intro pass, but they are no longer armed for further edits by this lock:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_splash_screen.dart`
- `test/widget/benchbeep_splash_screen_test.dart`

## Recorded implementation commit

- `3c0f06a1cf29baaeefb4592bd5d159ff61e0b211`
- `feat: add benchbeep startup intro`

## Review status

- `NON_CLAUDE_REVIEW: ACCEPTED_RISK`
- Claude audit skipped/unavailable.
- Reviewer path: GPT/Pro + Gemini advisory + user decision.
- User approved proceeding without Claude after exact allowlist review and local validation.

Do not represent this implementation as Claude-audited.

## Boundary retained

This was launcher presentation only.

- No router changes.
- No `/splash` route.
- No `pubspec.yaml` changes.
- No new assets or packages.
- No font / Space Grotesk work.
- No home lockup refresh.
- No fullscreen implementation.
- No Board Canvas workflow changes.
- No standalone Add/Edit/Measure page edits.
- No writer/schema/materializer/validator/tool changes.
- No canonical event changes.
- No `events.jsonl` / `known_facts.json` semantic changes.
- No `_incoming` runtime reference or staging.
- No duplicate old workflow menu/hub/card.
- No table/form UX regression.

## Product and canonical boundary retained

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- Splash animation creates no facts and writes no events.
- Visual First Board Canvas workflow remains unchanged.
