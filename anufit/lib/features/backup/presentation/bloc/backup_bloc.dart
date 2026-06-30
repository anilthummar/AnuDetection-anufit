import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import 'package:anufit/core/backup_engine/backup_engine.dart';
import 'package:anufit/features/backup/domain/repository/backup_repository.dart';

part 'backup_event.dart';
part 'backup_state.dart';

@injectable
class BackupBloc extends Bloc<BackupEvent, BackupState> {
  BackupBloc(this._repository) : super(const BackupInitial()) {
    on<BackupExportRequested>(_onExport);
    on<BackupRestoreRequested>(_onRestore);
  }

  final BackupRepository _repository;

  Future<void> _onExport(BackupExportRequested event, Emitter<BackupState> emit) async {
    emit(const BackupLoading());
    try {
      final file = await _repository.exportBackup(
        encrypt: event.encrypt,
        passphrase: event.passphrase,
      );
      await Share.shareXFiles([XFile(file.path)], text: 'Step Counter backup');
      emit(BackupExported(file: file));
    } catch (e) {
      emit(BackupError(e.toString()));
    }
  }

  Future<void> _onRestore(BackupRestoreRequested event, Emitter<BackupState> emit) async {
    emit(const BackupLoading());
    try {
      await _repository.restoreBackup(event.path, passphrase: event.passphrase);
      emit(const BackupRestored());
    } catch (e) {
      emit(BackupError(e.toString()));
    }
  }
}
