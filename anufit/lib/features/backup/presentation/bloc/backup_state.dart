part of 'backup_bloc.dart';

sealed class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object?> get props => [];
}

class BackupInitial extends BackupState {
  const BackupInitial();
}

class BackupLoading extends BackupState {
  const BackupLoading();
}

class BackupExported extends BackupState {
  const BackupExported({required this.file});

  final BackupFile file;

  @override
  List<Object?> get props => [file];
}

class BackupRestored extends BackupState {
  const BackupRestored();
}

class BackupError extends BackupState {
  const BackupError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
