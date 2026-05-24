import 'package:flutter/material.dart';

class ProjectionStaleBanner extends StatelessWidget {
  const ProjectionStaleBanner({
    super.key,
    required this.isStale,
    this.compact = false,
    this.showSecondary = true,
    this.contextLabel,
  });

  static const String primaryText =
      'Mõõtmised lisatud — ekspordi projekti et uuendada kokkuvõtet.';
  static const String secondaryText =
      'Graafik, raport ja kokkuvõtted võivad põhineda vanemal known_facts projektsioonil.';
  static const String passiveTagText = 'Vajab eksporti';

  final bool isStale;
  final bool compact;
  final bool showSecondary;
  final String? contextLabel;

  @override
  Widget build(BuildContext context) {
    if (!isStale) {
      return const SizedBox.shrink();
    }

    final effectiveSecondaryVisible = showSecondary && !compact;
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: '$primaryText${contextLabel == null ? '' : ' · $contextLabel'}',
      child: Card(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.5),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Padding(
          padding: EdgeInsets.all(compact ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, semanticLabel: ''),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      primaryText,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      passiveTagText,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (effectiveSecondaryVisible) ...[
                const SizedBox(height: 6),
                Text(
                  secondaryText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
