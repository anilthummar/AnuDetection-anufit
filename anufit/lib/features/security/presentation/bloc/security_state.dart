part of 'security_bloc.dart';

sealed class SecurityState extends Equatable {
  const SecurityState();

  @override
  List<Object?> get props => [];
}

class SecurityInitial extends SecurityState {
  const SecurityInitial();
}

class SecurityLoaded extends SecurityState {
  const SecurityLoaded({required this.encryptionEnabled});

  final bool encryptionEnabled;

  @override
  List<Object?> get props => [encryptionEnabled];
}
