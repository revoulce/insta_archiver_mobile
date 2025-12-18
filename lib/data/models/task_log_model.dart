import 'package:hive/hive.dart';

part 'task_log_model.g.dart';

@HiveType(typeId: 0)
class TaskLogModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String status; // 'success', 'error'
  @HiveField(3)
  final String message;
  @HiveField(4)
  final DateTime date;

  TaskLogModel({
    required this.id,
    required this.url,
    required this.status,
    required this.message,
    required this.date,
  });
}
