part of 'goal_bloc.dart';

class GoalState extends Equatable {
  const GoalState({
    this.selectedGoal = 10000,
    this.customGoal = '',
    this.isCustom = false,
    this.isSaving = false,
    this.isSaved = false,
  });

  static const List<int> presets = [3000, 5000, 8000, 10000, 12000, 15000];

  final int selectedGoal;
  final String customGoal;
  final bool isCustom;
  final bool isSaving;
  final bool isSaved;

  GoalState copyWith({
    int? selectedGoal,
    String? customGoal,
    bool? isCustom,
    bool? isSaving,
    bool? isSaved,
  }) {
    return GoalState(
      selectedGoal: selectedGoal ?? this.selectedGoal,
      customGoal: customGoal ?? this.customGoal,
      isCustom: isCustom ?? this.isCustom,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  int get effectiveGoal {
    if (isCustom) {
      return int.tryParse(customGoal) ?? selectedGoal;
    }
    return selectedGoal;
  }

  @override
  List<Object?> get props => [selectedGoal, customGoal, isCustom, isSaving, isSaved];
}
