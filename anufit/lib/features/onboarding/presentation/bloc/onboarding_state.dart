part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    required this.currentStep,
    required this.totalSteps,
  });

  final OnboardingStep currentStep;
  final int totalSteps;

  int get stepIndex => OnboardingStep.values.indexOf(currentStep) + 1;

  OnboardingState copyWith({OnboardingStep? currentStep}) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps,
    );
  }

  @override
  List<Object?> get props => [currentStep, totalSteps];
}
