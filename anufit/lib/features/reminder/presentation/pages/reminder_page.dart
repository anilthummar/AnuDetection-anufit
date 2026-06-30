import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/reminder/domain/entities/reminder_entity.dart';
import 'package:anufit/features/reminder/presentation/bloc/reminder_bloc.dart';
import 'package:anufit/features/reminder/presentation/widgets/reminder_tile.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEditor(context),
          ),
        ],
      ),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          return switch (state) {
            ReminderLoading() || ReminderInitial() => const Center(child: CircularProgressIndicator()),
            ReminderError(:final message) => Center(child: Text(message)),
            ReminderLoaded(:final reminders) => ListView(
                children: reminders
                    .map(
                      (r) => ReminderTile(
                        reminder: r,
                        onToggle: (enabled) => context
                            .read<ReminderBloc>()
                            .add(ReminderToggleRequested(id: r.id, enabled: enabled)),
                        onTap: () => _showEditor(context, existing: r),
                      ),
                    )
                    .toList(),
              ),
          };
        },
      ),
    );
  }

  Future<void> _showEditor(BuildContext context, {ReminderEntity? existing}) async {
    final titleController = TextEditingController(text: existing?.title ?? '');
    final descController = TextEditingController(text: existing?.description ?? '');
    var hour = existing?.hour ?? 9;
    var minute = existing?.minute ?? 0;
    var repeat = existing?.repeat ?? ReminderRepeat.daily;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(label: 'Title', controller: titleController),
              AppTextField(label: 'Description', controller: descController),
              SchedulePicker(
                hour: hour,
                minute: minute,
                onChanged: (h, m) {
                  hour = h;
                  minute = m;
                },
              ),
              DropdownButtonFormField<ReminderRepeat>(
                value: repeat,
                decoration: const InputDecoration(labelText: 'Repeat'),
                items: ReminderRepeat.values
                    .map((r) => DropdownMenuItem(value: r, child: Text(r.name)))
                    .toList(),
                onChanged: (v) => repeat = v ?? repeat,
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Save',
                onPressed: () {
                  final reminder = ReminderEntity(
                    id: existing?.id ?? 0,
                    title: titleController.text,
                    description: descController.text,
                    type: existing?.type ?? ReminderType.custom,
                    repeat: repeat,
                    hour: hour,
                    minute: minute,
                    enabled: existing?.enabled ?? true,
                    notificationId: existing?.notificationId ?? 0,
                  );
                  context.read<ReminderBloc>().add(ReminderSaveRequested(reminder));
                  Navigator.pop(ctx);
                },
              ),
              if (existing != null) ...[
                const SizedBox(height: 8),
                AppButton(
                  label: 'Delete',
                  variant: AppButtonVariant.secondary,
                  onPressed: () {
                    context.read<ReminderBloc>().add(ReminderDeleteRequested(existing.id));
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
