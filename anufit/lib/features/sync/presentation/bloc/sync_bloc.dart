import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/sync/data/repository/google_drive_sync_repository.dart';
import 'package:anufit/features/sync/data/repository/icloud_sync_repository.dart';

part 'sync_event.dart';
part 'sync_state.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc(
    @Named('googleDrive') GoogleDriveSyncRepository googleDrive,
    @Named('iCloud') ICloudSyncRepository iCloud,
  )   : _googleDrive = googleDrive,
        _iCloud = iCloud,
        super(const SyncInitial()) {
    on<SyncLoadRequested>(_onLoad);
  }

  final GoogleDriveSyncRepository _googleDrive;
  final ICloudSyncRepository _iCloud;

  Future<void> _onLoad(SyncLoadRequested event, Emitter<SyncState> emit) async {
    emit(const SyncLoading());
    emit(SyncLoaded(
      providers: [
        CloudProviderStatus(
          name: _googleDrive.providerName,
          available: await _googleDrive.isAvailable(),
          connected: await _googleDrive.isConnected(),
        ),
        CloudProviderStatus(
          name: _iCloud.providerName,
          available: await _iCloud.isAvailable(),
          connected: await _iCloud.isConnected(),
        ),
      ],
    ));
  }
}

class CloudProviderStatus extends Equatable {
  const CloudProviderStatus({
    required this.name,
    required this.available,
    required this.connected,
  });

  final String name;
  final bool available;
  final bool connected;

  @override
  List<Object?> get props => [name, available, connected];
}
