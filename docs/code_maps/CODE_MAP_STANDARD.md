# TraceBench Code Map Standard

## Purpose and authority

Code maps are repo-local navigation and impact-analysis aids for complex files.
They describe accepted, committed code; they do not define product truth or
authorize implementation.

Code, tests, canonical-owner documents, `docs/POHIKIRI.md`, and active scope
locks outrank every map. A map cannot authorize writes, refactors, new files,
protected-surface changes, test changes, or scope expansion. When a map and its
source disagree, the source wins and the map requires review.

Map maintenance may accompany its authorized source diff and one independent
review; ordinary UI work does not require a standalone map pass.

Maps live under `docs/code_maps/**`. They are task-specific references outside
the default five-file operational read set and are read only when the mapped
file or its impact surface is relevant.

## Deterministic path convention

Mirror the complete repository-relative source path and append `.md`:

```text
<source path> -> docs/code_maps/<source path>.md
lib/example.dart -> docs/code_maps/lib/example.dart.md
test/example_test.dart -> docs/code_maps/test/example_test.dart.md
```

Use the source path's exact spelling and `/` separators. One source file has at
most one current map at its deterministic path.

## Bootstrap v1 scope

Bootstrap v1 covers qualifying Dart production and Dart test files only.
Production and test files qualify independently. A production map may link to
relevant tests without requiring those test files to have maps.

Do not infer that every Dart file needs a map. Python, tools, schemas, generated
artifacts, and other languages are outside bootstrap v1.

## Qualification

Score each candidate file from 0–2 in six dimensions.

| Dimension | 0 | 1 | 2 |
| --- | --- | --- | --- |
| Physical size | Under 800 physical lines | 800–1,499 physical lines | 1,500 or more physical lines |
| Independent responsibilities | 1–2 responsibility zones | 3–4 responsibility zones | 5 or more responsibility zones |
| Canonical / protected boundaries | No canonical or protected boundary | One boundary or one protected read-only surface | Multiple boundaries, or read-only renderer/painter responsibilities and canonical writers coexist in the same file |
| Regression surface | One compact test family | 2 behavior families, or 9–20 focused tests | 3 or more behavior families, more than 20 focused tests, or repeated regression/fix passes |
| Whole-file analysis tax | No recurring whole-file reconstruction | One recent broad analysis | Broad whole-file analysis in 2 or more passes within approximately 90 days |
| Blast-radius ambiguity | One symbol/test path is sufficient to estimate the change | 1–2 adjacent responsibility zones require inspection | 3 or more zones must be reconstructed to estimate safe scope |

A file qualifies when its total score is at least 6 and at least two non-size
dimensions score above 0. Physical size alone never qualifies a file.

Record only the compact result in a map, not the scoring worksheet:

```text
SCORE 8/12 — repeated whole-file analysis and protected-boundary coupling
```

### Automatic qualification

A file qualifies without calculating the score when any one condition is true:

1. More than approximately 5,000 physical lines and at least three independent
   responsibilities.
2. Canonical writer paths and read-only renderer, painter, or UI-local
   responsibilities coexist in the same file.
3. A production file owns five or more independently testable behaviors.
   Count independently owned behavior, not five related calculated properties
   from one cohesive resolution contract. Apply the small-cohesive-adapter
   exclusion before treating returned fields or shape branches as separate work.
4. A test file exceeds approximately 3,000 lines and contains at least three
   test families.
5. Repeated scope mistakes occurred because agents treated the file as one
   undifferentiated surface.
6. Protected-boundary audits repeatedly require whole-file reconstruction.

Record only compact metadata, for example:

```text
AUTO — >5000 lines + 3+ responsibilities
```

### Human override

A smaller file may receive a map when the human determines that:

- it is repeatedly involved in protected-boundary mistakes;
- its blast radius is disproportionately difficult to estimate;
- multiple callers treat it differently;
- its tests are scattered across several suites; or
- recurring dependency misunderstandings have caused regressions.

Record the human-approved reason in the map's `Qualification` field.

### Exclusions

Do not require maps for:

- every Dart file;
- generated or vendored code;
- simple data holders with one clear owner;
- small cohesive adapters;
- files already fully explained by an exact schema and cohesive implementation;
- temporary or unfinished local diffs;
- files about to be removed, unless still active and hazardous; or
- formatting-, import-, or simple-copy-only changes.

## Standard map template

Use stable symbol names and responsibility zones as anchors. Never maintain line
numbers. Keep zones independently meaningful and list no more than 12.

```markdown
# Code Map: `<source path>`

- Source: `<repository-relative path>`
- Type: `production` or `test`
- Status: `MAINTAINED` or `REVIEW_REQUIRED`
- Qualification: `<SCORE, AUTO, or human override with compact reason>`
- Audit evidence: `<relevant durable audit path, or none>`

## File purpose
<One compact paragraph.>

## Responsibility zones
| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |

## State and data flow
<Inputs, transformations, ownership transitions, and outputs.>

## Direct dependencies
| Dependency | Direction | Purpose |
| --- | --- | --- |

## Write and protected boundaries
| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |

## Zero-write zones
<Symbols that render, inspect, or propose without canonical mutation.>

## Impact matrix
| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |

## Relevant tests and helpers
<Direct tests, fixtures, harnesses, and helpers.>

## Dangerous combinations
<Cross-zone edits that increase regression or protected-boundary risk.>

## Safe SNIPER slices
<Single-zone change slices with named symbols and focused tests.>

## Future extraction seams
<Descriptive, non-authorizing candidates only.>

## Freshness and review triggers
<Mapped semantic changes that require review.>

## Known uncertainty
<Unverified or incomplete claims, with evidence class.>
```

## Impact evidence classes

Tag impact claims in maps and SNIPER packets:

| Class | Meaning |
| --- | --- |
| `[D]` Direct | Demonstrated by the mapped source, test, or explicit call path. |
| `[P]` Probable secondary | Strongly implied by an adjacent dependency or behavior, but not directly demonstrated. |
| `[H]` Historical risk | Supported by durable audit or regression history. |
| `[S]` Speculative | A hypothesis requiring verification before it affects scope. |

Speculation cannot authorize scope, files, refactors, protected changes, or
mandatory tests.

## Write-class vocabulary

| Write class | Meaning |
| --- | --- |
| `ZERO_WRITE` | Read, render, inspect, navigate, or propose without persistent state mutation. |
| `UI_LOCAL` | Mutates only transient UI state. |
| `PROJECTION_STATE` | Mutates derived or rebuildable projection state, not canonical facts or events. |
| `CANONICAL_EVENT` | Appends or changes a canonical event/fact write path. |
| `NONCANONICAL_FILE` | Writes a file that is not a canonical event/fact store. |

Assign a write class only from actual call-path evidence. UI labels, button
copy, intent, or appearance are not write evidence. If the call path is not
verified, record uncertainty rather than upgrading the class.

## Prompt and SNIPER integration

Use maps where they help bound ownership. Source, tests and canonical contracts
remain primary. A missing/stale map alone does not block a small presentation
change whose actual behavior and scope are verified from targeted source.

For ordinary copy/style/layout work, no standalone qualification worksheet,
CODE_MAP_PREFLIGHT report, registry promotion or maintenance child is mandatory.
Import/format/copy-only changes with unchanged mapped semantics need no update.

For complex or protected work, name exact changed symbols, actual write class,
coupled/frozen boundaries and relevant tests. Consult current maps where useful
and independently verify protected claims. If a map is missing or stale, use
bounded source/caller/test closure, and update genuinely material drift in the
same authorized task and diff review. Do not waive protected source verification
or silently add map paths outside an exact allowlist.

Formal preflight can retain REVIEWED_NO_CHANGE / UPDATE_REQUIRED /
NOT_APPLICABLE dispositions. A qualifying owner can need a map, but creating
it is not automatically a separate preliminary project. Report a specific
BLOCKED_CODE_MAP_REQUIRED / STALE / CONFLICT condition only when unresolved
ownership affects the permitted boundary or safety of protected data, rather
than turning a harmless presentation edit into a bookkeeping loop.

An actual unauthorized scope expansion still stops with
BLOCKED_ALLOWLIST_MISMATCH. Unrelated responsibility zones are not silently
combined; the human task decision must cover the changed work.

## Update and drift policy

Maps describe accepted source and may be updated with the exact bounded source
diff being reviewed. Review source/map together before the human commit; do not
document speculative unfinished designs as accepted behavior. This replaces the
old blanket requirement for a later standalone committed-source maintenance pass.

Review for actual symbol/ownership, data flow, dependency, write-boundary or
test-coverage drift. Do not rewrite maps for line movement or harmless copying.
Keep unrelated/RETIRED maps and historical evidence intact.

Use MAINTAINED when the map has been verified against the named baseline/final
task source; it is a content-freshness label, not audit/staging acceptance.
Use REVIEW_REQUIRED for unresolved material drift. Restore a verified pair in
the same bounded task/review when authorized; no separate status-recording pass
is mandatory for ordinary changes. Explicit existing formal recording contracts
still preserve their designated coordinates and history.

Use RETIRED only for an actual map retained as history after its source or map
is intentionally retired. The index lists actual map files only.

Retain drift labels SYMBOL_DRIFT, FLOW_DRIFT, BOUNDARY_DRIFT, TEST_DRIFT and
STRUCTURE_DRIFT where useful. Do not create a map for file novelty, related
calculated outputs, or a small cohesive adapter fully explained by its contract.

## Claude map-audit model

The independent reviewer compares the map with the named committed baseline and
actual authorized source/test diff, canonical owners, and active boundaries.
For a dedicated Code Map audit, Claude performs this read-only comparison. The audit
checks stable symbols, responsibility ownership, flows, direct dependencies,
write classes, protected boundaries, zero-write zones, linked tests, evidence
labels, speculation handling, non-authorization, and concision.

For an explicitly requested dedicated map audit (not every minor UI diff), return:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
```

## Concision and prohibited content

Production maps target 150–250 lines. Test maps target 120–220 lines. Above 300
lines, consolidate the map or record a human-approved exception. Use at most 12
responsibility zones. Do not provide method-by-method walkthroughs.

A map must not contain current route state, commit identifiers, PASS_IDs, audit
verdicts, staging instructions, or active allowlists. It must not prescribe a
refactor or turn an extraction seam into authorized work.
