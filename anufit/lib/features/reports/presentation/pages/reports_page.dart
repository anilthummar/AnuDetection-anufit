import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/features/reports/presentation/bloc/report_bloc.dart';
import 'package:anufit/features/reports/presentation/widgets/export_dialog.dart';
import 'package:anufit/features/reports/presentation/widgets/report_card.dart';
import 'package:anufit/features/reports/presentation/widgets/report_preview.dart';
import 'package:anufit/features/reports/presentation/widgets/share_button.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ResponsiveContainer(
        child: BlocConsumer<ReportBloc, ReportState>(
          listener: (context, state) {
            if (state is ReportError) {
              AppSnackBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                for (final period in ReportPeriod.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ReportCard(
                      period: period,
                      onTap: () => context.read<ReportBloc>().add(
                            ReportPreviewRequested(period: period),
                          ),
                    ),
                  ),
                if (state is ReportLoading) const LinearProgressIndicator(),
                if (state is ReportPreviewLoaded) ...[
                  const SizedBox(height: AppSpacing.lg),
                  ReportPreview(data: state.data),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Export',
                    onPressed: () => ExportDialog.show(
                      context,
                      onExport: (format) => context.read<ReportBloc>().add(
                            ReportExportRequested(
                              format: format,
                              data: state.data,
                            ),
                          ),
                    ),
                  ),
                ],
                if (state is ReportExported) ...[
                  const SizedBox(height: AppSpacing.lg),
                  ReportPreview(data: state.data),
                  const SizedBox(height: AppSpacing.md),
                  ShareButton(
                    onPressed: () => context.read<ReportBloc>().add(
                          ReportShareRequested(filePath: state.generated.filePath),
                        ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
