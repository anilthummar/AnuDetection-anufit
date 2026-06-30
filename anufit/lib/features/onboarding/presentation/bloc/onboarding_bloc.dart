import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(this._saveStep) : super(OnboardingState(
        currentStep: OnboardingStep.welcome,
        totalSteps: OnboardingStep.values.length,
      )) {
    on<OnboardingResumeAt>(_onResumeAt);
    on<OnboardingGoToStep>(_onGoToStep);
    on<OnboardingNextStep>(_onNextStep);
  }

  final SaveOnboardingStepUseCase _saveStep;

  void _onResumeAt(OnboardingResumeAt event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  Future<void> _onGoToStep(OnboardingGoToStep event, Emitter<OnboardingState> emit) async {
    await _saveStep(event.step);
    emit(state.copyWith(currentStep: event.step));
  }

  Future<void> _onNextStep(OnboardingNextStep event, Emitter<OnboardingState> emit) async {
    final next = state.currentStep.next;
    if (next != null) {
      await _saveStep(next);
      emit(state.copyWith(currentStep: next));
    }
  }
}
