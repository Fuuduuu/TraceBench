# PROMPTING_PROTOCOL_COMPRESSION_PASS

## Status

completed

## Lane

DOCS_SYNC

## Scope

Governance-only prompt protocol and routing compression documentation.

## Files changed

- AGENTS.md
- docs/PROMPTING_PROTOCOL.md
- docs/MODEL_ROUTING.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PROMPTING_PROTOCOL_COMPRESSION_PASS.md

## Validation

- `py -3 tools\validate_all.py` (passed)

## Summary

- Added compact prompt profiles: MINI / GUARDED / AUDIT / DEEP_REVIEW.
- Added sniper prompt skeleton section.
- Added no-repeat and delta-first rules.
- Added reusable prompt fragments.
- Updated routing docs with prompt compression routing guidance.
- Updated AGENTS prompting discipline guidance.

## Confirmation

- No schema/tool/test/sample/asset/Flutter/ZIP/event/known_facts changes.
- `FLUTTER_PHOTO_LIST_SCOPE_AUDIT_PASS` remains next recommended in PASS_QUEUE.
