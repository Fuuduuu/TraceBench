# EVENT_LOG_SPEC.md

Event log is append-only. Every fact/change is an event.

Required envelope fields:

- schema_version
- event_id
- project_id
- sequence
- created_at
- actor
- event_type
- status
- payload

No event may silently overwrite history.
