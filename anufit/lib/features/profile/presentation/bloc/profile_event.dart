part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileSaveRequested extends ProfileEvent {
  const ProfileSaveRequested();
}

class ProfileFieldChanged extends ProfileEvent {
  const ProfileFieldChanged(this.user);

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}
