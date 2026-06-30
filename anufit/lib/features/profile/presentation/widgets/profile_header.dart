import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/shared/widgets/design_system.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            name.isEmpty ? 'Your Profile' : name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class EditableProfileForm extends StatefulWidget {
  const EditableProfileForm({
    required this.user,
    required this.onChanged,
    super.key,
  });

  final UserEntity user;
  final ValueChanged<UserEntity> onChanged;

  @override
  State<EditableProfileForm> createState() => _EditableProfileFormState();
}

class _EditableProfileFormState extends State<EditableProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _goalController;
  late Gender _gender;
  late UnitSystem _unit;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _goalController = TextEditingController();
    _applyUser(widget.user);
  }

  @override
  void didUpdateWidget(covariant EditableProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user != widget.user) {
      _applyUser(widget.user);
    }
  }

  void _applyUser(UserEntity user) {
    _nameController.text = user.name ?? '';
    _ageController.text = '${user.age}';
    _heightController.text = _heightDisplay(user);
    _weightController.text = _weightDisplay(user);
    _goalController.text = '${user.dailyGoal}';
    _gender = user.gender;
    _unit = user.unit;
  }

  String _heightDisplay(UserEntity user) {
    if (user.unit == UnitSystem.imperial) {
      return UnitFormat.displayHeight(user.height, user.unit).toStringAsFixed(0);
    }
    return user.height.toStringAsFixed(0);
  }

  String _weightDisplay(UserEntity user) {
    return UnitFormat.displayWeight(user.weight, user.unit).toStringAsFixed(1);
  }

  double _heightToCm(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) return widget.user.height;
    return _unit == UnitSystem.imperial ? parsed * 2.54 : parsed;
  }

  double _weightToKg(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) return widget.user.weight;
    return _unit == UnitSystem.imperial ? parsed / 2.20462 : parsed;
  }

  void _emit() {
    widget.onChanged(
      UserEntity(
        id: widget.user.id,
        name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
        age: int.tryParse(_ageController.text) ?? widget.user.age,
        gender: _gender,
        height: _heightToCm(_heightController.text),
        weight: _weightToKg(_weightController.text),
        dailyGoal: int.tryParse(_goalController.text) ?? widget.user.dailyGoal,
        strideLength: widget.user.strideLength,
        unit: _unit,
        autoStride: widget.user.autoStride,
        walkingSpeed: widget.user.walkingSpeed,
        createdAt: widget.user.createdAt,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightLabel = _unit == UnitSystem.imperial ? 'Height (in)' : 'Height (cm)';
    final weightLabel = _unit == UnitSystem.imperial ? 'Weight (lb)' : 'Weight (kg)';
    final user = widget.user;

    return Column(
      children: [
        AppTextField(
          label: 'Name',
          controller: _nameController,
          onChanged: (_) => _emit(),
        ),
        const SizedBox(height: 12),
        AppTextField(
          label: 'Age',
          controller: _ageController,
          keyboardType: TextInputType.number,
          onChanged: (_) => _emit(),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<Gender>(
          initialValue: _gender,
          decoration: const InputDecoration(labelText: 'Gender'),
          items: Gender.values
              .map((g) => DropdownMenuItem(value: g, child: Text(g.name)))
              .toList(),
          onChanged: (g) {
            if (g == null) return;
            setState(() => _gender = g);
            _emit();
          },
        ),
        const SizedBox(height: 12),
        AppTextField(
          label: heightLabel,
          controller: _heightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _emit(),
        ),
        const SizedBox(height: 12),
        AppTextField(
          label: weightLabel,
          controller: _weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _emit(),
        ),
        const SizedBox(height: 12),
        AppTextField(
          label: 'Daily step goal',
          controller: _goalController,
          keyboardType: TextInputType.number,
          onChanged: (_) => _emit(),
        ),
        const SizedBox(height: 12),
        SegmentedButton<UnitSystem>(
          segments: const [
            ButtonSegment(value: UnitSystem.metric, label: Text('Metric')),
            ButtonSegment(value: UnitSystem.imperial, label: Text('Imperial')),
          ],
          selected: {_unit},
          onSelectionChanged: (s) {
            setState(() {
              _unit = s.first;
              _heightController.text = _heightDisplay(user.copyWith(unit: _unit));
              _weightController.text = _weightDisplay(user.copyWith(unit: _unit));
            });
            _emit();
          },
        ),
        const SizedBox(height: 12),
        Text(
          'BMI: ${HealthMetricsEngine.bmi(weightKg: _weightToKg(_weightController.text), heightCm: _heightToCm(_heightController.text)).toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

extension on UserEntity {
  UserEntity copyWith({UnitSystem? unit}) {
    return UserEntity(
      id: id,
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      dailyGoal: dailyGoal,
      strideLength: strideLength,
      unit: unit ?? this.unit,
      autoStride: autoStride,
      walkingSpeed: walkingSpeed,
      createdAt: createdAt,
    );
  }
}
