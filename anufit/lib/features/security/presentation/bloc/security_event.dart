part of 'security_bloc.dart';

sealed class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object?> get props => [];
}

class SecurityLoadRequested extends SecurityEvent {
  const SecurityLoadRequested();
}

class SecurityEncryptionToggled extends SecurityEvent {
  const SecurityEncryptionToggled(this.enabled);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}
