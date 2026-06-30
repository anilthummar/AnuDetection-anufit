import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/security/secure_storage_service.dart';

part 'security_event.dart';
part 'security_state.dart';

@injectable
class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc(this._secureStorage) : super(const SecurityInitial()) {
    on<SecurityLoadRequested>(_onLoad);
    on<SecurityEncryptionToggled>(_onToggle);
  }

  final SecureStorageService _secureStorage;

  Future<void> _onLoad(SecurityLoadRequested event, Emitter<SecurityState> emit) async {
    final enabled = await _secureStorage.isEncryptionEnabled();
    emit(SecurityLoaded(encryptionEnabled: enabled));
  }

  Future<void> _onToggle(SecurityEncryptionToggled event, Emitter<SecurityState> emit) async {
    await _secureStorage.setEncryptionEnabled(event.enabled);
    emit(SecurityLoaded(encryptionEnabled: event.enabled));
  }
}
