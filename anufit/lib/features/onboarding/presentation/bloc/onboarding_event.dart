part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

final class OnboardingResumeAt extends OnboardingEvent {
  const OnboardingResumeAt(this.step);

  final OnboardingStep step;

  @override
  List<Object?> get props => [step];
}

final class OnboardingGoToStep extends OnboardingEvent {
  const OnboardingGoToStep(this.step);

  final OnboardingStep step;

  @override
  List<Object?> get props => [step];
}

final class OnboardingNextStep extends OnboardingEvent {
  const OnboardingNextStep();
}
