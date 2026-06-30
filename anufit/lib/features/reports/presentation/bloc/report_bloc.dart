import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/features/reports/domain/repository/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

@injectable
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(this._repository) : super(const ReportInitial()) {
    on<ReportPreviewRequested>(_onPreview);
    on<ReportExportRequested>(_onExport);
    on<ReportShareRequested>(_onShare);
  }

  final ReportRepository _repository;

  Future<void> _onPreview(ReportPreviewRequested event, Emitter<ReportState> emit) async {
    emit(const ReportLoading());
    try {
      final data = await _repository.buildReport(
        period: event.period,
        customStart: event.customStart,
        customEnd: event.customEnd,
      );
      emit(ReportPreviewLoaded(data: data));
    } catch (error) {
      emit(ReportError(error.toString()));
    }
  }

  Future<void> _onExport(ReportExportRequested event, Emitter<ReportState> emit) async {
    emit(const ReportLoading());
    try {
      final data = event.data ??
          await _repository.buildReport(
            period: event.period,
            customStart: event.customStart,
            customEnd: event.customEnd,
          );
      final generated = await _repository.exportReport(data: data, format: event.format);
      emit(ReportExported(generated: generated, data: data));
    } catch (error) {
      emit(ReportError(error.toString()));
    }
  }

  Future<void> _onShare(ReportShareRequested event, Emitter<ReportState> emit) async {
    try {
      await Share.shareXFiles(
        [XFile(event.filePath)],
        text: 'My Step Counter activity report',
      );
    } catch (error) {
      emit(ReportError(error.toString()));
    }
  }
}
