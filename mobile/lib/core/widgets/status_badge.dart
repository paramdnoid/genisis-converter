import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../theme/app_theme.dart';

enum StatusBadgeTone { neutral, success, warning, error }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    required this.icon,
    this.tone = StatusBadgeTone.neutral,
    super.key,
  });

  final String label;
  final IconData icon;
  final StatusBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _colorForTone(theme, tone);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _colorForTone(ThemeData theme, StatusBadgeTone tone) {
  final semanticColors = theme.extension<AppSemanticColors>()!;

  return switch (tone) {
    StatusBadgeTone.neutral => theme.colorScheme.primary,
    StatusBadgeTone.success => semanticColors.success,
    StatusBadgeTone.warning => semanticColors.warning,
    StatusBadgeTone.error => theme.colorScheme.error,
  };
}
