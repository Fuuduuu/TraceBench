# Code Map: `lib/features/photos/screens/photo_list_screen.dart`

- Source: `lib/features/photos/screens/photo_list_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable recovery, freshness, ordered records, mode and visual-metadata behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Read-only Photo Evidence destination. It watches projection and display mode,
opts into the shared frame, preserves recovery/freshness and presents ordered
photo records with photoId-matched damage/suspect/visual-trace details.
It shows path/metadata text; it does not load image bytes, import, align,
confirm evidence or invoke writers. PhotoWorkbenchPanel remains separate.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Project/mode entry | `PhotoListScreen`, `projectStateProvider`, `beginnerModeProvider`, `No project loaded` | Read inputs and retain null-state meaning. |
| Frame/empty/freshness | `WorkbenchPage`, `CustomScrollView`, `primary: false`, `ProjectionStaleBanner`, `SliverFillRemaining`, `Fotosid ei leitud` | Local Theme, bounded caller scroll, one banner and no record Card when empty. |
| Ordered list | `SliverList.separated`, `knownFacts.photos`, `_PhotoCard` | Preserve projection order and lazy record composition. |
| Metadata joins | `damageRegions`, `suspectRegions`, `visualTraces`, `region.photoId == photo.photoId`, `trace.photoId == photo.photoId` | Match each visual-metadata family to this photo only. |
| Beginner summary | `isBeginnerMode`, `photo-summary-`, `Fail puudub`, `Kahtlaste piirkondi:` | Mode/path and grouped counters; raw detail hidden. |
| Advanced detail | `Foto ID:`, `photo.sourceDevice`, `affectsComponents`, `region.priority`, `visual evidence only` | ID/layer/source, optional notes/links/priority and visual-only trace text. |
| Warm hierarchy | `WorkbenchColors.signal`, `WorkbenchColors.muted`, `Wrap`, `DecoratedBox` | Local headings, one plain path Text and wrapping counts; no page AppBar. |

## Anchor inventory and verification

Extract backtick tokens from the responsibility-table anchor column,
deduplicate in first-appearance order and check exact source substrings.
Tokens can be explicit consumer references; no line-number anchors are used.

## State and data flow

1. build watches loaded state and beginner mode. Null returns retained
   recovery Text inside WorkbenchPage.
2. Loaded state supplies freshness and knownFacts. Exactly one shared banner
   is composed before the record list; fresh paints no warning.
3. Empty photos show a fill-remaining message with no record Card. Nonempty
   SliverList preserves order and builds cards lazily.
4. Each card filters all three visual families by exact photoId equality.
   Unrelated metadata is absent from both counters and details.
5. Beginner mode shows mode/path-or-missing copy and counts. Advanced adds
   ID/layer/source and nonempty optional detail groups.
6. Path stays one plain Text run; no tap opens or reads a file.
7. Shared Theme/frame is presentation only; no provider is assigned.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Project/mode providers | read input | Loaded projection and independent display mode. |
| KnownFacts/PhotoFact | read models | Ordered photos and visual relationships. |
| ProjectionStaleBanner | child | Existing fresh/stale/unknown meaning. |
| WorkbenchPage | presentation | Local warm Theme, bounded content and scroll seam. |
| WorkbenchColors | values | Headings, secondary text, panels/counts. |
| Flutter sliver/layout | framework | Lazy records, empty state and wrapping detail. |

## Write and protected boundaries

| Flow | Write class | Evidence |
| --- | --- | --- |
| Provider/metadata reads | `ZERO_WRITE` | watch/filter/derive only. |
| Text/list/card/detail | `ZERO_WRITE` | No writer, router, IO or action callback. |
| Viewport scroll | `UI_LOCAL` | Framework presentation state only. |
| Visual wording | `ZERO_WRITE` | No promotion to measured electrical facts. |

A displayed path is metadata, not imported evidence. No event/fact/Session
mutation, alignment, file access or ZIP operation originates here.
Advanced visibility is presentation, not a new truth/write path.

## Zero-write zones

- Recovery, empty/freshness, record order and every card branch.
- Matching relationships, counters and optional raw detail.
- Theme/path presentation; scrolling changes only local viewport state.

## Impact matrix

| Zone | Evidence | Inspect-only coupling | Class | Tests |
| --- | --- | --- | --- | --- |
| Entry | [D] null/loaded branch | provider/frame | `ZERO_WRITE` | recovery/isolation |
| Empty/freshness | [D] shared banner before slivers | banner/projection | `ZERO_WRITE` | tri-state empty cases |
| Metadata/order | [D] filters/indexed list | read models | `ZERO_WRITE` | counters/wrong-photo exclusion |
| Mode/detail | [D] explicit branches | mode/visual wording | `ZERO_WRITE` | both modes/all optional fields |
| Path/summary | [D] plain Text/Wrap | Theme/frame | `ZERO_WRITE` | long-path/scale/scroll |
| Local Theme | [D] WorkbenchPage | Shell/global fallback | `ZERO_WRITE` | parent isolation/E2E |

## Relevant tests and helpers

- photo_list_screen_test.dart contains eleven declarations generating twenty
  cases from seeded projection and mode, without real product writes.
- Photos/freshness integration suites retain routed record/warning coverage.
- Page/theme tests own deeper role/capture/scroll evidence.
- Shell owns project navigation and exact current-page context; this feature
  does not recreate chrome or another primary workflow.

## Dangerous combinations

- Changing joins and counters together can conceal wrong-photo matches.
- Splitting path Text breaks exact copy/long-path regressions.
- Reintroducing a local AppBar duplicates global navigation.
- Moving the banner inside nonempty cards hides empty-state freshness.
- Interpreting visual traces as electrical measurements changes semantics.
- Adding import/edit/file actions changes the zero-write boundary.

## Safe SNIPER slices

- One mode field: exact branch/fixture and visible/hidden assertions.
- One join: photoId filter, count and unrelated-row exclusion.
- Empty/freshness: sliver composition and all three states.
- Presentation: shared roles, plain path and width/scale scroll case.

## Future extraction seams

- [S] Per-photo card presentation is cohesive and remains private.
  No workflow migration or additional module is prescribed.

## Freshness and review triggers

Review provider inputs, relationship filters, fields/labels, mode conditions,
banner placement, plain path and scroll/frame boundaries. New callback/writer/
IO paths require direct boundary review rather than a read-only UI label.

## Known uncertainty

- [D] This screen lists metadata; it does not render/verify actual images.
- [D] Widget fixtures do not independently audit import or writer internals.
