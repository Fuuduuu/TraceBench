# Code Map: `lib/features/photos/logic/photo_alignment_transform.dart`

- Source: `lib/features/photos/logic/photo_alignment_transform.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — independently testable input/bounds guards, degeneracy checks, similarity solve, affine solve and residual/reflection reporting`
- Audit evidence: `none`

## File purpose

Owns deterministic, pure photo-pixel to normalized-board geometry.
It validates paired points, solves similarity or affine least-squares mappings,
rejects invalid/degenerate geometry and reports residual/reflection evidence.
It does not read images/events, render widgets, select a primary photo, write
canonical evidence or decide whether the human should confirm a preview.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Vocabulary and failures | `PhotoAlignmentTransformType`, `fromCanonicalName`, `PhotoAlignmentFailureKind`, `PhotoAlignmentException`, `photoAlignmentEpsilon` | Supported canonical names and typed mathematical failure reasons. |
| Immutable geometry | `PhotoAlignmentPoint`, `PhotoAlignmentTransform`, `PhotoAlignmentSolution`, `apply`, `determinant`, `isReflected` | Point serialization/equality, matrix application and solution evidence. |
| Input and bounds | `solvePhotoAlignment`, `minimumPairs`, `photoWidth`, `photoHeight` | Equal counts, minimum pairs, finite dimensions and coordinate domains. |
| Relative degeneracy guards | `_PointSetStats`, `_rejectNearDuplicates` | Centroid/diagonal statistics, spread and normalized near-duplicate rejection. |
| Similarity solve | `_solveSimilarity`, `normalizedScale` | Rotation, positive scale and translation using normalized dot/cross sums. |
| Affine solve | `_solveAffine`, `normal`, `rhsX`, `rhsY`, `normalizedDeterminant` | Normal equations for shear/scale/rotation/reflection and singularity rejection. |
| Linear system | `_solveLinear3`, `augmented`, `pivotMagnitude` | Scaled partial-pivot elimination with rank/non-finite guards. |
| Residual evidence | `squaredResidualSum`, `rmsResidual`, `maxResidual` | Validates finite result and computes normalized-board residual statistics. |

## State and data flow

1. [D] Callers supply type and ordered photo/board point lists. Intrinsic width
   and height are optional together, never independently supplied.
2. [D] Similarity requires at least two equal pairs; affine at least three.
   Every coordinate must be finite; photo coordinates must be nonnegative.
3. [D] When dimensions are supplied they must be finite/positive and photo
   coordinates must remain within inclusive intrinsic bounds.
   Board coordinates are always constrained to inclusive 0..1.
4. [D] Point-set centroids and bounding diagonals establish normalized bases.
   Near-zero spread and duplicate/near-duplicate points fail before solving.
5. [D] Similarity uses normalized dot/cross sums and a strictly positive
   nonsingular scale. This form cannot represent a mirror transformation.
6. [D] Affine builds a normalized 3×3 system for each output coordinate.
   Partial-pivot solving rejects rank-deficient/near-collinear source geometry;
   normalized determinant magnitude rejects singular output mapping.
7. [D] A negative affine determinant is accepted and exposed as reflection.
   It is a visual warning condition, not an automatic failure.
8. [D] Coefficients are denormalized into a 2×3 photo-to-board transform.
   Coefficients/determinant must remain finite.
9. [D] Applying the transform to every paired photo point produces RMS and
   maximum residual in board-normalized units; residuals must remain finite.
10. [D] The solution returns immutable scalar geometry and evidence to callers.
    The solver sets no quality threshold and writes no quality label or event.

## Numerical contract

- `photoAlignmentEpsilon` is `1e-9`.
- Spread checks use the point-set diagonal; duplicate distances are normalized
  by that diagonal.
- Similarity scale and affine determinant are checked in normalized coordinates.
- Linear pivots are compared with epsilon times the matrix's maximum magnitude.
- Input order preserves pair correspondence. Overdetermined solutions fit all
  supplied pairs rather than discarding points after the minimum.
- Matrix application does not itself enforce bounds on arbitrary new points.
  Bounds validation belongs to the paired inputs in `solvePhotoAlignment`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:math` | pure primitive | Square root, min/max and residual/statistical arithmetic. |
| `photo_event_read_model.dart` | production caller | Derives valid event solutions, then re-solves primary alignments with dimensions. |
| `photo_event_writer.dart` | protected caller | Validates request geometry before alignment event dispatch. |
| `photo_workbench_panel.dart` | UI/confirm caller | Computes draft preview and validates freshly loaded dimensions on confirm. |
| `aligned_photo_layer.dart` | read-only caller | Alternate project layer validates loaded intrinsic dimensions before rendering. |
| `board_canvas_screen.dart` | type/solution consumer | Uses typed points and solutions in capture/render orchestration. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| all value types and solve helpers | `ZERO_WRITE` | [D] Pure arithmetic and immutable return values. |
| failures | `ZERO_WRITE` | [D] Throws typed validation evidence only. |
| point `toJson` | `ZERO_WRITE` | [D] Builds an in-memory map; does not append or persist it. |
| caller confirmation | downstream `CANONICAL_EVENT`, outside this owner | [D] Writer/panel decides explicit canonical action. |

No event/session/provider/filesystem API is imported. A valid transform is not
canonical evidence until a separately owned human-confirmed writer persists
its point/type payload. It does not establish electrical or measurement truth.

## Zero-write zones

- Type-name lookup and value equality/hash/serialization.
- Pair count, finiteness, dimension/domain and degeneracy checks.
- Both least-squares solves, matrix application and residual/reflection.
- No hidden state, file cache, background task or projection update.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Input/bounds | [D] shared public solver | UI, writer and reopened primary selection | `ZERO_WRITE` | degeneracy/bounds unit group |
| Similarity | [D] dot/cross least squares | preview and event reader | `ZERO_WRITE` | two similarity cases |
| Affine/rank | [D] normal equations and pivot solver | mirror preview / validator parity | `ZERO_WRITE` | affine and rank cases |
| Residual/reflection | [D] computed solution fields | preview display and warning | `ZERO_WRITE` | deterministic/reflection unit cases and Board preview |
| Value contract | [D] points and matrix fields | event serialization and renderer matrix | `ZERO_WRITE` | solver and writer/read-model suites |

## Relevant tests and helpers

- `test/unit/photo_alignment_transform_test.dart` has ten pure tests in
  similarity, affine and degeneracy/bounds groups.
- `_similarityTarget`, `_affineTarget` and `_expectPointClose` define independent
  expected mappings and approximate coordinate comparisons.
- Unit tests cover exact/overdetermined mappings, reorder stability, reflection,
  bounds/non-finite values, duplicates/spread, rank and singularity.
- `test/unit/photo_event_read_model_test.dart` covers rejected geometric payloads
  and primary re-solving with current dimensions.
- `test/unit/photo_event_writer_test.dart` covers validation before dispatch.
- Board widget alignment cases cover preview/type/mirror/cancel and raster use.

## Dangerous combinations

- Comparing intrinsic pixels directly with normalized-board tolerances mixes bases.
- Duplicate tests and rank tests protect different geometric failures.
- Accepting affine reflection does not imply similarity can mirror.
- Replacing residual evidence with an automatic quality decision changes ownership.
- Changing point ordering without preserving pairs changes the fitted mapping.

## Safe SNIPER slices

- One input guard plus its typed-failure unit cases.
- Similarity arithmetic plus exact/overdetermined mapping evidence.
- Affine rank/determinant plus collinear/singular/reflection cases.
- Residual fields plus preview consumer and numerical unit evidence.
- Value representation plus writer/read-model/renderer consumers.

## Future extraction seams

[S] Vocabulary, normalized solvers and solution evidence are cohesive pure
review boundaries. No extraction or API change is prescribed.

## Freshness and review triggers

Review types/names, epsilon normalization, bounds, minimum pairs, rank/scale,
coefficients, residual units, reflection and direct caller assumptions.

## Known uncertainty

- [D] No intrinsic upper bound can be checked when dimensions are omitted.
- [D] Finite residual is not proof that the human selected correct correspondences.
- [P] Extremely ill-conditioned floating-point inputs depend on the current
  normalization/tolerance behavior characterized by targeted unit cases.
