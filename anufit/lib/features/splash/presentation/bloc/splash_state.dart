part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashNavigateDashboard extends SplashState {
  const SplashNavigateDashboard();
}

final class SplashNavigateOnboarding extends SplashState {
  const SplashNavigateOnboarding(this.step);

  final OnboardingStep step;

  @override
  List<Object?> get props => [step];
}

final class SplashError extends SplashState {
  const SplashError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
