import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title, style: Theme.of(context).textTheme.titleSmall),
        ),
        ...children,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({required this.value, required this.onChanged, super.key});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'system', label: Text('System')),
        ButtonSegment(value: 'light', label: Text('Light')),
        ButtonSegment(value: 'dark', label: Text('Dark')),
      ],
      selected: {value},
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

class UnitSelector extends StatelessWidget {
  const UnitSelector({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Units'),
      subtitle: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
