import 'package:flutter/material.dart';

/// Full-width segmented control where each segment gets equal space (no horizontal scroll).
class FitSegmentedControl<T> extends StatelessWidget {
  const FitSegmentedControl({
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<({T value, String label})> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = colorScheme.outline.withValues(alpha: 0.35);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Row(
          children: [
            for (var i = 0; i < segments.length; i++) ...[
              if (i > 0) VerticalDivider(width: 1, thickness: 1, color: borderColor),
              Expanded(
                child: _SegmentTile(
                  label: segments[i].label,
                  selected: segments[i].value == selected,
                  onTap: () => onChanged(segments[i].value),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SegmentTile extends StatelessWidget {
  const _SegmentTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = selected ? colorScheme.primaryContainer : colorScheme.surface;
    final fg = selected ? colorScheme.onPrimaryContainer : colorScheme.onSurface;

    return Material(
      color: bg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: fg,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 12,
                ),
          ),
        ),
      ),
    );
  }
}
