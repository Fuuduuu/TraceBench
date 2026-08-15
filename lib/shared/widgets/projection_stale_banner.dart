import 'package:flutter/material.dart';

import '../models/project_state.dart';

class ProjectionStaleBanner extends StatelessWidget {
  const ProjectionStaleBanner({
    super.key,
    required this.freshness,
    this.compact = false,
    this.showSecondary = true,
    this.contextLabel,
  });

  static const String stalePrimaryText =
      'Projektsiooni andmed võivad olla aegunud.';
  static const String staleSecondaryText =
      'See vaade võib põhineda varasemal known_facts projektsioonil.';
  static const String staleTagText = 'Aegunud';
  static const String unknownPrimaryText =
      'Projektsiooni värskust ei saa kontrollida.';
  static const String unknownSecondaryText =
      'Provenantsiinfo puudub, ei ole toetatud või on vigane.';
  static const String unknownTagText = 'Kontrollimata';

  static const String primaryText = stalePrimaryText;
  static const String secondaryText = staleSecondaryText;
  static const String passiveTagText = staleTagText;

  final ProjectionFreshness freshness;
  final bool compact;
  final bool showSecondary;
  final String? contextLabel;

  @override
  Widget build(BuildContext context) {
    if (freshness == ProjectionFreshness.fresh) {
      return const SizedBox.shrink();
    }

    final (primaryText, secondaryText, tagText) = switch (freshness) {
      ProjectionFreshness.stale => (
          stalePrimaryText,
          staleSecondaryText,
          staleTagText,
        ),
      ProjectionFreshness.unknown => (
          unknownPrimaryText,
          unknownSecondaryText,
          unknownTagText,
        ),
      ProjectionFreshness.fresh => throw StateError('fresh renders nothing'),
    };
    final effectiveSecondaryVisible = showSecondary && !compact;
    final theme = Theme.of(context);
    final containerColor = freshness == ProjectionFreshness.stale
        ? theme.colorScheme.secondaryContainer
        : theme.colorScheme.tertiaryContainer;
    final foregroundColor = freshness == ProjectionFreshness.stale
        ? theme.colorScheme.onSecondaryContainer
        : theme.colorScheme.onTertiaryContainer;

    return Semantics(
      container: true,
      label: '$primaryText${contextLabel == null ? '' : ' · $contextLabel'}',
      child: Card(
        color: containerColor,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Padding(
          padding: EdgeInsets.all(compact ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    semanticLabel: '',
                    color: foregroundColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      primaryText,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: foregroundColor,
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
                      tagText,
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
                    color: foregroundColor,
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
