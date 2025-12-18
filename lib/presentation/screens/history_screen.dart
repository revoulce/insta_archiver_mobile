import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_archiver_mobile/data/models/task_log_model.dart';
import 'package:insta_archiver_mobile/presentation/blocs/history_cubit.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryCubit>().loadHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => context.read<HistoryCubit>().clearHistory(),
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, List<TaskLogModel>>(
        builder: (context, logs) {
          if (logs.isEmpty) {
            return const Center(child: Text('No history yet'));
          }
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final isError = log.status == 'error';
              return ListTile(
                leading: Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: isError ? Colors.red : Colors.green,
                ),
                title: Text(
                  log.url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${DateFormat('MM/dd HH:mm').format(log.date)} • ${log.message}',
                  style: TextStyle(
                    color: isError ? Colors.red[300] : Colors.grey,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
