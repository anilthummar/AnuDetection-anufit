part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.user,
    required this.draft,
    this.isSaving = false,
    this.saveMessage,
  });

  final UserEntity user;
  final UserEntity draft;
  final bool isSaving;
  final String? saveMessage;

  ProfileViewData get view => ProfileViewData(user: draft);

  ProfileLoaded copyWith({
    UserEntity? user,
    UserEntity? draft,
    bool? isSaving,
    String? saveMessage,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      draft: draft ?? this.draft,
      isSaving: isSaving ?? this.isSaving,
      saveMessage: saveMessage,
    );
  }

  @override
  List<Object?> get props => [user, draft, isSaving, saveMessage];
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
