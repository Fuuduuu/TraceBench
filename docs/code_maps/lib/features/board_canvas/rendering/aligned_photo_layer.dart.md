# Code Map: `lib/features/board_canvas/rendering/aligned_photo_layer.dart`

- Source: `lib/features/board_canvas/rendering/aligned_photo_layer.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — independently testable path loading, image metadata/hash, raster transform, async refresh and verified-layer presentation`
- Audit evidence: `none`

## File purpose

Owns read-only project-photo asset loading and aligned raster presentation.
The loader validates containment, decodes intrinsic dimensions and hashes bytes.
The stateless layer applies a photo-to-board transform while retaining intrinsic
raster size. An additional stateful wrapper loads/verifies event-backed assets;
current Board Canvas instead loads centrally and passes assets directly.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Asset contract | `AlignedPhotoAssetException`, `AlignedPhotoAsset`, `AlignedPhotoAssetLoader` | Typed failures and immutable file/dimensions/digest input seam. |
| Safe local loading | `LocalAlignedPhotoAssetLoader`, `load`, `_isAbsolute`, `_containsDotSegment`, `_isContained` | Validates project/photo paths and resolves contained regular-file input. |
| Image metadata/hash | `instantiateImageCodec`, `getNextFrame`, `sha256.convert`, `dispose` | Reads bytes, obtains positive intrinsic dimensions, hashes and disposes decode resources. |
| Missing/unsafe warning | `AlignedPhotoUnavailableWarning`, `board_canvas_aligned_photo_warning` | Pointer-ignored nonblocking failure presentation. |
| Image injection | `AlignedPhotoImageBuilder`, `_defaultAlignedPhotoImageBuilder`, `Image.file` | Default file rendering or injected test image at intrinsic dimensions. |
| Raster matrix/layout | `AlignedPhotoLayer`, `Matrix4.identity`, `setEntry`, `OverflowBox`, `ClipRect`, `IgnorePointer` | Scales normalized output to board viewport, preserves photo basis, clips and ignores input. |
| Project wrapper lifecycle | `ProjectAlignedPhotoLayer`, `_ProjectAlignedPhotoLayerState`, `didUpdateWidget`, `_refresh` | Caches/replaces an asset Future on relevant identity/dependency changes. |
| Verified wrapper render | `FutureBuilder`, `expectedSha256`, `boundedSolution`, `solvePhotoAlignment` | Handles loading/errors, checks digest and intrinsic point bounds before rendering. |

## State and data flow

1. [D] The local loader accepts directory and relative photo path, requires
   safe `photos/` syntax, an absolute root and no root dot-segments.
2. [D] It resolves the existing root, requires a directory, constructs the
   candidate, requires a regular file without following its final link, and
   verifies the resolved candidate remains under the resolved root.
3. [D] It reads bytes, decodes the first frame, checks positive dimensions and
   hashes exactly those bytes. Frame image and codec are disposed in finally.
4. [D] Success returns a File, width, height and digest. Exceptions become a
   typed asset error; no repair, copy, event or project write occurs.
5. [D] `AlignedPhotoLayer` multiplies the transform's x row by board width and
   y row by board height, including translations, to form a Matrix4.
6. [D] Layout is board-sized ClipRect -> IgnorePointer -> clamped Opacity ->
   unbounded top-left OverflowBox -> top-left Transform -> intrinsic SizedBox.
   Raster size therefore remains photo-sized before the matrix is applied.
7. [D] The default builder uses `Image.file` with intrinsic size, fill fit,
   gapless playback and medium filtering. Tests can supply an image builder.
8. [D] `ProjectAlignedPhotoLayer` creates a Future in initState and replaces it
   on project ID/directory, alignment ID, source path/digest or loader change.
   Opacity/image-builder changes rebuild without an asset reload.
9. [D] Wrapper error returns a warning; pending data yields an empty SizedBox.
   Loaded data requires a matching non-null source digest and a successful
   bounded re-solve with actual dimensions before `AlignedPhotoLayer` mounts.
10. [D] Current Canvas bypasses this wrapper: it uses the local loader in its
    host and passes a bounded primary solution directly to the stateless layer.
    The photo panel uses the loader again before explicit confirmation.

## Raster and identity contract

- The matrix maps intrinsic photo pixels to normalized board coordinates, then
  to current board viewport pixels.
- Opacity is clamped into 0..1; clipping remains at the board viewport.
- IgnorePointer prevents the photo from intercepting Canvas interactions.
- This file applies no electrical semantics, component selection or Wizard fit.
- The alternate wrapper checks digest and current dimensions; stateless
  `AlignedPhotoLayer` trusts the asset/solution supplied by its caller.
- Relative-path syntax and filesystem containment are distinct checks.
  A safe-looking path is not evidence that the resolved file exists or is safe.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:io` | local read API | Path resolution, regular-file inspection and bytes. |
| `dart:ui` | image decoder | First-frame dimensions and decode-resource lifecycle. |
| `crypto` | hash primitive | SHA-256 of loaded bytes. |
| Flutter Material/layout | renderer | Widget matrix, opacity, clipping, image and warning. |
| `photo_event_read_model.dart` | input/helper | Safe relative path and typed event-backed alignment. |
| `photo_alignment_transform.dart` | pure math | Solution matrix and optional bounded wrapper re-solve. |
| `BoardCanvasScreen` | production consumer | Loads primary asset centrally and mounts the stateless layer. |
| `PhotoWorkbenchPanel` | production loader consumer | Fresh image validation before explicit confirmation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| loader/path/hash/decode | `ZERO_WRITE` | [D] Reads files and metadata; never creates, deletes or repairs project files. |
| raster and warning rendering | `ZERO_WRITE` | [D] Pure widget presentation with pointer ignoring. |
| wrapper asset Future replacement | `UI_LOCAL` | [D] Transient widget loading state only. |
| digest/bounded solve | `ZERO_WRITE` | [D] Verifies rendering input without event/fact mutation. |

No writer, session provider, canonical append or materializer is imported.
An aligned image is presentation of supplied geometry, not newly confirmed
evidence. Current callers own canonical identity selection and human intent.

## Zero-write zones

- Containment/stat/read/decode/hash and error conversion.
- Matrix creation, intrinsic layout, opacity, clipping and warning.
- Hash comparison and re-solving stored pairs against actual dimensions.
- Resource disposal releases image decoder objects, not project files.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Loader safety | [D] root/candidate resolution | path helper and host primary input | `ZERO_WRITE` | no direct real-loader unit test identified |
| Intrinsic metadata | [D] decoded dimensions/hash | confirm byte-check and bounded solve | `ZERO_WRITE` | injected changed-byte/bounds integration |
| Matrix/raster basis | [D] viewport scaling plus intrinsic SizedBox | solver and Board stack | `ZERO_WRITE` | intrinsic landscape/portrait Board cases |
| Clip/pointer/opacity | [D] widget wrappers | Canvas hit testing and layer controls | `ZERO_WRITE` | layer/reopen/widget geometry cases |
| Wrapper lifecycle | [D] explicit reload predicate | alignment/source identity | `UI_LOCAL` | no direct wrapper test identified |
| Verified wrapper render | [D] digest and bounded solve | read model/solver | `ZERO_WRITE` | solver/read-model units; wrapper itself untested |

## Relevant tests and helpers

- `test/widget/board_canvas_screen_test.dart` directly inspects
  `AlignedPhotoLayer` and intrinsic raster layout through injected assets/images.
- Its `_FakeAlignedPhotoAssetLoader` and `_fakeAlignedPhotoImage` isolate I/O.
- Reopen, missing/non-directory, changed-byte and bounds cases prove host/child
  orchestration under those fakes, not real local-loader behavior.
- `test/unit/photo_alignment_transform_test.dart` owns pure coordinate math.
- `test/unit/photo_event_read_model_test.dart` owns primary identity and bounds.
- No production caller or direct test of `ProjectAlignedPhotoLayer` was found
  outside this file in the current Dart source/test set.

## Dangerous combinations

- Constraining the image to the board before transformation changes its basis.
- Moving ClipRect inside the transformed raster changes the clipping viewport.
- Assuming IgnorePointer validates geometry conflates input and render safety.
- Hash/metadata read and later Image.file rendering are separate reads;
  no atomic immutable byte snapshot spans both.
- Treating injected loader tests as real filesystem containment evidence
  overstates coverage.

## Safe SNIPER slices

- Path/read guard: local loader plus exact path helper/caller inputs.
- Decode metadata: codec/hash/disposal plus intrinsic dimension consumers.
- Raster matrix/layout: stateless layer plus landscape/portrait geometry cases.
- Wrapper reload: identity predicate and current Future presentation.
- Warning/digest: bounded render branch plus the relevant upstream contracts.

## Future extraction seams

[S] Loader, stateless renderer and optional stateful wrapper are distinct
read-only boundaries. No reorganization is prescribed.

## Freshness and review triggers

Review path syntax/containment, decoding/hash/disposal, matrix coordinate basis,
OverflowBox/Transform ordering, clipping/pointer/opacity, reload identity,
digest/bounds verification and real-versus-fake test claims.

## Known uncertainty

- [D] Current Board uses central loading rather than the stateful wrapper.
- [D] No direct real-loader or wrapper tests were identified.
- [P] Files can change between verification and default Image.file reading;
  this owner does not provide a filesystem transaction or byte cache.
