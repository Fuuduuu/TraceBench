# MODEL_ROUTING.md

## Purpose

Define when a task can be handled by Codex directly, when it needs deep reasoning review, and when explicit user approval is required before any implementation.

## Prompt compression routing

- Prompt protocol changes are `DOCS_SYNC` governance work.
- Compact prompts are allowed only when canonical docs are current.
- Sensitive/protected/risk work still requires deep review or user decision.
- Compact prompt form must not skip:
  - exact write allowlist
  - forbidden surfaces
  - validation
  - MODEL_ROUTING_CHECK
  - stop conditions

## Scope drift check routing

- If scope drift check returns `NEEDS_SMALL_FIXUP`, run a docs fixup before implementation.
- If scope drift check returns `NEEDS_DECISION`, ask the user before proceeding.
- If scope drift check returns `NEEDS_DEEP_REWORK` or `REJECT_REWORK`, do not send to Codex.
- If scope drift check returns `REJECT_SCOPE_ESCAPE` after implementation, revert or narrow to scope and rerun the check.

## Model roles

- **Codex appropriate when**:
  - deterministic repo edits
  - schema/test/tool/doc changes using exact write allowlist
  - validator fixes
  - small implementation passes with already-locked scope
  - applying accepted decisions from prior passes

- **Claude/GPT Pro / deep reasoning appropriate when**:
  - architecture decisions
  - scope boundary decisions
  - "should we do this?" questions
  - security/privacy/risk review
  - evidence/provenance policy changes
  - AI behavior/prompt/safety rules
  - complex audits
  - source/legal/freshness research
  - ambiguous tradeoff decisions
  - any protected surface is conceptually implicated before edits

- **User decision required when**:
  - task changes product direction
  - task opens V1.0-forbidden features
  - task changes local-first/privacy assumptions
  - task changes evidence-floor rules
  - task changes event semantics
  - task requires external API/provider commitment
  - task has unclear owner/model

## Mandatory escalation rule

If Codex classifies a task as **Claude/GPT Pro** or **User decision**, Codex must: 
- stop all edits
- emit `ROUTE_TO_DEEP_REVIEW`
- include:
  - `reason`
  - exact `question to ask`
  - `files/surfaces at risk`
  - statement `no code changes made`

## Routing table

| Task type | Codex | Claude/GPT Pro | User decision | Notes |
|---|---|---|---|---|
| deterministic text/content update in allowed files | ✅ |  |  | Use exact PASS allowlist and validation commands. |
| schema/test/tool runtime code edits | ✅ |  |  | Only with exact write allowlist and no protected-surface change. |
| validator/`validate_all`/Makefile flow bug fixes | ✅ |  |  | Keep behavior deterministic and scoped. |
| architecture/docs-governance design |  | ✅ |  | Requires reasoned justification and impact analysis. |
| scope boundary / Active Scope Lock change |  | ✅ | ✅ if includes product direction change | Prefer explicit PASS for scope moves. |
| evidence-floor policy edits |  | ✅ | ✅ | Includes AI behavior/prompt/security assumptions. |
| protected surface behavior change |  | ✅ | ✅ | Requires dedicated protected-surface pass first. |
| external API/provider commitment |  |  | ✅ | External contract and costs/risks need explicit approval. |
| feature that may introduce forbidden domains |  |  | ✅ | Flutter/OCR/AI integration/fault probability/source search/boardview/Cloud sync and similar. |
| ambiguous assignment or unclear ownership |  |  | ✅ | Ask for routing choice before edits. |

## Docs-only drift cleanup rule

- `DOCS_SYNC` passes that touch only governance and spec files without semantic changes can proceed with Codex.
- `SCHEMA_PASS` changes that affect event semantics still require the existing deep-review gate and prechecks before implementation.
- Flutter implementation passes are considered successful only when repository Flutter validation (`flutter test`) is included in the pass verification flow.
