part of 'sync_bloc.dart';

sealed class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object?> get props => [];
}

class SyncInitial extends SyncState {
  const SyncInitial();
}

class SyncLoading extends SyncState {
  const SyncLoading();
}

class SyncLoaded extends SyncState {
  const SyncLoaded({required this.providers});

  final List<CloudProviderStatus> providers;

  @override
  List<Object?> get props => [providers];
}
