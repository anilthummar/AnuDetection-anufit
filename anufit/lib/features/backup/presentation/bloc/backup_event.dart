part of 'backup_bloc.dart';

sealed class BackupEvent extends Equatable {
  const BackupEvent();

  @override
  List<Object?> get props => [];
}

class BackupExportRequested extends BackupEvent {
  const BackupExportRequested({this.encrypt = true, this.passphrase});

  final bool encrypt;
  final String? passphrase;

  @override
  List<Object?> get props => [encrypt, passphrase];
}

class BackupRestoreRequested extends BackupEvent {
  const BackupRestoreRequested({required this.path, this.passphrase});

  final String path;
  final String? passphrase;

  @override
  List<Object?> get props => [path, passphrase];
}
