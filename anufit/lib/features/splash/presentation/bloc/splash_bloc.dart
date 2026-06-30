import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/features/splash/domain/usecases/initialize_splash_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._initializeSplash) : super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  final InitializeSplashUseCase _initializeSplash;

  Future<void> _onStarted(SplashStarted event, Emitter<SplashState> emit) async {
    emit(const SplashLoading());
    try {
      await Future<void>.delayed(const Duration(milliseconds: 1500));
      final result = await _initializeSplash();
      if (result.isOnboardingComplete) {
        emit(const SplashNavigateDashboard());
      } else {
        emit(SplashNavigateOnboarding(result.resumeStep!));
      }
    } on Object catch (error) {
      emit(SplashError(error.toString()));
    }
  }
}
