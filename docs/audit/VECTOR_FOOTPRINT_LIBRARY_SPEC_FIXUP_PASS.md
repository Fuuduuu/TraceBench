# VECTOR_FOOTPRINT_LIBRARY_SPEC_FIXUP_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only fixup

## Gate check

- Required commits present:
  - `docs: specify vector footprint library`
  - `docs: lock vector footprint library scope`
  - `docs: review queue after status semantics`
- Working tree contained only pre-existing untracked local files outside pass scope.

## Fixups applied

1. Added explicit human-facing identity leakage guardrails:
   - `template_id`, `display_name`, `description`, `package_family`, accessibility labels, and style labels must not assert electrical identity as confirmed truth.
2. Added unknown fallback policy:
   - `unknown_rect`, `unknown_2pin`, `unknown_3pin`, `unknown_multi_pin`.
3. Locked template-local coordinate convention:
   - normalized units,
   - default center origin,
   - `x` right,
   - `y` down,
   - shared frame across bbox/anchors/orientation/hit-test.
4. Tightened field semantics for:
   - `origin`
   - `bounding_box`
   - `pin_count_rules`
   - `allowed_variants`
   - `default_style_tokens`
   - `lod_hints`
   - `hit_test_shape`
5. Clarified pin anchor non-fact semantics:
   - geometric-only anchors,
   - no implicit/automatic `pin_defined` facts.
6. Clarified variant relationship constraints:
   - bbox/extents behavior,
   - label-anchor placement expectations,
   - deterministic expansion,
   - preserved template/identity separation.
7. Expanded implementation-readiness test expectations:
   - naming policy,
   - identity-neutral text,
   - unknown fallback presence,
   - coordinate consistency,
   - metadata-only field handling,
   - forbidden evidence/identity fields.
8. Updated next routing:
   - `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS`.

## Scope confirmation

- Docs-only edits in allowlisted files.
- No schema/tool/test/runtime/sample/asset/ZIP contract changes.
